; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv32 -verify-machineinstrs < %s \
; RUN:   | FileCheck %s -check-prefix=RV32I

define i32 @indirectbr(ptr %target) nounwind {
; RV32I-LABEL: indirectbr:
; RV32I:       # %bb.0:
; RV32I-NEXT:    jr a0
; RV32I-NEXT:  .LBB0_1: # %test_label
; RV32I-NEXT:    li a0, 0
; RV32I-NEXT:    ret
  indirectbr ptr %target, [label %test_label]
test_label:
  br label %ret
ret:
  ret i32 0
}

define i32 @indirectbr_with_offset(ptr %a) nounwind {
; RV32I-LABEL: indirectbr_with_offset:
; RV32I:       # %bb.0:
; RV32I-NEXT:    jr 1380(a0)
; RV32I-NEXT:  .LBB1_1: # %test_label
; RV32I-NEXT:    li a0, 0
; RV32I-NEXT:    ret
  %target = getelementptr inbounds i8, ptr %a, i32 1380
  indirectbr ptr %target, [label %test_label]
test_label:
  br label %ret
ret:
  ret i32 0
}
