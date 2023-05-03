; NOTE: Assertions have been autogenerated by utils/update_analyze_test_checks.py
; RUN: opt -passes="print<cost-model>" 2>&1 -disable-output -mtriple=thumbv8.1m.main-none-eabi -mattr=+mve.fp < %s | FileCheck %s --check-prefix=CHECK-MVE-RECIP
; RUN: opt -passes="print<cost-model>" 2>&1 -disable-output -mtriple=thumbv8m.main-none-eabi < %s | FileCheck %s --check-prefix=CHECK-V8M-MAIN-RECIP
; RUN: opt -passes="print<cost-model>" 2>&1 -disable-output -mtriple=thumbv8m.base-none-eabi < %s | FileCheck %s --check-prefix=CHECK-V8M-BASE-RECIP
; RUN: opt -passes="print<cost-model>" 2>&1 -disable-output -mtriple=armv8r-none-eabi < %s | FileCheck %s --check-prefix=CHECK-V8R-RECIP
; RUN: opt -passes="print<cost-model>" 2>&1 -disable-output -cost-kind=code-size -mtriple=thumbv8.1m.main-none-eabi -mattr=+mve.fp < %s | FileCheck %s --check-prefix=CHECK-MVE-SIZE
; RUN: opt -passes="print<cost-model>" 2>&1 -disable-output -cost-kind=code-size -mtriple=thumbv8m.main-none-eabi < %s | FileCheck %s --check-prefix=CHECK-V8M-MAIN-SIZE
; RUN: opt -passes="print<cost-model>" 2>&1 -disable-output -cost-kind=code-size -mtriple=thumbv8m.base-none-eabi < %s | FileCheck %s --check-prefix=CHECK-V8M-BASE-SIZE
; RUN: opt -passes="print<cost-model>" 2>&1 -disable-output -cost-kind=code-size -mtriple=armv8r-none-eabi < %s | FileCheck %s --check-prefix=CHECK-V8R-SIZE

target datalayout = "e-m:e-p:32:32-Fi8-i64:64-v128:64:128-a:0:32-n32-S64"

define i32 @cmps() {
; CHECK-MVE-RECIP-LABEL: 'cmps'
; CHECK-MVE-RECIP-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %a = icmp slt i8 undef, undef
; CHECK-MVE-RECIP-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %b = icmp ult i16 undef, undef
; CHECK-MVE-RECIP-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %c = icmp sge i32 undef, undef
; CHECK-MVE-RECIP-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %d = icmp ne i64 undef, undef
; CHECK-MVE-RECIP-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %e = icmp slt <16 x i8> undef, undef
; CHECK-MVE-RECIP-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %f = icmp ult <8 x i16> undef, undef
; CHECK-MVE-RECIP-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %g = icmp sge <4 x i32> undef, undef
; CHECK-MVE-RECIP-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %a7 = fcmp oge half undef, undef
; CHECK-MVE-RECIP-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %a8 = fcmp ogt float undef, undef
; CHECK-MVE-RECIP-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %a9 = fcmp ogt double undef, undef
; CHECK-MVE-RECIP-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %a10 = fcmp olt <8 x half> undef, undef
; CHECK-MVE-RECIP-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %a11 = fcmp oge <4 x float> undef, undef
; CHECK-MVE-RECIP-NEXT:  Cost Model: Found an estimated cost of 8 for instruction: %a12 = fcmp oge <2 x double> undef, undef
; CHECK-MVE-RECIP-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %p = icmp eq ptr undef, undef
; CHECK-MVE-RECIP-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %q = icmp eq <4 x ptr> undef, undef
; CHECK-MVE-RECIP-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: ret i32 undef
;
; CHECK-V8M-MAIN-RECIP-LABEL: 'cmps'
; CHECK-V8M-MAIN-RECIP-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %a = icmp slt i8 undef, undef
; CHECK-V8M-MAIN-RECIP-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %b = icmp ult i16 undef, undef
; CHECK-V8M-MAIN-RECIP-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %c = icmp sge i32 undef, undef
; CHECK-V8M-MAIN-RECIP-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %d = icmp ne i64 undef, undef
; CHECK-V8M-MAIN-RECIP-NEXT:  Cost Model: Found an estimated cost of 32 for instruction: %e = icmp slt <16 x i8> undef, undef
; CHECK-V8M-MAIN-RECIP-NEXT:  Cost Model: Found an estimated cost of 16 for instruction: %f = icmp ult <8 x i16> undef, undef
; CHECK-V8M-MAIN-RECIP-NEXT:  Cost Model: Found an estimated cost of 8 for instruction: %g = icmp sge <4 x i32> undef, undef
; CHECK-V8M-MAIN-RECIP-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %a7 = fcmp oge half undef, undef
; CHECK-V8M-MAIN-RECIP-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %a8 = fcmp ogt float undef, undef
; CHECK-V8M-MAIN-RECIP-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %a9 = fcmp ogt double undef, undef
; CHECK-V8M-MAIN-RECIP-NEXT:  Cost Model: Found an estimated cost of 16 for instruction: %a10 = fcmp olt <8 x half> undef, undef
; CHECK-V8M-MAIN-RECIP-NEXT:  Cost Model: Found an estimated cost of 8 for instruction: %a11 = fcmp oge <4 x float> undef, undef
; CHECK-V8M-MAIN-RECIP-NEXT:  Cost Model: Found an estimated cost of 6 for instruction: %a12 = fcmp oge <2 x double> undef, undef
; CHECK-V8M-MAIN-RECIP-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %p = icmp eq ptr undef, undef
; CHECK-V8M-MAIN-RECIP-NEXT:  Cost Model: Found an estimated cost of 8 for instruction: %q = icmp eq <4 x ptr> undef, undef
; CHECK-V8M-MAIN-RECIP-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: ret i32 undef
;
; CHECK-V8M-BASE-RECIP-LABEL: 'cmps'
; CHECK-V8M-BASE-RECIP-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %a = icmp slt i8 undef, undef
; CHECK-V8M-BASE-RECIP-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %b = icmp ult i16 undef, undef
; CHECK-V8M-BASE-RECIP-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %c = icmp sge i32 undef, undef
; CHECK-V8M-BASE-RECIP-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %d = icmp ne i64 undef, undef
; CHECK-V8M-BASE-RECIP-NEXT:  Cost Model: Found an estimated cost of 32 for instruction: %e = icmp slt <16 x i8> undef, undef
; CHECK-V8M-BASE-RECIP-NEXT:  Cost Model: Found an estimated cost of 16 for instruction: %f = icmp ult <8 x i16> undef, undef
; CHECK-V8M-BASE-RECIP-NEXT:  Cost Model: Found an estimated cost of 8 for instruction: %g = icmp sge <4 x i32> undef, undef
; CHECK-V8M-BASE-RECIP-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %a7 = fcmp oge half undef, undef
; CHECK-V8M-BASE-RECIP-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %a8 = fcmp ogt float undef, undef
; CHECK-V8M-BASE-RECIP-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %a9 = fcmp ogt double undef, undef
; CHECK-V8M-BASE-RECIP-NEXT:  Cost Model: Found an estimated cost of 16 for instruction: %a10 = fcmp olt <8 x half> undef, undef
; CHECK-V8M-BASE-RECIP-NEXT:  Cost Model: Found an estimated cost of 8 for instruction: %a11 = fcmp oge <4 x float> undef, undef
; CHECK-V8M-BASE-RECIP-NEXT:  Cost Model: Found an estimated cost of 6 for instruction: %a12 = fcmp oge <2 x double> undef, undef
; CHECK-V8M-BASE-RECIP-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %p = icmp eq ptr undef, undef
; CHECK-V8M-BASE-RECIP-NEXT:  Cost Model: Found an estimated cost of 8 for instruction: %q = icmp eq <4 x ptr> undef, undef
; CHECK-V8M-BASE-RECIP-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: ret i32 undef
;
; CHECK-V8R-RECIP-LABEL: 'cmps'
; CHECK-V8R-RECIP-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %a = icmp slt i8 undef, undef
; CHECK-V8R-RECIP-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %b = icmp ult i16 undef, undef
; CHECK-V8R-RECIP-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %c = icmp sge i32 undef, undef
; CHECK-V8R-RECIP-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %d = icmp ne i64 undef, undef
; CHECK-V8R-RECIP-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %e = icmp slt <16 x i8> undef, undef
; CHECK-V8R-RECIP-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %f = icmp ult <8 x i16> undef, undef
; CHECK-V8R-RECIP-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %g = icmp sge <4 x i32> undef, undef
; CHECK-V8R-RECIP-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %a7 = fcmp oge half undef, undef
; CHECK-V8R-RECIP-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %a8 = fcmp ogt float undef, undef
; CHECK-V8R-RECIP-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %a9 = fcmp ogt double undef, undef
; CHECK-V8R-RECIP-NEXT:  Cost Model: Found an estimated cost of 24 for instruction: %a10 = fcmp olt <8 x half> undef, undef
; CHECK-V8R-RECIP-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %a11 = fcmp oge <4 x float> undef, undef
; CHECK-V8R-RECIP-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %a12 = fcmp oge <2 x double> undef, undef
; CHECK-V8R-RECIP-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %p = icmp eq ptr undef, undef
; CHECK-V8R-RECIP-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %q = icmp eq <4 x ptr> undef, undef
; CHECK-V8R-RECIP-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: ret i32 undef
;
; CHECK-MVE-SIZE-LABEL: 'cmps'
; CHECK-MVE-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %a = icmp slt i8 undef, undef
; CHECK-MVE-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %b = icmp ult i16 undef, undef
; CHECK-MVE-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %c = icmp sge i32 undef, undef
; CHECK-MVE-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %d = icmp ne i64 undef, undef
; CHECK-MVE-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %e = icmp slt <16 x i8> undef, undef
; CHECK-MVE-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %f = icmp ult <8 x i16> undef, undef
; CHECK-MVE-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %g = icmp sge <4 x i32> undef, undef
; CHECK-MVE-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %a7 = fcmp oge half undef, undef
; CHECK-MVE-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %a8 = fcmp ogt float undef, undef
; CHECK-MVE-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %a9 = fcmp ogt double undef, undef
; CHECK-MVE-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %a10 = fcmp olt <8 x half> undef, undef
; CHECK-MVE-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %a11 = fcmp oge <4 x float> undef, undef
; CHECK-MVE-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %a12 = fcmp oge <2 x double> undef, undef
; CHECK-MVE-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %p = icmp eq ptr undef, undef
; CHECK-MVE-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %q = icmp eq <4 x ptr> undef, undef
; CHECK-MVE-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: ret i32 undef
;
; CHECK-V8M-MAIN-SIZE-LABEL: 'cmps'
; CHECK-V8M-MAIN-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %a = icmp slt i8 undef, undef
; CHECK-V8M-MAIN-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %b = icmp ult i16 undef, undef
; CHECK-V8M-MAIN-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %c = icmp sge i32 undef, undef
; CHECK-V8M-MAIN-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %d = icmp ne i64 undef, undef
; CHECK-V8M-MAIN-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %e = icmp slt <16 x i8> undef, undef
; CHECK-V8M-MAIN-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %f = icmp ult <8 x i16> undef, undef
; CHECK-V8M-MAIN-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %g = icmp sge <4 x i32> undef, undef
; CHECK-V8M-MAIN-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %a7 = fcmp oge half undef, undef
; CHECK-V8M-MAIN-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %a8 = fcmp ogt float undef, undef
; CHECK-V8M-MAIN-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %a9 = fcmp ogt double undef, undef
; CHECK-V8M-MAIN-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %a10 = fcmp olt <8 x half> undef, undef
; CHECK-V8M-MAIN-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %a11 = fcmp oge <4 x float> undef, undef
; CHECK-V8M-MAIN-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %a12 = fcmp oge <2 x double> undef, undef
; CHECK-V8M-MAIN-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %p = icmp eq ptr undef, undef
; CHECK-V8M-MAIN-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %q = icmp eq <4 x ptr> undef, undef
; CHECK-V8M-MAIN-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: ret i32 undef
;
; CHECK-V8M-BASE-SIZE-LABEL: 'cmps'
; CHECK-V8M-BASE-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %a = icmp slt i8 undef, undef
; CHECK-V8M-BASE-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %b = icmp ult i16 undef, undef
; CHECK-V8M-BASE-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %c = icmp sge i32 undef, undef
; CHECK-V8M-BASE-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %d = icmp ne i64 undef, undef
; CHECK-V8M-BASE-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %e = icmp slt <16 x i8> undef, undef
; CHECK-V8M-BASE-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %f = icmp ult <8 x i16> undef, undef
; CHECK-V8M-BASE-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %g = icmp sge <4 x i32> undef, undef
; CHECK-V8M-BASE-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %a7 = fcmp oge half undef, undef
; CHECK-V8M-BASE-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %a8 = fcmp ogt float undef, undef
; CHECK-V8M-BASE-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %a9 = fcmp ogt double undef, undef
; CHECK-V8M-BASE-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %a10 = fcmp olt <8 x half> undef, undef
; CHECK-V8M-BASE-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %a11 = fcmp oge <4 x float> undef, undef
; CHECK-V8M-BASE-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %a12 = fcmp oge <2 x double> undef, undef
; CHECK-V8M-BASE-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %p = icmp eq ptr undef, undef
; CHECK-V8M-BASE-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %q = icmp eq <4 x ptr> undef, undef
; CHECK-V8M-BASE-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: ret i32 undef
;
; CHECK-V8R-SIZE-LABEL: 'cmps'
; CHECK-V8R-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %a = icmp slt i8 undef, undef
; CHECK-V8R-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %b = icmp ult i16 undef, undef
; CHECK-V8R-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %c = icmp sge i32 undef, undef
; CHECK-V8R-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %d = icmp ne i64 undef, undef
; CHECK-V8R-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %e = icmp slt <16 x i8> undef, undef
; CHECK-V8R-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %f = icmp ult <8 x i16> undef, undef
; CHECK-V8R-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %g = icmp sge <4 x i32> undef, undef
; CHECK-V8R-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %a7 = fcmp oge half undef, undef
; CHECK-V8R-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %a8 = fcmp ogt float undef, undef
; CHECK-V8R-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %a9 = fcmp ogt double undef, undef
; CHECK-V8R-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %a10 = fcmp olt <8 x half> undef, undef
; CHECK-V8R-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %a11 = fcmp oge <4 x float> undef, undef
; CHECK-V8R-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %a12 = fcmp oge <2 x double> undef, undef
; CHECK-V8R-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %p = icmp eq ptr undef, undef
; CHECK-V8R-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %q = icmp eq <4 x ptr> undef, undef
; CHECK-V8R-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: ret i32 undef
;
  %a = icmp slt i8 undef, undef
  %b = icmp ult i16 undef, undef
  %c = icmp sge i32 undef, undef
  %d = icmp ne i64 undef, undef
  %e = icmp slt <16 x i8> undef, undef
  %f = icmp ult <8 x i16> undef, undef
  %g = icmp sge <4 x i32> undef, undef
  %a7 = fcmp oge half undef, undef
  %a8 = fcmp ogt float undef, undef
  %a9 = fcmp ogt double undef, undef
  %a10 = fcmp olt <8 x half> undef, undef
  %a11 = fcmp oge <4 x float> undef, undef
  %a12 = fcmp oge <2 x double> undef, undef
  %p = icmp eq ptr undef, undef
  %q = icmp eq <4 x ptr> undef, undef
  ret i32 undef
}

define void @minmax() {
; CHECK-MVE-RECIP-LABEL: 'minmax'
; CHECK-MVE-RECIP-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %c1 = icmp slt i8 undef, undef
; CHECK-MVE-RECIP-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %s1 = select i1 %c1, i8 undef, i8 undef
; CHECK-MVE-RECIP-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %c2 = icmp slt i16 undef, undef
; CHECK-MVE-RECIP-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %s2 = select i1 %c2, i16 undef, i16 undef
; CHECK-MVE-RECIP-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %c3 = icmp slt i32 undef, undef
; CHECK-MVE-RECIP-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %s3 = select i1 %c3, i32 undef, i32 undef
; CHECK-MVE-RECIP-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: %c4 = icmp slt <4 x i32> undef, undef
; CHECK-MVE-RECIP-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %s4 = select <4 x i1> %c4, <4 x i32> undef, <4 x i32> undef
; CHECK-MVE-RECIP-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %c5 = icmp slt ptr undef, undef
; CHECK-MVE-RECIP-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %s5 = select i1 %c5, ptr undef, ptr undef
; CHECK-MVE-RECIP-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %c6 = icmp slt <4 x ptr> undef, undef
; CHECK-MVE-RECIP-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %s6 = select <4 x i1> %c6, <4 x ptr> undef, <4 x ptr> undef
; CHECK-MVE-RECIP-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: ret void
;
; CHECK-V8M-MAIN-RECIP-LABEL: 'minmax'
; CHECK-V8M-MAIN-RECIP-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %c1 = icmp slt i8 undef, undef
; CHECK-V8M-MAIN-RECIP-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %s1 = select i1 %c1, i8 undef, i8 undef
; CHECK-V8M-MAIN-RECIP-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %c2 = icmp slt i16 undef, undef
; CHECK-V8M-MAIN-RECIP-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %s2 = select i1 %c2, i16 undef, i16 undef
; CHECK-V8M-MAIN-RECIP-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %c3 = icmp slt i32 undef, undef
; CHECK-V8M-MAIN-RECIP-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %s3 = select i1 %c3, i32 undef, i32 undef
; CHECK-V8M-MAIN-RECIP-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: %c4 = icmp slt <4 x i32> undef, undef
; CHECK-V8M-MAIN-RECIP-NEXT:  Cost Model: Found an estimated cost of 16 for instruction: %s4 = select <4 x i1> %c4, <4 x i32> undef, <4 x i32> undef
; CHECK-V8M-MAIN-RECIP-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %c5 = icmp slt ptr undef, undef
; CHECK-V8M-MAIN-RECIP-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %s5 = select i1 %c5, ptr undef, ptr undef
; CHECK-V8M-MAIN-RECIP-NEXT:  Cost Model: Found an estimated cost of 8 for instruction: %c6 = icmp slt <4 x ptr> undef, undef
; CHECK-V8M-MAIN-RECIP-NEXT:  Cost Model: Found an estimated cost of 8 for instruction: %s6 = select <4 x i1> %c6, <4 x ptr> undef, <4 x ptr> undef
; CHECK-V8M-MAIN-RECIP-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: ret void
;
; CHECK-V8M-BASE-RECIP-LABEL: 'minmax'
; CHECK-V8M-BASE-RECIP-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %c1 = icmp slt i8 undef, undef
; CHECK-V8M-BASE-RECIP-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %s1 = select i1 %c1, i8 undef, i8 undef
; CHECK-V8M-BASE-RECIP-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %c2 = icmp slt i16 undef, undef
; CHECK-V8M-BASE-RECIP-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %s2 = select i1 %c2, i16 undef, i16 undef
; CHECK-V8M-BASE-RECIP-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %c3 = icmp slt i32 undef, undef
; CHECK-V8M-BASE-RECIP-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %s3 = select i1 %c3, i32 undef, i32 undef
; CHECK-V8M-BASE-RECIP-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: %c4 = icmp slt <4 x i32> undef, undef
; CHECK-V8M-BASE-RECIP-NEXT:  Cost Model: Found an estimated cost of 16 for instruction: %s4 = select <4 x i1> %c4, <4 x i32> undef, <4 x i32> undef
; CHECK-V8M-BASE-RECIP-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %c5 = icmp slt ptr undef, undef
; CHECK-V8M-BASE-RECIP-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %s5 = select i1 %c5, ptr undef, ptr undef
; CHECK-V8M-BASE-RECIP-NEXT:  Cost Model: Found an estimated cost of 8 for instruction: %c6 = icmp slt <4 x ptr> undef, undef
; CHECK-V8M-BASE-RECIP-NEXT:  Cost Model: Found an estimated cost of 8 for instruction: %s6 = select <4 x i1> %c6, <4 x ptr> undef, <4 x ptr> undef
; CHECK-V8M-BASE-RECIP-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: ret void
;
; CHECK-V8R-RECIP-LABEL: 'minmax'
; CHECK-V8R-RECIP-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %c1 = icmp slt i8 undef, undef
; CHECK-V8R-RECIP-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %s1 = select i1 %c1, i8 undef, i8 undef
; CHECK-V8R-RECIP-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %c2 = icmp slt i16 undef, undef
; CHECK-V8R-RECIP-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %s2 = select i1 %c2, i16 undef, i16 undef
; CHECK-V8R-RECIP-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %c3 = icmp slt i32 undef, undef
; CHECK-V8R-RECIP-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %s3 = select i1 %c3, i32 undef, i32 undef
; CHECK-V8R-RECIP-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: %c4 = icmp slt <4 x i32> undef, undef
; CHECK-V8R-RECIP-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %s4 = select <4 x i1> %c4, <4 x i32> undef, <4 x i32> undef
; CHECK-V8R-RECIP-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %c5 = icmp slt ptr undef, undef
; CHECK-V8R-RECIP-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %s5 = select i1 %c5, ptr undef, ptr undef
; CHECK-V8R-RECIP-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %c6 = icmp slt <4 x ptr> undef, undef
; CHECK-V8R-RECIP-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %s6 = select <4 x i1> %c6, <4 x ptr> undef, <4 x ptr> undef
; CHECK-V8R-RECIP-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: ret void
;
; CHECK-MVE-SIZE-LABEL: 'minmax'
; CHECK-MVE-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %c1 = icmp slt i8 undef, undef
; CHECK-MVE-SIZE-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %s1 = select i1 %c1, i8 undef, i8 undef
; CHECK-MVE-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %c2 = icmp slt i16 undef, undef
; CHECK-MVE-SIZE-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %s2 = select i1 %c2, i16 undef, i16 undef
; CHECK-MVE-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %c3 = icmp slt i32 undef, undef
; CHECK-MVE-SIZE-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %s3 = select i1 %c3, i32 undef, i32 undef
; CHECK-MVE-SIZE-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: %c4 = icmp slt <4 x i32> undef, undef
; CHECK-MVE-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %s4 = select <4 x i1> %c4, <4 x i32> undef, <4 x i32> undef
; CHECK-MVE-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %c5 = icmp slt ptr undef, undef
; CHECK-MVE-SIZE-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %s5 = select i1 %c5, ptr undef, ptr undef
; CHECK-MVE-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %c6 = icmp slt <4 x ptr> undef, undef
; CHECK-MVE-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %s6 = select <4 x i1> %c6, <4 x ptr> undef, <4 x ptr> undef
; CHECK-MVE-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: ret void
;
; CHECK-V8M-MAIN-SIZE-LABEL: 'minmax'
; CHECK-V8M-MAIN-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %c1 = icmp slt i8 undef, undef
; CHECK-V8M-MAIN-SIZE-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %s1 = select i1 %c1, i8 undef, i8 undef
; CHECK-V8M-MAIN-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %c2 = icmp slt i16 undef, undef
; CHECK-V8M-MAIN-SIZE-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %s2 = select i1 %c2, i16 undef, i16 undef
; CHECK-V8M-MAIN-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %c3 = icmp slt i32 undef, undef
; CHECK-V8M-MAIN-SIZE-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %s3 = select i1 %c3, i32 undef, i32 undef
; CHECK-V8M-MAIN-SIZE-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: %c4 = icmp slt <4 x i32> undef, undef
; CHECK-V8M-MAIN-SIZE-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %s4 = select <4 x i1> %c4, <4 x i32> undef, <4 x i32> undef
; CHECK-V8M-MAIN-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %c5 = icmp slt ptr undef, undef
; CHECK-V8M-MAIN-SIZE-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %s5 = select i1 %c5, ptr undef, ptr undef
; CHECK-V8M-MAIN-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %c6 = icmp slt <4 x ptr> undef, undef
; CHECK-V8M-MAIN-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %s6 = select <4 x i1> %c6, <4 x ptr> undef, <4 x ptr> undef
; CHECK-V8M-MAIN-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: ret void
;
; CHECK-V8M-BASE-SIZE-LABEL: 'minmax'
; CHECK-V8M-BASE-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %c1 = icmp slt i8 undef, undef
; CHECK-V8M-BASE-SIZE-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %s1 = select i1 %c1, i8 undef, i8 undef
; CHECK-V8M-BASE-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %c2 = icmp slt i16 undef, undef
; CHECK-V8M-BASE-SIZE-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %s2 = select i1 %c2, i16 undef, i16 undef
; CHECK-V8M-BASE-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %c3 = icmp slt i32 undef, undef
; CHECK-V8M-BASE-SIZE-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %s3 = select i1 %c3, i32 undef, i32 undef
; CHECK-V8M-BASE-SIZE-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: %c4 = icmp slt <4 x i32> undef, undef
; CHECK-V8M-BASE-SIZE-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %s4 = select <4 x i1> %c4, <4 x i32> undef, <4 x i32> undef
; CHECK-V8M-BASE-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %c5 = icmp slt ptr undef, undef
; CHECK-V8M-BASE-SIZE-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %s5 = select i1 %c5, ptr undef, ptr undef
; CHECK-V8M-BASE-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %c6 = icmp slt <4 x ptr> undef, undef
; CHECK-V8M-BASE-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %s6 = select <4 x i1> %c6, <4 x ptr> undef, <4 x ptr> undef
; CHECK-V8M-BASE-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: ret void
;
; CHECK-V8R-SIZE-LABEL: 'minmax'
; CHECK-V8R-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %c1 = icmp slt i8 undef, undef
; CHECK-V8R-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %s1 = select i1 %c1, i8 undef, i8 undef
; CHECK-V8R-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %c2 = icmp slt i16 undef, undef
; CHECK-V8R-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %s2 = select i1 %c2, i16 undef, i16 undef
; CHECK-V8R-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %c3 = icmp slt i32 undef, undef
; CHECK-V8R-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %s3 = select i1 %c3, i32 undef, i32 undef
; CHECK-V8R-SIZE-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: %c4 = icmp slt <4 x i32> undef, undef
; CHECK-V8R-SIZE-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %s4 = select <4 x i1> %c4, <4 x i32> undef, <4 x i32> undef
; CHECK-V8R-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %c5 = icmp slt ptr undef, undef
; CHECK-V8R-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %s5 = select i1 %c5, ptr undef, ptr undef
; CHECK-V8R-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %c6 = icmp slt <4 x ptr> undef, undef
; CHECK-V8R-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %s6 = select <4 x i1> %c6, <4 x ptr> undef, <4 x ptr> undef
; CHECK-V8R-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: ret void
;
  %c1 = icmp slt i8 undef, undef
  %s1 = select i1 %c1, i8 undef, i8 undef
  %c2 = icmp slt i16 undef, undef
  %s2 = select i1 %c2, i16 undef, i16 undef
  %c3 = icmp slt i32 undef, undef
  %s3 = select i1 %c3, i32 undef, i32 undef
  %c4 = icmp slt <4 x i32> undef, undef
  %s4 = select <4 x i1> %c4, <4 x i32> undef, <4 x i32> undef
  %c5 = icmp slt ptr undef, undef
  %s5 = select i1 %c5, ptr undef, ptr undef
  %c6 = icmp slt <4 x ptr> undef, undef
  %s6 = select <4 x i1> %c6, <4 x ptr> undef, <4 x ptr> undef
  ret void
}
