; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv64 -verify-machineinstrs < %s \
; RUN:   | FileCheck -check-prefix=RV64I %s

; The test cases check that we use the si versions of the conversions from
; double.

declare i32 @llvm.experimental.constrained.fptoui.i32.f32(float, metadata)
declare i32 @llvm.experimental.constrained.fptosi.i32.f32(float, metadata)

define i32 @strict_fp32_to_ui32(float %a) nounwind strictfp {
; RV64I-LABEL: strict_fp32_to_ui32:
; RV64I:       # %bb.0: # %entry
; RV64I-NEXT:    addi sp, sp, -16
; RV64I-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    call __fixunssfsi@plt
; RV64I-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 16
; RV64I-NEXT:    ret
entry:
  %conv = tail call i32 @llvm.experimental.constrained.fptoui.i32.f32(float %a, metadata !"fpexcept.strict")
  ret i32 %conv
}

define i32 @strict_fp32_to_si32(float %a) nounwind strictfp {
; RV64I-LABEL: strict_fp32_to_si32:
; RV64I:       # %bb.0: # %entry
; RV64I-NEXT:    addi sp, sp, -16
; RV64I-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    call __fixsfsi@plt
; RV64I-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 16
; RV64I-NEXT:    ret
entry:
  %conv = tail call i32 @llvm.experimental.constrained.fptosi.i32.f32(float %a, metadata !"fpexcept.strict")
  ret i32 %conv
}
