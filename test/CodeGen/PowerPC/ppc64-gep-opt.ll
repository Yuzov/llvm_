; RUN: llc -opaque-pointers=0 -verify-machineinstrs -O3 -mcpu=pwr7 < %s | FileCheck %s
; RUN: llc -opaque-pointers=0 -verify-machineinstrs -O3 -print-after=codegenprepare -mcpu=pwr7  < %s >%t 2>&1 && FileCheck --check-prefix=CHECK-UseAA <%t %s
target datalayout = "E-m:e-i64:64-n32:64"
target triple = "powerpc64-unknown-linux-gnu"

; Following test cases test enabling SeparateConstOffsetFromGEP pass in the PPC
; backend. If useAA() returns true, it will lower a GEP with multiple indices
; into GEPs with a single index, otherwise it will lower it into a
; "ptrtoint+arithmetics+inttoptr" form.

%struct = type { i32, i32, i32, i32, [20 x i32] }

; Check that when two complex GEPs are used in two basic blocks, LLVM can
; elimilate the common subexpression for the second use.
define void @test_GEP_CSE([240 x %struct]* %string, i32* %adj, i32 %lib, i64 %idxprom) {
  %liberties = getelementptr [240 x %struct], [240 x %struct]* %string, i64 1, i64 %idxprom, i32 3
  %1 = load i32, i32* %liberties, align 4
  %cmp = icmp eq i32 %1, %lib
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  %origin = getelementptr [240 x %struct], [240 x %struct]* %string, i64 1, i64 %idxprom, i32 2
  %2 = load i32, i32* %origin, align 4
  store i32 %2, i32* %adj, align 4
  br label %if.end

if.end:                                           ; preds = %if.then, %entry
  ret void
}

; CHECK-UseAA-LABEL: @test_GEP_CSE(
; CHECK-UseAA: [[PTR0:%[a-zA-Z0-9]+]] = bitcast [240 x %struct]* %string to i8*
; CHECK-UseAA: [[IDX:%[a-zA-Z0-9]+]] = mul i64 %idxprom, 96
; CHECK-UseAA: [[PTR1:%[a-zA-Z0-9]+]] = getelementptr i8, i8* [[PTR0]], i64 [[IDX]]
; CHECK-UseAA: getelementptr i8, i8* [[PTR1]], i64 23052
; CHECK-UseAA: bitcast
; CHECK-UseAA: if.then:
; CHECK-UseAA: getelementptr i8, i8* [[PTR1]], i64 23048
; CHECK-UseAA: bitcast

%class.my = type { i32, [128 x i32], i32, [256 x %struct.pt]}
%struct.pt = type { %struct.point*, i32, i32 }
%struct.point = type { i32, i32 }

; Check when a GEP is used across two basic block, LLVM can sink the address
; calculation and code gen can generate a better addressing mode for the second
; use.
define void @test_GEP_across_BB(%class.my* %this, i64 %idx) {
  %1 = getelementptr %class.my, %class.my* %this, i64 0, i32 3, i64 %idx, i32 1
  %2 = load i32, i32* %1, align 4
  %3 = getelementptr %class.my, %class.my* %this, i64 0, i32 3, i64 %idx, i32 2
  %4 = load i32, i32* %3, align 4
  %5 = icmp eq i32 %2, %4
  br i1 %5, label %if.true, label %exit

if.true:
  %6 = shl i32 %4, 1
  store i32 %6, i32* %3, align 4
  br label %exit

exit:
  %7 = add nsw i32 %4, 1
  store i32 %7, i32* %1, align 4
  ret void
}
; CHECK-LABEL: test_GEP_across_BB:
; CHECK-NOT: lwzu
; CHECK: blr

; CHECK-UseAA-LABEL: test_GEP_across_BB(
; CHECK-UseAA: [[PTR0:%[a-zA-Z0-9]+]] = getelementptr
; CHECK-UseAA: getelementptr i8, i8* [[PTR0]], i64 528
; CHECK-UseAA: getelementptr i8, i8* [[PTR0]], i64 532
; CHECK-UseAA: if.true:
; CHECK-UseAA: {{%sunk[a-zA-Z0-9]+}} = getelementptr i8, i8* [[PTR0]], i64 532
; CHECK-UseAA: exit:
; CHECK-UseAA: {{%sunk[a-zA-Z0-9]+}} = getelementptr i8, i8* [[PTR0]], i64 528

%struct.S = type { float, double }
@struct_array = global [1024 x %struct.S] zeroinitializer, align 16

; The following two test cases check we can extract constant from indices of
; struct type.
; The constant offsets are from indices "i64 %idxprom" and "i32 1". As the
; alloca size of %struct.S is 16, and "i32 1" is the 2rd element whose field
; offset is 8, the total constant offset is (5 * 16 + 8) = 88.
define double* @test-struct_1(i32 %i) {
entry:
  %add = add nsw i32 %i, 5
  %idxprom = sext i32 %add to i64
  %p = getelementptr [1024 x %struct.S], [1024 x %struct.S]* @struct_array, i64 0, i64 %idxprom, i32 1
  ret double* %p
}
; CHECK-UseAA-LABEL: @test-struct_1(
; CHECK-UseAA: getelementptr i8, i8* %{{[a-zA-Z0-9]+}}, i64 88

%struct3 = type { i64, i32 }
%struct2 = type { %struct3, i32 }
%struct1 = type { i64, %struct2 }
%struct0 = type { i32, i32, i64*, [100 x %struct1] }

; The constant offsets are from indices "i32 3", "i64 %arrayidx" and "i32 1".
; "i32 3" is the 4th element whose field offset is 16. The alloca size of
; %struct1 is 32. "i32 1" is the 2rd element whose field offset is 8. So the
; total constant offset is 16 + (-2 * 32) + 8 = -40
define %struct2* @test-struct_2(%struct0* %ptr, i64 %idx) {
entry:
  %arrayidx = add nsw i64 %idx, -2
  %ptr2 = getelementptr %struct0, %struct0* %ptr, i64 0, i32 3, i64 %arrayidx, i32 1
  ret %struct2* %ptr2
}
; CHECK-UseAA-LABEL: @test-struct_2(
; CHECK-UseAA: getelementptr i8, i8* %{{[a-zA-Z0-9]+}}, i64 -40

; Test that when a index is added from two constant, SeparateConstOffsetFromGEP
; pass does not generate incorrect result.
define void @test_const_add([3 x i32]* %in) {
  %inc = add nsw i32 2, 1
  %idxprom = sext i32 %inc to i64
  %arrayidx = getelementptr [3 x i32], [3 x i32]* %in, i64 %idxprom, i64 2
  store i32 0, i32* %arrayidx, align 4
  ret void
}
; CHECK-LABEL: test_const_add:
; CHECK: li [[REG:[0-9]+]], 0
; CHECK: stw [[REG]], 44(3)
; CHECK: blr

