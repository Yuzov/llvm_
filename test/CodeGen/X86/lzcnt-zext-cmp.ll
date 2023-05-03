; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; Test patterns which generates lzcnt instructions.
; Eg: zext(or(setcc(cmp), setcc(cmp))) -> shr(or(lzcnt, lzcnt))
; RUN: llc < %s -mtriple=x86_64-pc-linux -mcpu=btver2 | FileCheck --check-prefix=ALL --check-prefix=FASTLZCNT %s
; RUN: llc < %s -mtriple=x86_64-pc-linux -mcpu=btver2 -mattr=-fast-lzcnt | FileCheck --check-prefix=ALL --check-prefix=NOFASTLZCNT %s
; RUN: llc < %s -mtriple=x86_64-pc-linux -mcpu=znver1 | FileCheck --check-prefix=ALL --check-prefix=FASTLZCNT %s
; RUN: llc < %s -mtriple=x86_64-pc-linux -mcpu=znver1 -mattr=-fast-lzcnt | FileCheck --check-prefix=ALL --check-prefix=NOFASTLZCNT %s
; RUN: llc < %s -mtriple=x86_64-pc-linux -mcpu=znver2 | FileCheck --check-prefix=ALL --check-prefix=FASTLZCNT %s
; RUN: llc < %s -mtriple=x86_64-pc-linux -mcpu=znver2 -mattr=-fast-lzcnt | FileCheck --check-prefix=ALL --check-prefix=NOFASTLZCNT %s

; Test one 32-bit input, output is 32-bit, no transformations expected.
define i32 @test_zext_cmp0(i32 %a) {
; ALL-LABEL: test_zext_cmp0:
; ALL:       # %bb.0: # %entry
; ALL-NEXT:    xorl %eax, %eax
; ALL-NEXT:    testl %edi, %edi
; ALL-NEXT:    sete %al
; ALL-NEXT:    retq
entry:
  %cmp = icmp eq i32 %a, 0
  %conv = zext i1 %cmp to i32
  ret i32 %conv
}

; Test two 32-bit inputs, output is 32-bit.
define i32 @test_zext_cmp1(i32 %a, i32 %b) {
; FASTLZCNT-LABEL: test_zext_cmp1:
; FASTLZCNT:       # %bb.0:
; FASTLZCNT-NEXT:    lzcntl %edi, %ecx
; FASTLZCNT-NEXT:    lzcntl %esi, %eax
; FASTLZCNT-NEXT:    orl %ecx, %eax
; FASTLZCNT-NEXT:    shrl $5, %eax
; FASTLZCNT-NEXT:    retq
;
; NOFASTLZCNT-LABEL: test_zext_cmp1:
; NOFASTLZCNT:       # %bb.0:
; NOFASTLZCNT-NEXT:    testl %edi, %edi
; NOFASTLZCNT-NEXT:    sete %al
; NOFASTLZCNT-NEXT:    testl %esi, %esi
; NOFASTLZCNT-NEXT:    sete %cl
; NOFASTLZCNT-NEXT:    orb %al, %cl
; NOFASTLZCNT-NEXT:    movzbl %cl, %eax
; NOFASTLZCNT-NEXT:    retq
  %cmp = icmp eq i32 %a, 0
  %cmp1 = icmp eq i32 %b, 0
  %or = or i1 %cmp, %cmp1
  %lor.ext = zext i1 %or to i32
  ret i32 %lor.ext
}

; Test two 64-bit inputs, output is 64-bit.
define i64 @test_zext_cmp2(i64 %a, i64 %b) {
; FASTLZCNT-LABEL: test_zext_cmp2:
; FASTLZCNT:       # %bb.0:
; FASTLZCNT-NEXT:    lzcntq %rdi, %rcx
; FASTLZCNT-NEXT:    lzcntq %rsi, %rax
; FASTLZCNT-NEXT:    orl %ecx, %eax
; FASTLZCNT-NEXT:    shrl $6, %eax
; FASTLZCNT-NEXT:    retq
;
; NOFASTLZCNT-LABEL: test_zext_cmp2:
; NOFASTLZCNT:       # %bb.0:
; NOFASTLZCNT-NEXT:    testq %rdi, %rdi
; NOFASTLZCNT-NEXT:    sete %al
; NOFASTLZCNT-NEXT:    testq %rsi, %rsi
; NOFASTLZCNT-NEXT:    sete %cl
; NOFASTLZCNT-NEXT:    orb %al, %cl
; NOFASTLZCNT-NEXT:    movzbl %cl, %eax
; NOFASTLZCNT-NEXT:    retq
  %cmp = icmp eq i64 %a, 0
  %cmp1 = icmp eq i64 %b, 0
  %or = or i1 %cmp, %cmp1
  %lor.ext = zext i1 %or to i64
  ret i64 %lor.ext
}

; Test two 16-bit inputs, output is 16-bit.
; The transform is disabled for the 16-bit case, as we still have to clear the
; upper 16-bits, adding one more instruction.
define i16 @test_zext_cmp3(i16 %a, i16 %b) {
; ALL-LABEL: test_zext_cmp3:
; ALL:       # %bb.0:
; ALL-NEXT:    testw %di, %di
; ALL-NEXT:    sete %al
; ALL-NEXT:    testw %si, %si
; ALL-NEXT:    sete %cl
; ALL-NEXT:    orb %al, %cl
; ALL-NEXT:    movzbl %cl, %eax
; ALL-NEXT:    # kill: def $ax killed $ax killed $eax
; ALL-NEXT:    retq
  %cmp = icmp eq i16 %a, 0
  %cmp1 = icmp eq i16 %b, 0
  %or = or i1 %cmp, %cmp1
  %lor.ext = zext i1 %or to i16
  ret i16 %lor.ext
}

; Test two 32-bit inputs, output is 64-bit.
define i64 @test_zext_cmp4(i32 %a, i32 %b) {
; FASTLZCNT-LABEL: test_zext_cmp4:
; FASTLZCNT:       # %bb.0: # %entry
; FASTLZCNT-NEXT:    lzcntl %edi, %ecx
; FASTLZCNT-NEXT:    lzcntl %esi, %eax
; FASTLZCNT-NEXT:    orl %ecx, %eax
; FASTLZCNT-NEXT:    shrl $5, %eax
; FASTLZCNT-NEXT:    retq
;
; NOFASTLZCNT-LABEL: test_zext_cmp4:
; NOFASTLZCNT:       # %bb.0: # %entry
; NOFASTLZCNT-NEXT:    testl %edi, %edi
; NOFASTLZCNT-NEXT:    sete %al
; NOFASTLZCNT-NEXT:    testl %esi, %esi
; NOFASTLZCNT-NEXT:    sete %cl
; NOFASTLZCNT-NEXT:    orb %al, %cl
; NOFASTLZCNT-NEXT:    movzbl %cl, %eax
; NOFASTLZCNT-NEXT:    retq
entry:
  %cmp = icmp eq i32 %a, 0
  %cmp1 = icmp eq i32 %b, 0
  %0 = or i1 %cmp, %cmp1
  %conv = zext i1 %0 to i64
  ret i64 %conv
}

; Test two 64-bit inputs, output is 32-bit.
define i32 @test_zext_cmp5(i64 %a, i64 %b) {
; FASTLZCNT-LABEL: test_zext_cmp5:
; FASTLZCNT:       # %bb.0: # %entry
; FASTLZCNT-NEXT:    lzcntq %rdi, %rcx
; FASTLZCNT-NEXT:    lzcntq %rsi, %rax
; FASTLZCNT-NEXT:    orl %ecx, %eax
; FASTLZCNT-NEXT:    shrl $6, %eax
; FASTLZCNT-NEXT:    # kill: def $eax killed $eax killed $rax
; FASTLZCNT-NEXT:    retq
;
; NOFASTLZCNT-LABEL: test_zext_cmp5:
; NOFASTLZCNT:       # %bb.0: # %entry
; NOFASTLZCNT-NEXT:    testq %rdi, %rdi
; NOFASTLZCNT-NEXT:    sete %al
; NOFASTLZCNT-NEXT:    testq %rsi, %rsi
; NOFASTLZCNT-NEXT:    sete %cl
; NOFASTLZCNT-NEXT:    orb %al, %cl
; NOFASTLZCNT-NEXT:    movzbl %cl, %eax
; NOFASTLZCNT-NEXT:    retq
entry:
  %cmp = icmp eq i64 %a, 0
  %cmp1 = icmp eq i64 %b, 0
  %0 = or i1 %cmp, %cmp1
  %lor.ext = zext i1 %0 to i32
  ret i32 %lor.ext
}

; Test three 32-bit inputs, output is 32-bit.
define i32 @test_zext_cmp6(i32 %a, i32 %b, i32 %c) {
; FASTLZCNT-LABEL: test_zext_cmp6:
; FASTLZCNT:       # %bb.0: # %entry
; FASTLZCNT-NEXT:    lzcntl %edi, %ecx
; FASTLZCNT-NEXT:    lzcntl %edx, %eax
; FASTLZCNT-NEXT:    lzcntl %esi, %esi
; FASTLZCNT-NEXT:    orl %ecx, %eax
; FASTLZCNT-NEXT:    orl %esi, %eax
; FASTLZCNT-NEXT:    shrl $5, %eax
; FASTLZCNT-NEXT:    retq
;
; NOFASTLZCNT-LABEL: test_zext_cmp6:
; NOFASTLZCNT:       # %bb.0: # %entry
; NOFASTLZCNT-NEXT:    testl %edi, %edi
; NOFASTLZCNT-NEXT:    sete %al
; NOFASTLZCNT-NEXT:    testl %esi, %esi
; NOFASTLZCNT-NEXT:    sete %cl
; NOFASTLZCNT-NEXT:    orb %al, %cl
; NOFASTLZCNT-NEXT:    testl %edx, %edx
; NOFASTLZCNT-NEXT:    sete %al
; NOFASTLZCNT-NEXT:    orb %cl, %al
; NOFASTLZCNT-NEXT:    movzbl %al, %eax
; NOFASTLZCNT-NEXT:    retq
entry:
  %cmp = icmp eq i32 %a, 0
  %cmp1 = icmp eq i32 %b, 0
  %or.cond = or i1 %cmp, %cmp1
  %cmp2 = icmp eq i32 %c, 0
  %.cmp2 = or i1 %or.cond, %cmp2
  %lor.ext = zext i1 %.cmp2 to i32
  ret i32 %lor.ext
}

; Test three 32-bit inputs, output is 32-bit, but compared to test_zext_cmp6 test,
; %.cmp2 inputs' order is inverted.
define i32 @test_zext_cmp7(i32 %a, i32 %b, i32 %c) {
; FASTLZCNT-LABEL: test_zext_cmp7:
; FASTLZCNT:       # %bb.0: # %entry
; FASTLZCNT-NEXT:    lzcntl %edi, %ecx
; FASTLZCNT-NEXT:    lzcntl %edx, %eax
; FASTLZCNT-NEXT:    lzcntl %esi, %esi
; FASTLZCNT-NEXT:    orl %ecx, %eax
; FASTLZCNT-NEXT:    orl %esi, %eax
; FASTLZCNT-NEXT:    shrl $5, %eax
; FASTLZCNT-NEXT:    retq
;
; NOFASTLZCNT-LABEL: test_zext_cmp7:
; NOFASTLZCNT:       # %bb.0: # %entry
; NOFASTLZCNT-NEXT:    testl %edi, %edi
; NOFASTLZCNT-NEXT:    sete %al
; NOFASTLZCNT-NEXT:    testl %esi, %esi
; NOFASTLZCNT-NEXT:    sete %cl
; NOFASTLZCNT-NEXT:    orb %al, %cl
; NOFASTLZCNT-NEXT:    testl %edx, %edx
; NOFASTLZCNT-NEXT:    sete %al
; NOFASTLZCNT-NEXT:    orb %cl, %al
; NOFASTLZCNT-NEXT:    movzbl %al, %eax
; NOFASTLZCNT-NEXT:    retq
entry:
  %cmp = icmp eq i32 %a, 0
  %cmp1 = icmp eq i32 %b, 0
  %or.cond = or i1 %cmp, %cmp1
  %cmp2 = icmp eq i32 %c, 0
  %.cmp2 = or i1 %cmp2, %or.cond
  %lor.ext = zext i1 %.cmp2 to i32
  ret i32 %lor.ext
}

; Test four 32-bit inputs, output is 32-bit.
define i32 @test_zext_cmp8(i32 %a, i32 %b, i32 %c, i32 %d) {
; FASTLZCNT-LABEL: test_zext_cmp8:
; FASTLZCNT:       # %bb.0: # %entry
; FASTLZCNT-NEXT:    lzcntl %edi, %eax
; FASTLZCNT-NEXT:    lzcntl %esi, %esi
; FASTLZCNT-NEXT:    lzcntl %edx, %edx
; FASTLZCNT-NEXT:    orl %eax, %esi
; FASTLZCNT-NEXT:    lzcntl %ecx, %eax
; FASTLZCNT-NEXT:    orl %edx, %eax
; FASTLZCNT-NEXT:    orl %esi, %eax
; FASTLZCNT-NEXT:    shrl $5, %eax
; FASTLZCNT-NEXT:    retq
;
; NOFASTLZCNT-LABEL: test_zext_cmp8:
; NOFASTLZCNT:       # %bb.0: # %entry
; NOFASTLZCNT-NEXT:    testl %edi, %edi
; NOFASTLZCNT-NEXT:    sete %al
; NOFASTLZCNT-NEXT:    testl %esi, %esi
; NOFASTLZCNT-NEXT:    sete %sil
; NOFASTLZCNT-NEXT:    orb %al, %sil
; NOFASTLZCNT-NEXT:    testl %edx, %edx
; NOFASTLZCNT-NEXT:    sete %al
; NOFASTLZCNT-NEXT:    testl %ecx, %ecx
; NOFASTLZCNT-NEXT:    sete %cl
; NOFASTLZCNT-NEXT:    orb %al, %cl
; NOFASTLZCNT-NEXT:    orb %sil, %cl
; NOFASTLZCNT-NEXT:    movzbl %cl, %eax
; NOFASTLZCNT-NEXT:    retq
entry:
  %cmp = icmp eq i32 %a, 0
  %cmp1 = icmp eq i32 %b, 0
  %or.cond = or i1 %cmp, %cmp1
  %cmp3 = icmp eq i32 %c, 0
  %or.cond5 = or i1 %or.cond, %cmp3
  %cmp4 = icmp eq i32 %d, 0
  %.cmp4 = or i1 %or.cond5, %cmp4
  %lor.ext = zext i1 %.cmp4 to i32
  ret i32 %lor.ext
}

; Test one 32-bit input, one 64-bit input, output is 32-bit.
define i32 @test_zext_cmp9(i32 %a, i64 %b) {
; FASTLZCNT-LABEL: test_zext_cmp9:
; FASTLZCNT:       # %bb.0: # %entry
; FASTLZCNT-NEXT:    lzcntq %rsi, %rax
; FASTLZCNT-NEXT:    lzcntl %edi, %ecx
; FASTLZCNT-NEXT:    shrl $5, %ecx
; FASTLZCNT-NEXT:    shrl $6, %eax
; FASTLZCNT-NEXT:    orl %ecx, %eax
; FASTLZCNT-NEXT:    # kill: def $eax killed $eax killed $rax
; FASTLZCNT-NEXT:    retq
;
; NOFASTLZCNT-LABEL: test_zext_cmp9:
; NOFASTLZCNT:       # %bb.0: # %entry
; NOFASTLZCNT-NEXT:    testl %edi, %edi
; NOFASTLZCNT-NEXT:    sete %al
; NOFASTLZCNT-NEXT:    testq %rsi, %rsi
; NOFASTLZCNT-NEXT:    sete %cl
; NOFASTLZCNT-NEXT:    orb %al, %cl
; NOFASTLZCNT-NEXT:    movzbl %cl, %eax
; NOFASTLZCNT-NEXT:    retq
entry:
  %cmp = icmp eq i32 %a, 0
  %cmp1 = icmp eq i64 %b, 0
  %0 = or i1 %cmp, %cmp1
  %lor.ext = zext i1 %0 to i32
  ret i32 %lor.ext
}

; Test 2 128-bit inputs, output is 32-bit, no transformations expected.
define i32 @test_zext_cmp10(i64 %a.coerce0, i64 %a.coerce1, i64 %b.coerce0, i64 %b.coerce1) {
; ALL-LABEL: test_zext_cmp10:
; ALL:       # %bb.0: # %entry
; ALL-NEXT:    orq %rsi, %rdi
; ALL-NEXT:    sete %al
; ALL-NEXT:    orq %rcx, %rdx
; ALL-NEXT:    sete %cl
; ALL-NEXT:    orb %al, %cl
; ALL-NEXT:    movzbl %cl, %eax
; ALL-NEXT:    retq
entry:
  %a.sroa.2.0.insert.ext = zext i64 %a.coerce1 to i128
  %a.sroa.2.0.insert.shift = shl nuw i128 %a.sroa.2.0.insert.ext, 64
  %a.sroa.0.0.insert.ext = zext i64 %a.coerce0 to i128
  %a.sroa.0.0.insert.insert = or i128 %a.sroa.2.0.insert.shift, %a.sroa.0.0.insert.ext
  %b.sroa.2.0.insert.ext = zext i64 %b.coerce1 to i128
  %b.sroa.2.0.insert.shift = shl nuw i128 %b.sroa.2.0.insert.ext, 64
  %b.sroa.0.0.insert.ext = zext i64 %b.coerce0 to i128
  %b.sroa.0.0.insert.insert = or i128 %b.sroa.2.0.insert.shift, %b.sroa.0.0.insert.ext
  %cmp = icmp eq i128 %a.sroa.0.0.insert.insert, 0
  %cmp3 = icmp eq i128 %b.sroa.0.0.insert.insert, 0
  %0 = or i1 %cmp, %cmp3
  %lor.ext = zext i1 %0 to i32
  ret i32 %lor.ext
}

; PR31902 Fix a crash in combineOrCmpEqZeroToCtlzSrl under fast math.
define i32 @test_zext_cmp11(double %a, double %b) "no-nans-fp-math"="true" {
;
; ALL-LABEL: test_zext_cmp11:
; ALL:       # %bb.0: # %entry
; ALL-NEXT:    vxorpd %xmm2, %xmm2, %xmm2
; ALL-NEXT:    vcmpeqpd %xmm2, %xmm1, %xmm1
; ALL-NEXT:    vcmpeqpd %xmm2, %xmm0, %xmm0
; ALL-NEXT:    vorpd %xmm1, %xmm0, %xmm0
; ALL-NEXT:    vmovd %xmm0, %eax
; ALL-NEXT:    andl $1, %eax
; ALL-NEXT:    retq
entry:
  %cmp = fcmp fast oeq double %a, 0.000000e+00
  %cmp1 = fcmp fast oeq double %b, 0.000000e+00
  %0 = or i1 %cmp, %cmp1
  %conv = zext i1 %0 to i32
  ret i32 %conv
}

; PR54694 Fix an infinite loop in DAG combiner.
define i32 @test_zext_cmp12(i32 %0, i32 %1) {
; FASTLZCNT-LABEL: test_zext_cmp12:
; FASTLZCNT:       # %bb.0:
; FASTLZCNT-NEXT:    andl $131072, %edi # imm = 0x20000
; FASTLZCNT-NEXT:    andl $131072, %esi # imm = 0x20000
; FASTLZCNT-NEXT:    lzcntl %edi, %eax
; FASTLZCNT-NEXT:    lzcntl %esi, %ecx
; FASTLZCNT-NEXT:    orl %eax, %ecx
; FASTLZCNT-NEXT:    movl $2, %eax
; FASTLZCNT-NEXT:    shrl $5, %ecx
; FASTLZCNT-NEXT:    subl %ecx, %eax
; FASTLZCNT-NEXT:    retq
;
; NOFASTLZCNT-LABEL: test_zext_cmp12:
; NOFASTLZCNT:       # %bb.0:
; NOFASTLZCNT-NEXT:    testl $131072, %edi # imm = 0x20000
; NOFASTLZCNT-NEXT:    sete %al
; NOFASTLZCNT-NEXT:    testl $131072, %esi # imm = 0x20000
; NOFASTLZCNT-NEXT:    sete %cl
; NOFASTLZCNT-NEXT:    orb %al, %cl
; NOFASTLZCNT-NEXT:    movl $2, %eax
; NOFASTLZCNT-NEXT:    movzbl %cl, %ecx
; NOFASTLZCNT-NEXT:    subl %ecx, %eax
; NOFASTLZCNT-NEXT:    retq
  %3 = and i32 %0, 131072
  %4 = icmp eq i32 %3, 0
  %5 = and i32 %1, 131072
  %6 = icmp eq i32 %5, 0
  %7 = select i1 %4, i1 true, i1 %6
  %8 = select i1 %7, i32 1, i32 2
  ret i32 %8
}
