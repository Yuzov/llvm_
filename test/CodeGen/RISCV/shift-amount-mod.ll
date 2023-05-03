; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv32 -verify-machineinstrs < %s \
; RUN:   | FileCheck %s -check-prefix=RV32I
; RUN: llc -mtriple=riscv64 -verify-machineinstrs < %s \
; RUN:   | FileCheck %s -check-prefix=RV64I

define i32 @shl_by_complemented_32(i32 %x) {
; RV32I-LABEL: shl_by_complemented_32:
; RV32I:       # %bb.0:
; RV32I-NEXT:    not a1, a0
; RV32I-NEXT:    sll a0, a0, a1
; RV32I-NEXT:    ret
;
; RV64I-LABEL: shl_by_complemented_32:
; RV64I:       # %bb.0:
; RV64I-NEXT:    not a1, a0
; RV64I-NEXT:    sllw a0, a0, a1
; RV64I-NEXT:    ret
  %a = sub i32 31, %x
  %b = shl i32 %x, %a
  ret i32 %b
}

define i64 @shl_by_complemented_64(i64 %x) {
; RV32I-LABEL: shl_by_complemented_64:
; RV32I:       # %bb.0:
; RV32I-NEXT:    not a4, a0
; RV32I-NEXT:    li a3, 31
; RV32I-NEXT:    sub a3, a3, a0
; RV32I-NEXT:    sll a2, a0, a4
; RV32I-NEXT:    bltz a3, .LBB1_2
; RV32I-NEXT:  # %bb.1:
; RV32I-NEXT:    mv a1, a2
; RV32I-NEXT:    j .LBB1_3
; RV32I-NEXT:  .LBB1_2:
; RV32I-NEXT:    sll a1, a1, a4
; RV32I-NEXT:    li a4, 63
; RV32I-NEXT:    sub a4, a4, a0
; RV32I-NEXT:    not a4, a4
; RV32I-NEXT:    srli a0, a0, 1
; RV32I-NEXT:    srl a0, a0, a4
; RV32I-NEXT:    or a1, a1, a0
; RV32I-NEXT:  .LBB1_3:
; RV32I-NEXT:    slti a0, a3, 0
; RV32I-NEXT:    neg a0, a0
; RV32I-NEXT:    and a0, a0, a2
; RV32I-NEXT:    ret
;
; RV64I-LABEL: shl_by_complemented_64:
; RV64I:       # %bb.0:
; RV64I-NEXT:    not a1, a0
; RV64I-NEXT:    sll a0, a0, a1
; RV64I-NEXT:    ret
  %a = sub i64 63, %x
  %b = shl i64 %x, %a
  ret i64 %b
}

define i32 @lshr_by_complemented_32(i32 %x) {
; RV32I-LABEL: lshr_by_complemented_32:
; RV32I:       # %bb.0:
; RV32I-NEXT:    not a1, a0
; RV32I-NEXT:    srl a0, a0, a1
; RV32I-NEXT:    ret
;
; RV64I-LABEL: lshr_by_complemented_32:
; RV64I:       # %bb.0:
; RV64I-NEXT:    not a1, a0
; RV64I-NEXT:    srlw a0, a0, a1
; RV64I-NEXT:    ret
  %a = sub i32 31, %x
  %b = lshr i32 %x, %a
  ret i32 %b
}

define i64 @lshr_by_complemented_64(i64 %x) {
; RV32I-LABEL: lshr_by_complemented_64:
; RV32I:       # %bb.0:
; RV32I-NEXT:    not a4, a0
; RV32I-NEXT:    li a3, 31
; RV32I-NEXT:    sub a3, a3, a0
; RV32I-NEXT:    srl a2, a1, a4
; RV32I-NEXT:    bltz a3, .LBB3_2
; RV32I-NEXT:  # %bb.1:
; RV32I-NEXT:    mv a0, a2
; RV32I-NEXT:    j .LBB3_3
; RV32I-NEXT:  .LBB3_2:
; RV32I-NEXT:    srl a4, a0, a4
; RV32I-NEXT:    li a5, 63
; RV32I-NEXT:    sub a5, a5, a0
; RV32I-NEXT:    not a0, a5
; RV32I-NEXT:    slli a1, a1, 1
; RV32I-NEXT:    sll a0, a1, a0
; RV32I-NEXT:    or a0, a4, a0
; RV32I-NEXT:  .LBB3_3:
; RV32I-NEXT:    slti a1, a3, 0
; RV32I-NEXT:    neg a1, a1
; RV32I-NEXT:    and a1, a1, a2
; RV32I-NEXT:    ret
;
; RV64I-LABEL: lshr_by_complemented_64:
; RV64I:       # %bb.0:
; RV64I-NEXT:    not a1, a0
; RV64I-NEXT:    srl a0, a0, a1
; RV64I-NEXT:    ret
  %a = sub i64 63, %x
  %b = lshr i64 %x, %a
  ret i64 %b
}

define i32 @ashr_by_complemented_32(i32 %x) {
; RV32I-LABEL: ashr_by_complemented_32:
; RV32I:       # %bb.0:
; RV32I-NEXT:    not a1, a0
; RV32I-NEXT:    sra a0, a0, a1
; RV32I-NEXT:    ret
;
; RV64I-LABEL: ashr_by_complemented_32:
; RV64I:       # %bb.0:
; RV64I-NEXT:    not a1, a0
; RV64I-NEXT:    sraw a0, a0, a1
; RV64I-NEXT:    ret
  %a = sub i32 31, %x
  %b = ashr i32 %x, %a
  ret i32 %b
}

define i64 @ashr_by_complemented_64(i64 %x) {
; RV32I-LABEL: ashr_by_complemented_64:
; RV32I:       # %bb.0:
; RV32I-NEXT:    mv a2, a0
; RV32I-NEXT:    li a0, 31
; RV32I-NEXT:    sub a4, a0, a2
; RV32I-NEXT:    not a3, a2
; RV32I-NEXT:    sra a0, a1, a3
; RV32I-NEXT:    bltz a4, .LBB5_2
; RV32I-NEXT:  # %bb.1:
; RV32I-NEXT:    srai a1, a1, 31
; RV32I-NEXT:    ret
; RV32I-NEXT:  .LBB5_2:
; RV32I-NEXT:    srl a3, a2, a3
; RV32I-NEXT:    li a4, 63
; RV32I-NEXT:    sub a4, a4, a2
; RV32I-NEXT:    not a2, a4
; RV32I-NEXT:    slli a1, a1, 1
; RV32I-NEXT:    sll a1, a1, a2
; RV32I-NEXT:    or a3, a3, a1
; RV32I-NEXT:    mv a1, a0
; RV32I-NEXT:    mv a0, a3
; RV32I-NEXT:    ret
;
; RV64I-LABEL: ashr_by_complemented_64:
; RV64I:       # %bb.0:
; RV64I-NEXT:    not a1, a0
; RV64I-NEXT:    sra a0, a0, a1
; RV64I-NEXT:    ret
  %a = sub i64 63, %x
  %b = ashr i64 %x, %a
  ret i64 %b
}

define i32 @shl_by_masked_complemented_32(i32 %x) {
; RV32I-LABEL: shl_by_masked_complemented_32:
; RV32I:       # %bb.0:
; RV32I-NEXT:    not a1, a0
; RV32I-NEXT:    sll a0, a0, a1
; RV32I-NEXT:    ret
;
; RV64I-LABEL: shl_by_masked_complemented_32:
; RV64I:       # %bb.0:
; RV64I-NEXT:    not a1, a0
; RV64I-NEXT:    sllw a0, a0, a1
; RV64I-NEXT:    ret
  %a = sub i32 31, %x
  %b = and i32 %a, 31
  %c = shl i32 %x, %b
  ret i32 %c
}

define i64 @shl_by_masked_complemented_64(i64 %x) {
; RV32I-LABEL: shl_by_masked_complemented_64:
; RV32I:       # %bb.0:
; RV32I-NEXT:    li a2, 63
; RV32I-NEXT:    sub a2, a2, a0
; RV32I-NEXT:    andi a4, a2, 63
; RV32I-NEXT:    addi a2, a4, -32
; RV32I-NEXT:    not a3, a0
; RV32I-NEXT:    bltz a2, .LBB7_2
; RV32I-NEXT:  # %bb.1:
; RV32I-NEXT:    sll a1, a0, a4
; RV32I-NEXT:    j .LBB7_3
; RV32I-NEXT:  .LBB7_2:
; RV32I-NEXT:    sll a1, a1, a3
; RV32I-NEXT:    not a4, a4
; RV32I-NEXT:    srli a5, a0, 1
; RV32I-NEXT:    srl a4, a5, a4
; RV32I-NEXT:    or a1, a1, a4
; RV32I-NEXT:  .LBB7_3:
; RV32I-NEXT:    sll a0, a0, a3
; RV32I-NEXT:    slti a2, a2, 0
; RV32I-NEXT:    neg a2, a2
; RV32I-NEXT:    and a0, a2, a0
; RV32I-NEXT:    ret
;
; RV64I-LABEL: shl_by_masked_complemented_64:
; RV64I:       # %bb.0:
; RV64I-NEXT:    not a1, a0
; RV64I-NEXT:    sll a0, a0, a1
; RV64I-NEXT:    ret
  %a = sub i64 63, %x
  %b = and i64 %a, 63
  %c = shl i64 %x, %b
  ret i64 %c
}

define i64 @lshr_by_masked_complemented_64(i64 %x) {
; RV32I-LABEL: lshr_by_masked_complemented_64:
; RV32I:       # %bb.0:
; RV32I-NEXT:    li a2, 63
; RV32I-NEXT:    sub a2, a2, a0
; RV32I-NEXT:    andi a4, a2, 63
; RV32I-NEXT:    addi a2, a4, -32
; RV32I-NEXT:    not a3, a0
; RV32I-NEXT:    bltz a2, .LBB8_2
; RV32I-NEXT:  # %bb.1:
; RV32I-NEXT:    srl a0, a1, a4
; RV32I-NEXT:    j .LBB8_3
; RV32I-NEXT:  .LBB8_2:
; RV32I-NEXT:    srl a0, a0, a3
; RV32I-NEXT:    not a4, a4
; RV32I-NEXT:    slli a5, a1, 1
; RV32I-NEXT:    sll a4, a5, a4
; RV32I-NEXT:    or a0, a0, a4
; RV32I-NEXT:  .LBB8_3:
; RV32I-NEXT:    srl a1, a1, a3
; RV32I-NEXT:    slti a2, a2, 0
; RV32I-NEXT:    neg a2, a2
; RV32I-NEXT:    and a1, a2, a1
; RV32I-NEXT:    ret
;
; RV64I-LABEL: lshr_by_masked_complemented_64:
; RV64I:       # %bb.0:
; RV64I-NEXT:    not a1, a0
; RV64I-NEXT:    srl a0, a0, a1
; RV64I-NEXT:    ret
  %a = sub i64 63, %x
  %b = and i64 %a, 63
  %c = lshr i64 %x, %b
  ret i64 %c
}

define i64 @ashr_by_masked_complemented_64(i64 %x) {
; RV32I-LABEL: ashr_by_masked_complemented_64:
; RV32I:       # %bb.0:
; RV32I-NEXT:    li a2, 63
; RV32I-NEXT:    sub a2, a2, a0
; RV32I-NEXT:    andi a3, a2, 63
; RV32I-NEXT:    addi a4, a3, -32
; RV32I-NEXT:    mv a2, a1
; RV32I-NEXT:    bltz a4, .LBB9_2
; RV32I-NEXT:  # %bb.1:
; RV32I-NEXT:    srai a1, a2, 31
; RV32I-NEXT:    sra a0, a2, a3
; RV32I-NEXT:    ret
; RV32I-NEXT:  .LBB9_2:
; RV32I-NEXT:    not a4, a0
; RV32I-NEXT:    sra a1, a2, a4
; RV32I-NEXT:    srl a0, a0, a4
; RV32I-NEXT:    not a3, a3
; RV32I-NEXT:    slli a2, a2, 1
; RV32I-NEXT:    sll a2, a2, a3
; RV32I-NEXT:    or a0, a0, a2
; RV32I-NEXT:    ret
;
; RV64I-LABEL: ashr_by_masked_complemented_64:
; RV64I:       # %bb.0:
; RV64I-NEXT:    not a1, a0
; RV64I-NEXT:    sra a0, a0, a1
; RV64I-NEXT:    ret
  %a = sub i64 63, %x
  %b = and i64 %a, 63
  %c = ashr i64 %x, %b
  ret i64 %c
}
