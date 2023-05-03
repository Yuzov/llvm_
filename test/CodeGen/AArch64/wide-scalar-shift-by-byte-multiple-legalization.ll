; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=aarch64-- | FileCheck %s --check-prefixes=ALL

define void @lshr_4bytes(ptr %src.ptr, ptr %byteOff.ptr, ptr %dst) nounwind {
; ALL-LABEL: lshr_4bytes:
; ALL:       // %bb.0:
; ALL-NEXT:    ldr w8, [x1]
; ALL-NEXT:    ldr w9, [x0]
; ALL-NEXT:    lsl w8, w8, #3
; ALL-NEXT:    lsr w8, w9, w8
; ALL-NEXT:    str w8, [x2]
; ALL-NEXT:    ret
  %src = load i32, ptr %src.ptr, align 1
  %byteOff = load i32, ptr %byteOff.ptr, align 1
  %bitOff = shl i32 %byteOff, 3
  %res = lshr i32 %src, %bitOff
  store i32 %res, ptr %dst, align 1
  ret void
}
define void @shl_4bytes(ptr %src.ptr, ptr %byteOff.ptr, ptr %dst) nounwind {
; ALL-LABEL: shl_4bytes:
; ALL:       // %bb.0:
; ALL-NEXT:    ldr w8, [x1]
; ALL-NEXT:    ldr w9, [x0]
; ALL-NEXT:    lsl w8, w8, #3
; ALL-NEXT:    lsl w8, w9, w8
; ALL-NEXT:    str w8, [x2]
; ALL-NEXT:    ret
  %src = load i32, ptr %src.ptr, align 1
  %byteOff = load i32, ptr %byteOff.ptr, align 1
  %bitOff = shl i32 %byteOff, 3
  %res = shl i32 %src, %bitOff
  store i32 %res, ptr %dst, align 1
  ret void
}
define void @ashr_4bytes(ptr %src.ptr, ptr %byteOff.ptr, ptr %dst) nounwind {
; ALL-LABEL: ashr_4bytes:
; ALL:       // %bb.0:
; ALL-NEXT:    ldr w8, [x1]
; ALL-NEXT:    ldr w9, [x0]
; ALL-NEXT:    lsl w8, w8, #3
; ALL-NEXT:    asr w8, w9, w8
; ALL-NEXT:    str w8, [x2]
; ALL-NEXT:    ret
  %src = load i32, ptr %src.ptr, align 1
  %byteOff = load i32, ptr %byteOff.ptr, align 1
  %bitOff = shl i32 %byteOff, 3
  %res = ashr i32 %src, %bitOff
  store i32 %res, ptr %dst, align 1
  ret void
}

define void @lshr_8bytes(ptr %src.ptr, ptr %byteOff.ptr, ptr %dst) nounwind {
; ALL-LABEL: lshr_8bytes:
; ALL:       // %bb.0:
; ALL-NEXT:    ldr x8, [x1]
; ALL-NEXT:    ldr x9, [x0]
; ALL-NEXT:    lsl x8, x8, #3
; ALL-NEXT:    lsr x8, x9, x8
; ALL-NEXT:    str x8, [x2]
; ALL-NEXT:    ret
  %src = load i64, ptr %src.ptr, align 1
  %byteOff = load i64, ptr %byteOff.ptr, align 1
  %bitOff = shl i64 %byteOff, 3
  %res = lshr i64 %src, %bitOff
  store i64 %res, ptr %dst, align 1
  ret void
}
define void @shl_8bytes(ptr %src.ptr, ptr %byteOff.ptr, ptr %dst) nounwind {
; ALL-LABEL: shl_8bytes:
; ALL:       // %bb.0:
; ALL-NEXT:    ldr x8, [x1]
; ALL-NEXT:    ldr x9, [x0]
; ALL-NEXT:    lsl x8, x8, #3
; ALL-NEXT:    lsl x8, x9, x8
; ALL-NEXT:    str x8, [x2]
; ALL-NEXT:    ret
  %src = load i64, ptr %src.ptr, align 1
  %byteOff = load i64, ptr %byteOff.ptr, align 1
  %bitOff = shl i64 %byteOff, 3
  %res = shl i64 %src, %bitOff
  store i64 %res, ptr %dst, align 1
  ret void
}
define void @ashr_8bytes(ptr %src.ptr, ptr %byteOff.ptr, ptr %dst) nounwind {
; ALL-LABEL: ashr_8bytes:
; ALL:       // %bb.0:
; ALL-NEXT:    ldr x8, [x1]
; ALL-NEXT:    ldr x9, [x0]
; ALL-NEXT:    lsl x8, x8, #3
; ALL-NEXT:    asr x8, x9, x8
; ALL-NEXT:    str x8, [x2]
; ALL-NEXT:    ret
  %src = load i64, ptr %src.ptr, align 1
  %byteOff = load i64, ptr %byteOff.ptr, align 1
  %bitOff = shl i64 %byteOff, 3
  %res = ashr i64 %src, %bitOff
  store i64 %res, ptr %dst, align 1
  ret void
}

define void @lshr_16bytes(ptr %src.ptr, ptr %byteOff.ptr, ptr %dst) nounwind {
; ALL-LABEL: lshr_16bytes:
; ALL:       // %bb.0:
; ALL-NEXT:    ldr x8, [x1]
; ALL-NEXT:    ldp x10, x9, [x0]
; ALL-NEXT:    lsl x8, x8, #3
; ALL-NEXT:    and x11, x8, #0x38
; ALL-NEXT:    mvn w12, w8
; ALL-NEXT:    tst x8, #0x40
; ALL-NEXT:    lsl x13, x9, #1
; ALL-NEXT:    lsr x10, x10, x11
; ALL-NEXT:    lsl x12, x13, x12
; ALL-NEXT:    lsr x9, x9, x11
; ALL-NEXT:    orr x8, x12, x10
; ALL-NEXT:    csel x10, xzr, x9, ne
; ALL-NEXT:    csel x8, x9, x8, ne
; ALL-NEXT:    stp x8, x10, [x2]
; ALL-NEXT:    ret
  %src = load i128, ptr %src.ptr, align 1
  %byteOff = load i128, ptr %byteOff.ptr, align 1
  %bitOff = shl i128 %byteOff, 3
  %res = lshr i128 %src, %bitOff
  store i128 %res, ptr %dst, align 1
  ret void
}
define void @shl_16bytes(ptr %src.ptr, ptr %byteOff.ptr, ptr %dst) nounwind {
; ALL-LABEL: shl_16bytes:
; ALL:       // %bb.0:
; ALL-NEXT:    ldr x8, [x1]
; ALL-NEXT:    ldp x9, x10, [x0]
; ALL-NEXT:    lsl x8, x8, #3
; ALL-NEXT:    and x11, x8, #0x38
; ALL-NEXT:    mvn w12, w8
; ALL-NEXT:    lsr x13, x9, #1
; ALL-NEXT:    tst x8, #0x40
; ALL-NEXT:    lsl x10, x10, x11
; ALL-NEXT:    lsr x12, x13, x12
; ALL-NEXT:    lsl x9, x9, x11
; ALL-NEXT:    orr x8, x10, x12
; ALL-NEXT:    csel x10, xzr, x9, ne
; ALL-NEXT:    csel x8, x9, x8, ne
; ALL-NEXT:    stp x10, x8, [x2]
; ALL-NEXT:    ret
  %src = load i128, ptr %src.ptr, align 1
  %byteOff = load i128, ptr %byteOff.ptr, align 1
  %bitOff = shl i128 %byteOff, 3
  %res = shl i128 %src, %bitOff
  store i128 %res, ptr %dst, align 1
  ret void
}
define void @ashr_16bytes(ptr %src.ptr, ptr %byteOff.ptr, ptr %dst) nounwind {
; ALL-LABEL: ashr_16bytes:
; ALL:       // %bb.0:
; ALL-NEXT:    ldr x8, [x1]
; ALL-NEXT:    ldp x10, x9, [x0]
; ALL-NEXT:    lsl x8, x8, #3
; ALL-NEXT:    and x11, x8, #0x38
; ALL-NEXT:    mvn w12, w8
; ALL-NEXT:    tst x8, #0x40
; ALL-NEXT:    lsl x13, x9, #1
; ALL-NEXT:    asr x8, x9, #63
; ALL-NEXT:    lsr x10, x10, x11
; ALL-NEXT:    lsl x12, x13, x12
; ALL-NEXT:    asr x11, x9, x11
; ALL-NEXT:    orr x9, x12, x10
; ALL-NEXT:    csel x8, x8, x11, ne
; ALL-NEXT:    csel x9, x11, x9, ne
; ALL-NEXT:    stp x9, x8, [x2]
; ALL-NEXT:    ret
  %src = load i128, ptr %src.ptr, align 1
  %byteOff = load i128, ptr %byteOff.ptr, align 1
  %bitOff = shl i128 %byteOff, 3
  %res = ashr i128 %src, %bitOff
  store i128 %res, ptr %dst, align 1
  ret void
}

define void @lshr_32bytes(ptr %src.ptr, ptr %byteOff.ptr, ptr %dst) nounwind {
; ALL-LABEL: lshr_32bytes:
; ALL:       // %bb.0:
; ALL-NEXT:    sub sp, sp, #64
; ALL-NEXT:    ldr x9, [x1]
; ALL-NEXT:    mov x8, sp
; ALL-NEXT:    ldp x10, x11, [x0, #16]
; ALL-NEXT:    movi v0.2d, #0000000000000000
; ALL-NEXT:    ldr q1, [x0]
; ALL-NEXT:    and x9, x9, #0x1f
; ALL-NEXT:    add x8, x8, x9
; ALL-NEXT:    stp q0, q0, [sp, #32]
; ALL-NEXT:    stp x10, x11, [sp, #16]
; ALL-NEXT:    str q1, [sp]
; ALL-NEXT:    ldp x10, x9, [x8, #16]
; ALL-NEXT:    ldr q0, [x8]
; ALL-NEXT:    stp x10, x9, [x2, #16]
; ALL-NEXT:    str q0, [x2]
; ALL-NEXT:    add sp, sp, #64
; ALL-NEXT:    ret
  %src = load i256, ptr %src.ptr, align 1
  %byteOff = load i256, ptr %byteOff.ptr, align 1
  %bitOff = shl i256 %byteOff, 3
  %res = lshr i256 %src, %bitOff
  store i256 %res, ptr %dst, align 1
  ret void
}
define void @shl_32bytes(ptr %src.ptr, ptr %byteOff.ptr, ptr %dst) nounwind {
; ALL-LABEL: shl_32bytes:
; ALL:       // %bb.0:
; ALL-NEXT:    sub sp, sp, #64
; ALL-NEXT:    ldr x9, [x1]
; ALL-NEXT:    mov x8, sp
; ALL-NEXT:    ldp x10, x11, [x0, #16]
; ALL-NEXT:    movi v0.2d, #0000000000000000
; ALL-NEXT:    add x8, x8, #32
; ALL-NEXT:    ldr q1, [x0]
; ALL-NEXT:    and x9, x9, #0x1f
; ALL-NEXT:    sub x8, x8, x9
; ALL-NEXT:    stp q0, q0, [sp]
; ALL-NEXT:    stp x10, x11, [sp, #48]
; ALL-NEXT:    str q1, [sp, #32]
; ALL-NEXT:    ldp x9, x10, [x8, #16]
; ALL-NEXT:    ldr q0, [x8]
; ALL-NEXT:    stp x9, x10, [x2, #16]
; ALL-NEXT:    str q0, [x2]
; ALL-NEXT:    add sp, sp, #64
; ALL-NEXT:    ret
  %src = load i256, ptr %src.ptr, align 1
  %byteOff = load i256, ptr %byteOff.ptr, align 1
  %bitOff = shl i256 %byteOff, 3
  %res = shl i256 %src, %bitOff
  store i256 %res, ptr %dst, align 1
  ret void
}
define void @ashr_32bytes(ptr %src.ptr, ptr %byteOff.ptr, ptr %dst) nounwind {
; ALL-LABEL: ashr_32bytes:
; ALL:       // %bb.0:
; ALL-NEXT:    sub sp, sp, #64
; ALL-NEXT:    ldp x11, x10, [x0, #16]
; ALL-NEXT:    mov x8, sp
; ALL-NEXT:    ldr x9, [x1]
; ALL-NEXT:    ldr q0, [x0]
; ALL-NEXT:    asr x12, x10, #63
; ALL-NEXT:    and x9, x9, #0x1f
; ALL-NEXT:    add x8, x8, x9
; ALL-NEXT:    stp x11, x10, [sp, #16]
; ALL-NEXT:    str q0, [sp]
; ALL-NEXT:    stp x12, x12, [sp, #48]
; ALL-NEXT:    stp x12, x12, [sp, #32]
; ALL-NEXT:    ldp x10, x9, [x8, #16]
; ALL-NEXT:    ldr q0, [x8]
; ALL-NEXT:    stp x10, x9, [x2, #16]
; ALL-NEXT:    str q0, [x2]
; ALL-NEXT:    add sp, sp, #64
; ALL-NEXT:    ret
  %src = load i256, ptr %src.ptr, align 1
  %byteOff = load i256, ptr %byteOff.ptr, align 1
  %bitOff = shl i256 %byteOff, 3
  %res = ashr i256 %src, %bitOff
  store i256 %res, ptr %dst, align 1
  ret void
}
