; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --extra_scrub
; RUN: llc -mtriple=aarch64-linux-gnu -mattr=+sve -O0 -global-isel=0 -global-isel-abort=0 < %s | FileCheck %s
; RUN: llc -mtriple=aarch64-linux-gnu -mattr=+sve -O0 -global-isel=1 -global-isel-abort=0 < %s | FileCheck %s --check-prefix=GISEL

; Test that z0 is saved/restored, as the unwinder may only retain the low 64bits (d0).
define <vscale x 4 x i32> @invoke_callee_may_throw_sve(<vscale x 4 x i32> %v) uwtable personality i8 0 {
; CHECK-LABEL: invoke_callee_may_throw_sve:
; CHECK:       .Lfunc_begin0:
; CHECK-NEXT:    .cfi_startproc
; CHECK-NEXT:  // %bb.0:
; CHECK-NEXT:    stp x29, x30, [sp, #-16]! // 16-byte Folded Spill
; CHECK-NEXT:    .cfi_def_cfa_offset 16
; CHECK-NEXT:    .cfi_offset w30, -8
; CHECK-NEXT:    .cfi_offset w29, -16
; CHECK-NEXT:    addvl sp, sp, #-18
; CHECK-NEXT:    .cfi_escape 0x0f, 0x0d, 0x8f, 0x00, 0x11, 0x10, 0x22, 0x11, 0x90, 0x01, 0x92, 0x2e, 0x00, 0x1e, 0x22 // sp + 16 + 144 * VG
; CHECK-NEXT:    str p15, [sp, #4, mul vl] // 2-byte Folded Spill
; CHECK-NEXT:    str p14, [sp, #5, mul vl] // 2-byte Folded Spill
; CHECK-NEXT:    str p13, [sp, #6, mul vl] // 2-byte Folded Spill
; CHECK-NEXT:    str p12, [sp, #7, mul vl] // 2-byte Folded Spill
; CHECK-NEXT:    str p11, [sp, #8, mul vl] // 2-byte Folded Spill
; CHECK-NEXT:    str p10, [sp, #9, mul vl] // 2-byte Folded Spill
; CHECK-NEXT:    str p9, [sp, #10, mul vl] // 2-byte Folded Spill
; CHECK-NEXT:    str p8, [sp, #11, mul vl] // 2-byte Folded Spill
; CHECK-NEXT:    str p7, [sp, #12, mul vl] // 2-byte Folded Spill
; CHECK-NEXT:    str p6, [sp, #13, mul vl] // 2-byte Folded Spill
; CHECK-NEXT:    str p5, [sp, #14, mul vl] // 2-byte Folded Spill
; CHECK-NEXT:    str p4, [sp, #15, mul vl] // 2-byte Folded Spill
; CHECK-NEXT:    str z23, [sp, #2, mul vl] // 16-byte Folded Spill
; CHECK-NEXT:    str z22, [sp, #3, mul vl] // 16-byte Folded Spill
; CHECK-NEXT:    str z21, [sp, #4, mul vl] // 16-byte Folded Spill
; CHECK-NEXT:    str z20, [sp, #5, mul vl] // 16-byte Folded Spill
; CHECK-NEXT:    str z19, [sp, #6, mul vl] // 16-byte Folded Spill
; CHECK-NEXT:    str z18, [sp, #7, mul vl] // 16-byte Folded Spill
; CHECK-NEXT:    str z17, [sp, #8, mul vl] // 16-byte Folded Spill
; CHECK-NEXT:    str z16, [sp, #9, mul vl] // 16-byte Folded Spill
; CHECK-NEXT:    str z15, [sp, #10, mul vl] // 16-byte Folded Spill
; CHECK-NEXT:    str z14, [sp, #11, mul vl] // 16-byte Folded Spill
; CHECK-NEXT:    str z13, [sp, #12, mul vl] // 16-byte Folded Spill
; CHECK-NEXT:    str z12, [sp, #13, mul vl] // 16-byte Folded Spill
; CHECK-NEXT:    str z11, [sp, #14, mul vl] // 16-byte Folded Spill
; CHECK-NEXT:    str z10, [sp, #15, mul vl] // 16-byte Folded Spill
; CHECK-NEXT:    str z9, [sp, #16, mul vl] // 16-byte Folded Spill
; CHECK-NEXT:    str z8, [sp, #17, mul vl] // 16-byte Folded Spill
; CHECK-NEXT:    .cfi_escape 0x10, 0x48, 0x0a, 0x11, 0x70, 0x22, 0x11, 0x78, 0x92, 0x2e, 0x00, 0x1e, 0x22 // $d8 @ cfa - 16 - 8 * VG
; CHECK-NEXT:    .cfi_escape 0x10, 0x49, 0x0a, 0x11, 0x70, 0x22, 0x11, 0x70, 0x92, 0x2e, 0x00, 0x1e, 0x22 // $d9 @ cfa - 16 - 16 * VG
; CHECK-NEXT:    .cfi_escape 0x10, 0x4a, 0x0a, 0x11, 0x70, 0x22, 0x11, 0x68, 0x92, 0x2e, 0x00, 0x1e, 0x22 // $d10 @ cfa - 16 - 24 * VG
; CHECK-NEXT:    .cfi_escape 0x10, 0x4b, 0x0a, 0x11, 0x70, 0x22, 0x11, 0x60, 0x92, 0x2e, 0x00, 0x1e, 0x22 // $d11 @ cfa - 16 - 32 * VG
; CHECK-NEXT:    .cfi_escape 0x10, 0x4c, 0x0a, 0x11, 0x70, 0x22, 0x11, 0x58, 0x92, 0x2e, 0x00, 0x1e, 0x22 // $d12 @ cfa - 16 - 40 * VG
; CHECK-NEXT:    .cfi_escape 0x10, 0x4d, 0x0a, 0x11, 0x70, 0x22, 0x11, 0x50, 0x92, 0x2e, 0x00, 0x1e, 0x22 // $d13 @ cfa - 16 - 48 * VG
; CHECK-NEXT:    .cfi_escape 0x10, 0x4e, 0x0a, 0x11, 0x70, 0x22, 0x11, 0x48, 0x92, 0x2e, 0x00, 0x1e, 0x22 // $d14 @ cfa - 16 - 56 * VG
; CHECK-NEXT:    .cfi_escape 0x10, 0x4f, 0x0a, 0x11, 0x70, 0x22, 0x11, 0x40, 0x92, 0x2e, 0x00, 0x1e, 0x22 // $d15 @ cfa - 16 - 64 * VG
; CHECK-NEXT:    addvl sp, sp, #-2
; CHECK-NEXT:    .cfi_escape 0x0f, 0x0d, 0x8f, 0x00, 0x11, 0x10, 0x22, 0x11, 0xa0, 0x01, 0x92, 0x2e, 0x00, 0x1e, 0x22 // sp + 16 + 160 * VG
; CHECK-NEXT:    .cfi_remember_state
; CHECK-NEXT:    str z0, [sp] // 16-byte Folded Spill
; CHECK-NEXT:  .Ltmp0:
; CHECK-NEXT:    bl may_throw_sve
; CHECK-NEXT:  .Ltmp1:
; CHECK-NEXT:    str z0, [sp, #1, mul vl] // 16-byte Folded Spill
; CHECK-NEXT:    b .LBB0_1
; CHECK-NEXT:  .LBB0_1: // %.Lcontinue
; CHECK-NEXT:    ldr z0, [sp, #1, mul vl] // 16-byte Folded Reload
; CHECK-NEXT:    addvl sp, sp, #2
; CHECK-NEXT:    .cfi_escape 0x0f, 0x0d, 0x8f, 0x00, 0x11, 0x10, 0x22, 0x11, 0x90, 0x01, 0x92, 0x2e, 0x00, 0x1e, 0x22 // sp + 16 + 144 * VG
; CHECK-NEXT:    ldr p15, [sp, #4, mul vl] // 2-byte Folded Reload
; CHECK-NEXT:    ldr p14, [sp, #5, mul vl] // 2-byte Folded Reload
; CHECK-NEXT:    ldr p13, [sp, #6, mul vl] // 2-byte Folded Reload
; CHECK-NEXT:    ldr p12, [sp, #7, mul vl] // 2-byte Folded Reload
; CHECK-NEXT:    ldr p11, [sp, #8, mul vl] // 2-byte Folded Reload
; CHECK-NEXT:    ldr p10, [sp, #9, mul vl] // 2-byte Folded Reload
; CHECK-NEXT:    ldr p9, [sp, #10, mul vl] // 2-byte Folded Reload
; CHECK-NEXT:    ldr p8, [sp, #11, mul vl] // 2-byte Folded Reload
; CHECK-NEXT:    ldr p7, [sp, #12, mul vl] // 2-byte Folded Reload
; CHECK-NEXT:    ldr p6, [sp, #13, mul vl] // 2-byte Folded Reload
; CHECK-NEXT:    ldr p5, [sp, #14, mul vl] // 2-byte Folded Reload
; CHECK-NEXT:    ldr p4, [sp, #15, mul vl] // 2-byte Folded Reload
; CHECK-NEXT:    ldr z23, [sp, #2, mul vl] // 16-byte Folded Reload
; CHECK-NEXT:    ldr z22, [sp, #3, mul vl] // 16-byte Folded Reload
; CHECK-NEXT:    ldr z21, [sp, #4, mul vl] // 16-byte Folded Reload
; CHECK-NEXT:    ldr z20, [sp, #5, mul vl] // 16-byte Folded Reload
; CHECK-NEXT:    ldr z19, [sp, #6, mul vl] // 16-byte Folded Reload
; CHECK-NEXT:    ldr z18, [sp, #7, mul vl] // 16-byte Folded Reload
; CHECK-NEXT:    ldr z17, [sp, #8, mul vl] // 16-byte Folded Reload
; CHECK-NEXT:    ldr z16, [sp, #9, mul vl] // 16-byte Folded Reload
; CHECK-NEXT:    ldr z15, [sp, #10, mul vl] // 16-byte Folded Reload
; CHECK-NEXT:    ldr z14, [sp, #11, mul vl] // 16-byte Folded Reload
; CHECK-NEXT:    ldr z13, [sp, #12, mul vl] // 16-byte Folded Reload
; CHECK-NEXT:    ldr z12, [sp, #13, mul vl] // 16-byte Folded Reload
; CHECK-NEXT:    ldr z11, [sp, #14, mul vl] // 16-byte Folded Reload
; CHECK-NEXT:    ldr z10, [sp, #15, mul vl] // 16-byte Folded Reload
; CHECK-NEXT:    ldr z9, [sp, #16, mul vl] // 16-byte Folded Reload
; CHECK-NEXT:    ldr z8, [sp, #17, mul vl] // 16-byte Folded Reload
; CHECK-NEXT:    addvl sp, sp, #18
; CHECK-NEXT:    .cfi_def_cfa wsp, 16
; CHECK-NEXT:    .cfi_restore z8
; CHECK-NEXT:    .cfi_restore z9
; CHECK-NEXT:    .cfi_restore z10
; CHECK-NEXT:    .cfi_restore z11
; CHECK-NEXT:    .cfi_restore z12
; CHECK-NEXT:    .cfi_restore z13
; CHECK-NEXT:    .cfi_restore z14
; CHECK-NEXT:    .cfi_restore z15
; CHECK-NEXT:    ldp x29, x30, [sp], #16 // 16-byte Folded Reload
; CHECK-NEXT:    .cfi_def_cfa_offset 0
; CHECK-NEXT:    .cfi_restore w30
; CHECK-NEXT:    .cfi_restore w29
; CHECK-NEXT:    ret
; CHECK-NEXT:  .LBB0_2: // %.Lunwind
; CHECK-NEXT:    .cfi_restore_state
; CHECK-NEXT:  .Ltmp2:
; CHECK-NEXT:    ldr z0, [sp] // 16-byte Folded Reload
; CHECK-NEXT:    addvl sp, sp, #2
; CHECK-NEXT:    .cfi_escape 0x0f, 0x0d, 0x8f, 0x00, 0x11, 0x10, 0x22, 0x11, 0x90, 0x01, 0x92, 0x2e, 0x00, 0x1e, 0x22 // sp + 16 + 144 * VG
; CHECK-NEXT:    ldr p15, [sp, #4, mul vl] // 2-byte Folded Reload
; CHECK-NEXT:    ldr p14, [sp, #5, mul vl] // 2-byte Folded Reload
; CHECK-NEXT:    ldr p13, [sp, #6, mul vl] // 2-byte Folded Reload
; CHECK-NEXT:    ldr p12, [sp, #7, mul vl] // 2-byte Folded Reload
; CHECK-NEXT:    ldr p11, [sp, #8, mul vl] // 2-byte Folded Reload
; CHECK-NEXT:    ldr p10, [sp, #9, mul vl] // 2-byte Folded Reload
; CHECK-NEXT:    ldr p9, [sp, #10, mul vl] // 2-byte Folded Reload
; CHECK-NEXT:    ldr p8, [sp, #11, mul vl] // 2-byte Folded Reload
; CHECK-NEXT:    ldr p7, [sp, #12, mul vl] // 2-byte Folded Reload
; CHECK-NEXT:    ldr p6, [sp, #13, mul vl] // 2-byte Folded Reload
; CHECK-NEXT:    ldr p5, [sp, #14, mul vl] // 2-byte Folded Reload
; CHECK-NEXT:    ldr p4, [sp, #15, mul vl] // 2-byte Folded Reload
; CHECK-NEXT:    ldr z23, [sp, #2, mul vl] // 16-byte Folded Reload
; CHECK-NEXT:    ldr z22, [sp, #3, mul vl] // 16-byte Folded Reload
; CHECK-NEXT:    ldr z21, [sp, #4, mul vl] // 16-byte Folded Reload
; CHECK-NEXT:    ldr z20, [sp, #5, mul vl] // 16-byte Folded Reload
; CHECK-NEXT:    ldr z19, [sp, #6, mul vl] // 16-byte Folded Reload
; CHECK-NEXT:    ldr z18, [sp, #7, mul vl] // 16-byte Folded Reload
; CHECK-NEXT:    ldr z17, [sp, #8, mul vl] // 16-byte Folded Reload
; CHECK-NEXT:    ldr z16, [sp, #9, mul vl] // 16-byte Folded Reload
; CHECK-NEXT:    ldr z15, [sp, #10, mul vl] // 16-byte Folded Reload
; CHECK-NEXT:    ldr z14, [sp, #11, mul vl] // 16-byte Folded Reload
; CHECK-NEXT:    ldr z13, [sp, #12, mul vl] // 16-byte Folded Reload
; CHECK-NEXT:    ldr z12, [sp, #13, mul vl] // 16-byte Folded Reload
; CHECK-NEXT:    ldr z11, [sp, #14, mul vl] // 16-byte Folded Reload
; CHECK-NEXT:    ldr z10, [sp, #15, mul vl] // 16-byte Folded Reload
; CHECK-NEXT:    ldr z9, [sp, #16, mul vl] // 16-byte Folded Reload
; CHECK-NEXT:    ldr z8, [sp, #17, mul vl] // 16-byte Folded Reload
; CHECK-NEXT:    addvl sp, sp, #18
; CHECK-NEXT:    .cfi_def_cfa wsp, 16
; CHECK-NEXT:    .cfi_restore z8
; CHECK-NEXT:    .cfi_restore z9
; CHECK-NEXT:    .cfi_restore z10
; CHECK-NEXT:    .cfi_restore z11
; CHECK-NEXT:    .cfi_restore z12
; CHECK-NEXT:    .cfi_restore z13
; CHECK-NEXT:    .cfi_restore z14
; CHECK-NEXT:    .cfi_restore z15
; CHECK-NEXT:    ldp x29, x30, [sp], #16 // 16-byte Folded Reload
; CHECK-NEXT:    .cfi_def_cfa_offset 0
; CHECK-NEXT:    .cfi_restore w30
; CHECK-NEXT:    .cfi_restore w29
; CHECK-NEXT:    ret
;
; GISEL-LABEL: invoke_callee_may_throw_sve:
; GISEL:       .Lfunc_begin0:
; GISEL-NEXT:    .cfi_startproc
; GISEL-NEXT:  // %bb.0:
; GISEL-NEXT:    stp x29, x30, [sp, #-16]! // 16-byte Folded Spill
; GISEL-NEXT:    .cfi_def_cfa_offset 16
; GISEL-NEXT:    .cfi_offset w30, -8
; GISEL-NEXT:    .cfi_offset w29, -16
; GISEL-NEXT:    addvl sp, sp, #-18
; GISEL-NEXT:    .cfi_escape 0x0f, 0x0d, 0x8f, 0x00, 0x11, 0x10, 0x22, 0x11, 0x90, 0x01, 0x92, 0x2e, 0x00, 0x1e, 0x22 // sp + 16 + 144 * VG
; GISEL-NEXT:    str p15, [sp, #4, mul vl] // 2-byte Folded Spill
; GISEL-NEXT:    str p14, [sp, #5, mul vl] // 2-byte Folded Spill
; GISEL-NEXT:    str p13, [sp, #6, mul vl] // 2-byte Folded Spill
; GISEL-NEXT:    str p12, [sp, #7, mul vl] // 2-byte Folded Spill
; GISEL-NEXT:    str p11, [sp, #8, mul vl] // 2-byte Folded Spill
; GISEL-NEXT:    str p10, [sp, #9, mul vl] // 2-byte Folded Spill
; GISEL-NEXT:    str p9, [sp, #10, mul vl] // 2-byte Folded Spill
; GISEL-NEXT:    str p8, [sp, #11, mul vl] // 2-byte Folded Spill
; GISEL-NEXT:    str p7, [sp, #12, mul vl] // 2-byte Folded Spill
; GISEL-NEXT:    str p6, [sp, #13, mul vl] // 2-byte Folded Spill
; GISEL-NEXT:    str p5, [sp, #14, mul vl] // 2-byte Folded Spill
; GISEL-NEXT:    str p4, [sp, #15, mul vl] // 2-byte Folded Spill
; GISEL-NEXT:    str z23, [sp, #2, mul vl] // 16-byte Folded Spill
; GISEL-NEXT:    str z22, [sp, #3, mul vl] // 16-byte Folded Spill
; GISEL-NEXT:    str z21, [sp, #4, mul vl] // 16-byte Folded Spill
; GISEL-NEXT:    str z20, [sp, #5, mul vl] // 16-byte Folded Spill
; GISEL-NEXT:    str z19, [sp, #6, mul vl] // 16-byte Folded Spill
; GISEL-NEXT:    str z18, [sp, #7, mul vl] // 16-byte Folded Spill
; GISEL-NEXT:    str z17, [sp, #8, mul vl] // 16-byte Folded Spill
; GISEL-NEXT:    str z16, [sp, #9, mul vl] // 16-byte Folded Spill
; GISEL-NEXT:    str z15, [sp, #10, mul vl] // 16-byte Folded Spill
; GISEL-NEXT:    str z14, [sp, #11, mul vl] // 16-byte Folded Spill
; GISEL-NEXT:    str z13, [sp, #12, mul vl] // 16-byte Folded Spill
; GISEL-NEXT:    str z12, [sp, #13, mul vl] // 16-byte Folded Spill
; GISEL-NEXT:    str z11, [sp, #14, mul vl] // 16-byte Folded Spill
; GISEL-NEXT:    str z10, [sp, #15, mul vl] // 16-byte Folded Spill
; GISEL-NEXT:    str z9, [sp, #16, mul vl] // 16-byte Folded Spill
; GISEL-NEXT:    str z8, [sp, #17, mul vl] // 16-byte Folded Spill
; GISEL-NEXT:    .cfi_escape 0x10, 0x48, 0x0a, 0x11, 0x70, 0x22, 0x11, 0x78, 0x92, 0x2e, 0x00, 0x1e, 0x22 // $d8 @ cfa - 16 - 8 * VG
; GISEL-NEXT:    .cfi_escape 0x10, 0x49, 0x0a, 0x11, 0x70, 0x22, 0x11, 0x70, 0x92, 0x2e, 0x00, 0x1e, 0x22 // $d9 @ cfa - 16 - 16 * VG
; GISEL-NEXT:    .cfi_escape 0x10, 0x4a, 0x0a, 0x11, 0x70, 0x22, 0x11, 0x68, 0x92, 0x2e, 0x00, 0x1e, 0x22 // $d10 @ cfa - 16 - 24 * VG
; GISEL-NEXT:    .cfi_escape 0x10, 0x4b, 0x0a, 0x11, 0x70, 0x22, 0x11, 0x60, 0x92, 0x2e, 0x00, 0x1e, 0x22 // $d11 @ cfa - 16 - 32 * VG
; GISEL-NEXT:    .cfi_escape 0x10, 0x4c, 0x0a, 0x11, 0x70, 0x22, 0x11, 0x58, 0x92, 0x2e, 0x00, 0x1e, 0x22 // $d12 @ cfa - 16 - 40 * VG
; GISEL-NEXT:    .cfi_escape 0x10, 0x4d, 0x0a, 0x11, 0x70, 0x22, 0x11, 0x50, 0x92, 0x2e, 0x00, 0x1e, 0x22 // $d13 @ cfa - 16 - 48 * VG
; GISEL-NEXT:    .cfi_escape 0x10, 0x4e, 0x0a, 0x11, 0x70, 0x22, 0x11, 0x48, 0x92, 0x2e, 0x00, 0x1e, 0x22 // $d14 @ cfa - 16 - 56 * VG
; GISEL-NEXT:    .cfi_escape 0x10, 0x4f, 0x0a, 0x11, 0x70, 0x22, 0x11, 0x40, 0x92, 0x2e, 0x00, 0x1e, 0x22 // $d15 @ cfa - 16 - 64 * VG
; GISEL-NEXT:    addvl sp, sp, #-2
; GISEL-NEXT:    .cfi_escape 0x0f, 0x0d, 0x8f, 0x00, 0x11, 0x10, 0x22, 0x11, 0xa0, 0x01, 0x92, 0x2e, 0x00, 0x1e, 0x22 // sp + 16 + 160 * VG
; GISEL-NEXT:    .cfi_remember_state
; GISEL-NEXT:    str z0, [sp] // 16-byte Folded Spill
; GISEL-NEXT:  .Ltmp0:
; GISEL-NEXT:    bl may_throw_sve
; GISEL-NEXT:  .Ltmp1:
; GISEL-NEXT:    str z0, [sp, #1, mul vl] // 16-byte Folded Spill
; GISEL-NEXT:    b .LBB0_1
; GISEL-NEXT:  .LBB0_1: // %.Lcontinue
; GISEL-NEXT:    ldr z0, [sp, #1, mul vl] // 16-byte Folded Reload
; GISEL-NEXT:    addvl sp, sp, #2
; GISEL-NEXT:    .cfi_escape 0x0f, 0x0d, 0x8f, 0x00, 0x11, 0x10, 0x22, 0x11, 0x90, 0x01, 0x92, 0x2e, 0x00, 0x1e, 0x22 // sp + 16 + 144 * VG
; GISEL-NEXT:    ldr p15, [sp, #4, mul vl] // 2-byte Folded Reload
; GISEL-NEXT:    ldr p14, [sp, #5, mul vl] // 2-byte Folded Reload
; GISEL-NEXT:    ldr p13, [sp, #6, mul vl] // 2-byte Folded Reload
; GISEL-NEXT:    ldr p12, [sp, #7, mul vl] // 2-byte Folded Reload
; GISEL-NEXT:    ldr p11, [sp, #8, mul vl] // 2-byte Folded Reload
; GISEL-NEXT:    ldr p10, [sp, #9, mul vl] // 2-byte Folded Reload
; GISEL-NEXT:    ldr p9, [sp, #10, mul vl] // 2-byte Folded Reload
; GISEL-NEXT:    ldr p8, [sp, #11, mul vl] // 2-byte Folded Reload
; GISEL-NEXT:    ldr p7, [sp, #12, mul vl] // 2-byte Folded Reload
; GISEL-NEXT:    ldr p6, [sp, #13, mul vl] // 2-byte Folded Reload
; GISEL-NEXT:    ldr p5, [sp, #14, mul vl] // 2-byte Folded Reload
; GISEL-NEXT:    ldr p4, [sp, #15, mul vl] // 2-byte Folded Reload
; GISEL-NEXT:    ldr z23, [sp, #2, mul vl] // 16-byte Folded Reload
; GISEL-NEXT:    ldr z22, [sp, #3, mul vl] // 16-byte Folded Reload
; GISEL-NEXT:    ldr z21, [sp, #4, mul vl] // 16-byte Folded Reload
; GISEL-NEXT:    ldr z20, [sp, #5, mul vl] // 16-byte Folded Reload
; GISEL-NEXT:    ldr z19, [sp, #6, mul vl] // 16-byte Folded Reload
; GISEL-NEXT:    ldr z18, [sp, #7, mul vl] // 16-byte Folded Reload
; GISEL-NEXT:    ldr z17, [sp, #8, mul vl] // 16-byte Folded Reload
; GISEL-NEXT:    ldr z16, [sp, #9, mul vl] // 16-byte Folded Reload
; GISEL-NEXT:    ldr z15, [sp, #10, mul vl] // 16-byte Folded Reload
; GISEL-NEXT:    ldr z14, [sp, #11, mul vl] // 16-byte Folded Reload
; GISEL-NEXT:    ldr z13, [sp, #12, mul vl] // 16-byte Folded Reload
; GISEL-NEXT:    ldr z12, [sp, #13, mul vl] // 16-byte Folded Reload
; GISEL-NEXT:    ldr z11, [sp, #14, mul vl] // 16-byte Folded Reload
; GISEL-NEXT:    ldr z10, [sp, #15, mul vl] // 16-byte Folded Reload
; GISEL-NEXT:    ldr z9, [sp, #16, mul vl] // 16-byte Folded Reload
; GISEL-NEXT:    ldr z8, [sp, #17, mul vl] // 16-byte Folded Reload
; GISEL-NEXT:    addvl sp, sp, #18
; GISEL-NEXT:    .cfi_def_cfa wsp, 16
; GISEL-NEXT:    .cfi_restore z8
; GISEL-NEXT:    .cfi_restore z9
; GISEL-NEXT:    .cfi_restore z10
; GISEL-NEXT:    .cfi_restore z11
; GISEL-NEXT:    .cfi_restore z12
; GISEL-NEXT:    .cfi_restore z13
; GISEL-NEXT:    .cfi_restore z14
; GISEL-NEXT:    .cfi_restore z15
; GISEL-NEXT:    ldp x29, x30, [sp], #16 // 16-byte Folded Reload
; GISEL-NEXT:    .cfi_def_cfa_offset 0
; GISEL-NEXT:    .cfi_restore w30
; GISEL-NEXT:    .cfi_restore w29
; GISEL-NEXT:    ret
; GISEL-NEXT:  .LBB0_2: // %.Lunwind
; GISEL-NEXT:    .cfi_restore_state
; GISEL-NEXT:  .Ltmp2:
; GISEL-NEXT:    ldr z0, [sp] // 16-byte Folded Reload
; GISEL-NEXT:    addvl sp, sp, #2
; GISEL-NEXT:    .cfi_escape 0x0f, 0x0d, 0x8f, 0x00, 0x11, 0x10, 0x22, 0x11, 0x90, 0x01, 0x92, 0x2e, 0x00, 0x1e, 0x22 // sp + 16 + 144 * VG
; GISEL-NEXT:    ldr p15, [sp, #4, mul vl] // 2-byte Folded Reload
; GISEL-NEXT:    ldr p14, [sp, #5, mul vl] // 2-byte Folded Reload
; GISEL-NEXT:    ldr p13, [sp, #6, mul vl] // 2-byte Folded Reload
; GISEL-NEXT:    ldr p12, [sp, #7, mul vl] // 2-byte Folded Reload
; GISEL-NEXT:    ldr p11, [sp, #8, mul vl] // 2-byte Folded Reload
; GISEL-NEXT:    ldr p10, [sp, #9, mul vl] // 2-byte Folded Reload
; GISEL-NEXT:    ldr p9, [sp, #10, mul vl] // 2-byte Folded Reload
; GISEL-NEXT:    ldr p8, [sp, #11, mul vl] // 2-byte Folded Reload
; GISEL-NEXT:    ldr p7, [sp, #12, mul vl] // 2-byte Folded Reload
; GISEL-NEXT:    ldr p6, [sp, #13, mul vl] // 2-byte Folded Reload
; GISEL-NEXT:    ldr p5, [sp, #14, mul vl] // 2-byte Folded Reload
; GISEL-NEXT:    ldr p4, [sp, #15, mul vl] // 2-byte Folded Reload
; GISEL-NEXT:    ldr z23, [sp, #2, mul vl] // 16-byte Folded Reload
; GISEL-NEXT:    ldr z22, [sp, #3, mul vl] // 16-byte Folded Reload
; GISEL-NEXT:    ldr z21, [sp, #4, mul vl] // 16-byte Folded Reload
; GISEL-NEXT:    ldr z20, [sp, #5, mul vl] // 16-byte Folded Reload
; GISEL-NEXT:    ldr z19, [sp, #6, mul vl] // 16-byte Folded Reload
; GISEL-NEXT:    ldr z18, [sp, #7, mul vl] // 16-byte Folded Reload
; GISEL-NEXT:    ldr z17, [sp, #8, mul vl] // 16-byte Folded Reload
; GISEL-NEXT:    ldr z16, [sp, #9, mul vl] // 16-byte Folded Reload
; GISEL-NEXT:    ldr z15, [sp, #10, mul vl] // 16-byte Folded Reload
; GISEL-NEXT:    ldr z14, [sp, #11, mul vl] // 16-byte Folded Reload
; GISEL-NEXT:    ldr z13, [sp, #12, mul vl] // 16-byte Folded Reload
; GISEL-NEXT:    ldr z12, [sp, #13, mul vl] // 16-byte Folded Reload
; GISEL-NEXT:    ldr z11, [sp, #14, mul vl] // 16-byte Folded Reload
; GISEL-NEXT:    ldr z10, [sp, #15, mul vl] // 16-byte Folded Reload
; GISEL-NEXT:    ldr z9, [sp, #16, mul vl] // 16-byte Folded Reload
; GISEL-NEXT:    ldr z8, [sp, #17, mul vl] // 16-byte Folded Reload
; GISEL-NEXT:    addvl sp, sp, #18
; GISEL-NEXT:    .cfi_def_cfa wsp, 16
; GISEL-NEXT:    .cfi_restore z8
; GISEL-NEXT:    .cfi_restore z9
; GISEL-NEXT:    .cfi_restore z10
; GISEL-NEXT:    .cfi_restore z11
; GISEL-NEXT:    .cfi_restore z12
; GISEL-NEXT:    .cfi_restore z13
; GISEL-NEXT:    .cfi_restore z14
; GISEL-NEXT:    .cfi_restore z15
; GISEL-NEXT:    ldp x29, x30, [sp], #16 // 16-byte Folded Reload
; GISEL-NEXT:    .cfi_def_cfa_offset 0
; GISEL-NEXT:    .cfi_restore w30
; GISEL-NEXT:    .cfi_restore w29
; GISEL-NEXT:    ret
  %result = invoke <vscale x 4 x i32> @may_throw_sve(<vscale x 4 x i32> %v) to label %.Lcontinue unwind label %.Lunwind
.Lcontinue:
  ret <vscale x 4 x i32> %result
.Lunwind:
  %lp = landingpad { ptr, i32 } cleanup
  ret <vscale x 4 x i32> %v;
}

declare <vscale x 4 x i32> @may_throw_sve(<vscale x 4 x i32> %v);


; Test that q0 is saved/restored, as the unwinder may only retain the low 64bits (d0).
define aarch64_vector_pcs <4 x i32> @invoke_callee_may_throw_neon(<4 x i32> %v) uwtable personality i8 0 {
; CHECK-LABEL: invoke_callee_may_throw_neon:
; CHECK:       .Lfunc_begin1:
; CHECK-NEXT:    .cfi_startproc
; CHECK-NEXT:  // %bb.0:
; CHECK-NEXT:    sub sp, sp, #304
; CHECK-NEXT:    .cfi_def_cfa_offset 304
; CHECK-NEXT:    stp q23, q22, [sp, #32] // 32-byte Folded Spill
; CHECK-NEXT:    stp q21, q20, [sp, #64] // 32-byte Folded Spill
; CHECK-NEXT:    stp q19, q18, [sp, #96] // 32-byte Folded Spill
; CHECK-NEXT:    stp q17, q16, [sp, #128] // 32-byte Folded Spill
; CHECK-NEXT:    stp q15, q14, [sp, #160] // 32-byte Folded Spill
; CHECK-NEXT:    stp q13, q12, [sp, #192] // 32-byte Folded Spill
; CHECK-NEXT:    stp q11, q10, [sp, #224] // 32-byte Folded Spill
; CHECK-NEXT:    stp q9, q8, [sp, #256] // 32-byte Folded Spill
; CHECK-NEXT:    stp x29, x30, [sp, #288] // 16-byte Folded Spill
; CHECK-NEXT:    .cfi_offset w30, -8
; CHECK-NEXT:    .cfi_offset w29, -16
; CHECK-NEXT:    .cfi_offset b8, -32
; CHECK-NEXT:    .cfi_offset b9, -48
; CHECK-NEXT:    .cfi_offset b10, -64
; CHECK-NEXT:    .cfi_offset b11, -80
; CHECK-NEXT:    .cfi_offset b12, -96
; CHECK-NEXT:    .cfi_offset b13, -112
; CHECK-NEXT:    .cfi_offset b14, -128
; CHECK-NEXT:    .cfi_offset b15, -144
; CHECK-NEXT:    .cfi_offset b16, -160
; CHECK-NEXT:    .cfi_offset b17, -176
; CHECK-NEXT:    .cfi_offset b18, -192
; CHECK-NEXT:    .cfi_offset b19, -208
; CHECK-NEXT:    .cfi_offset b20, -224
; CHECK-NEXT:    .cfi_offset b21, -240
; CHECK-NEXT:    .cfi_offset b22, -256
; CHECK-NEXT:    .cfi_offset b23, -272
; CHECK-NEXT:    .cfi_remember_state
; CHECK-NEXT:    str q0, [sp] // 16-byte Folded Spill
; CHECK-NEXT:  .Ltmp3:
; CHECK-NEXT:    bl may_throw_neon
; CHECK-NEXT:  .Ltmp4:
; CHECK-NEXT:    str q0, [sp, #16] // 16-byte Folded Spill
; CHECK-NEXT:    b .LBB1_1
; CHECK-NEXT:  .LBB1_1: // %.Lcontinue
; CHECK-NEXT:    ldr q0, [sp, #16] // 16-byte Folded Reload
; CHECK-NEXT:    ldp x29, x30, [sp, #288] // 16-byte Folded Reload
; CHECK-NEXT:    ldp q9, q8, [sp, #256] // 32-byte Folded Reload
; CHECK-NEXT:    ldp q11, q10, [sp, #224] // 32-byte Folded Reload
; CHECK-NEXT:    ldp q13, q12, [sp, #192] // 32-byte Folded Reload
; CHECK-NEXT:    ldp q15, q14, [sp, #160] // 32-byte Folded Reload
; CHECK-NEXT:    ldp q17, q16, [sp, #128] // 32-byte Folded Reload
; CHECK-NEXT:    ldp q19, q18, [sp, #96] // 32-byte Folded Reload
; CHECK-NEXT:    ldp q21, q20, [sp, #64] // 32-byte Folded Reload
; CHECK-NEXT:    ldp q23, q22, [sp, #32] // 32-byte Folded Reload
; CHECK-NEXT:    add sp, sp, #304
; CHECK-NEXT:    .cfi_def_cfa_offset 0
; CHECK-NEXT:    .cfi_restore w30
; CHECK-NEXT:    .cfi_restore w29
; CHECK-NEXT:    .cfi_restore b8
; CHECK-NEXT:    .cfi_restore b9
; CHECK-NEXT:    .cfi_restore b10
; CHECK-NEXT:    .cfi_restore b11
; CHECK-NEXT:    .cfi_restore b12
; CHECK-NEXT:    .cfi_restore b13
; CHECK-NEXT:    .cfi_restore b14
; CHECK-NEXT:    .cfi_restore b15
; CHECK-NEXT:    .cfi_restore b16
; CHECK-NEXT:    .cfi_restore b17
; CHECK-NEXT:    .cfi_restore b18
; CHECK-NEXT:    .cfi_restore b19
; CHECK-NEXT:    .cfi_restore b20
; CHECK-NEXT:    .cfi_restore b21
; CHECK-NEXT:    .cfi_restore b22
; CHECK-NEXT:    .cfi_restore b23
; CHECK-NEXT:    ret
; CHECK-NEXT:  .LBB1_2: // %.Lunwind
; CHECK-NEXT:    .cfi_restore_state
; CHECK-NEXT:  .Ltmp5:
; CHECK-NEXT:    ldr q0, [sp] // 16-byte Folded Reload
; CHECK-NEXT:    ldp x29, x30, [sp, #288] // 16-byte Folded Reload
; CHECK-NEXT:    ldp q9, q8, [sp, #256] // 32-byte Folded Reload
; CHECK-NEXT:    ldp q11, q10, [sp, #224] // 32-byte Folded Reload
; CHECK-NEXT:    ldp q13, q12, [sp, #192] // 32-byte Folded Reload
; CHECK-NEXT:    ldp q15, q14, [sp, #160] // 32-byte Folded Reload
; CHECK-NEXT:    ldp q17, q16, [sp, #128] // 32-byte Folded Reload
; CHECK-NEXT:    ldp q19, q18, [sp, #96] // 32-byte Folded Reload
; CHECK-NEXT:    ldp q21, q20, [sp, #64] // 32-byte Folded Reload
; CHECK-NEXT:    ldp q23, q22, [sp, #32] // 32-byte Folded Reload
; CHECK-NEXT:    add sp, sp, #304
; CHECK-NEXT:    .cfi_def_cfa_offset 0
; CHECK-NEXT:    .cfi_restore w30
; CHECK-NEXT:    .cfi_restore w29
; CHECK-NEXT:    .cfi_restore b8
; CHECK-NEXT:    .cfi_restore b9
; CHECK-NEXT:    .cfi_restore b10
; CHECK-NEXT:    .cfi_restore b11
; CHECK-NEXT:    .cfi_restore b12
; CHECK-NEXT:    .cfi_restore b13
; CHECK-NEXT:    .cfi_restore b14
; CHECK-NEXT:    .cfi_restore b15
; CHECK-NEXT:    .cfi_restore b16
; CHECK-NEXT:    .cfi_restore b17
; CHECK-NEXT:    .cfi_restore b18
; CHECK-NEXT:    .cfi_restore b19
; CHECK-NEXT:    .cfi_restore b20
; CHECK-NEXT:    .cfi_restore b21
; CHECK-NEXT:    .cfi_restore b22
; CHECK-NEXT:    .cfi_restore b23
; CHECK-NEXT:    ret
;
; GISEL-LABEL: invoke_callee_may_throw_neon:
; GISEL:       .Lfunc_begin1:
; GISEL-NEXT:    .cfi_startproc
; GISEL-NEXT:  // %bb.0:
; GISEL-NEXT:    sub sp, sp, #304
; GISEL-NEXT:    .cfi_def_cfa_offset 304
; GISEL-NEXT:    stp q23, q22, [sp, #32] // 32-byte Folded Spill
; GISEL-NEXT:    stp q21, q20, [sp, #64] // 32-byte Folded Spill
; GISEL-NEXT:    stp q19, q18, [sp, #96] // 32-byte Folded Spill
; GISEL-NEXT:    stp q17, q16, [sp, #128] // 32-byte Folded Spill
; GISEL-NEXT:    stp q15, q14, [sp, #160] // 32-byte Folded Spill
; GISEL-NEXT:    stp q13, q12, [sp, #192] // 32-byte Folded Spill
; GISEL-NEXT:    stp q11, q10, [sp, #224] // 32-byte Folded Spill
; GISEL-NEXT:    stp q9, q8, [sp, #256] // 32-byte Folded Spill
; GISEL-NEXT:    stp x29, x30, [sp, #288] // 16-byte Folded Spill
; GISEL-NEXT:    .cfi_offset w30, -8
; GISEL-NEXT:    .cfi_offset w29, -16
; GISEL-NEXT:    .cfi_offset b8, -32
; GISEL-NEXT:    .cfi_offset b9, -48
; GISEL-NEXT:    .cfi_offset b10, -64
; GISEL-NEXT:    .cfi_offset b11, -80
; GISEL-NEXT:    .cfi_offset b12, -96
; GISEL-NEXT:    .cfi_offset b13, -112
; GISEL-NEXT:    .cfi_offset b14, -128
; GISEL-NEXT:    .cfi_offset b15, -144
; GISEL-NEXT:    .cfi_offset b16, -160
; GISEL-NEXT:    .cfi_offset b17, -176
; GISEL-NEXT:    .cfi_offset b18, -192
; GISEL-NEXT:    .cfi_offset b19, -208
; GISEL-NEXT:    .cfi_offset b20, -224
; GISEL-NEXT:    .cfi_offset b21, -240
; GISEL-NEXT:    .cfi_offset b22, -256
; GISEL-NEXT:    .cfi_offset b23, -272
; GISEL-NEXT:    .cfi_remember_state
; GISEL-NEXT:    str q0, [sp] // 16-byte Folded Spill
; GISEL-NEXT:  .Ltmp3:
; GISEL-NEXT:    bl may_throw_neon
; GISEL-NEXT:    str q0, [sp, #16] // 16-byte Folded Spill
; GISEL-NEXT:  .Ltmp4:
; GISEL-NEXT:    b .LBB1_1
; GISEL-NEXT:  .LBB1_1: // %.Lcontinue
; GISEL-NEXT:    ldr q0, [sp, #16] // 16-byte Folded Reload
; GISEL-NEXT:    ldp x29, x30, [sp, #288] // 16-byte Folded Reload
; GISEL-NEXT:    ldp q9, q8, [sp, #256] // 32-byte Folded Reload
; GISEL-NEXT:    ldp q11, q10, [sp, #224] // 32-byte Folded Reload
; GISEL-NEXT:    ldp q13, q12, [sp, #192] // 32-byte Folded Reload
; GISEL-NEXT:    ldp q15, q14, [sp, #160] // 32-byte Folded Reload
; GISEL-NEXT:    ldp q17, q16, [sp, #128] // 32-byte Folded Reload
; GISEL-NEXT:    ldp q19, q18, [sp, #96] // 32-byte Folded Reload
; GISEL-NEXT:    ldp q21, q20, [sp, #64] // 32-byte Folded Reload
; GISEL-NEXT:    ldp q23, q22, [sp, #32] // 32-byte Folded Reload
; GISEL-NEXT:    add sp, sp, #304
; GISEL-NEXT:    .cfi_def_cfa_offset 0
; GISEL-NEXT:    .cfi_restore w30
; GISEL-NEXT:    .cfi_restore w29
; GISEL-NEXT:    .cfi_restore b8
; GISEL-NEXT:    .cfi_restore b9
; GISEL-NEXT:    .cfi_restore b10
; GISEL-NEXT:    .cfi_restore b11
; GISEL-NEXT:    .cfi_restore b12
; GISEL-NEXT:    .cfi_restore b13
; GISEL-NEXT:    .cfi_restore b14
; GISEL-NEXT:    .cfi_restore b15
; GISEL-NEXT:    .cfi_restore b16
; GISEL-NEXT:    .cfi_restore b17
; GISEL-NEXT:    .cfi_restore b18
; GISEL-NEXT:    .cfi_restore b19
; GISEL-NEXT:    .cfi_restore b20
; GISEL-NEXT:    .cfi_restore b21
; GISEL-NEXT:    .cfi_restore b22
; GISEL-NEXT:    .cfi_restore b23
; GISEL-NEXT:    ret
; GISEL-NEXT:  .LBB1_2: // %.Lunwind
; GISEL-NEXT:    .cfi_restore_state
; GISEL-NEXT:  .Ltmp5:
; GISEL-NEXT:    ldr q0, [sp] // 16-byte Folded Reload
; GISEL-NEXT:    ldp x29, x30, [sp, #288] // 16-byte Folded Reload
; GISEL-NEXT:    ldp q9, q8, [sp, #256] // 32-byte Folded Reload
; GISEL-NEXT:    ldp q11, q10, [sp, #224] // 32-byte Folded Reload
; GISEL-NEXT:    ldp q13, q12, [sp, #192] // 32-byte Folded Reload
; GISEL-NEXT:    ldp q15, q14, [sp, #160] // 32-byte Folded Reload
; GISEL-NEXT:    ldp q17, q16, [sp, #128] // 32-byte Folded Reload
; GISEL-NEXT:    ldp q19, q18, [sp, #96] // 32-byte Folded Reload
; GISEL-NEXT:    ldp q21, q20, [sp, #64] // 32-byte Folded Reload
; GISEL-NEXT:    ldp q23, q22, [sp, #32] // 32-byte Folded Reload
; GISEL-NEXT:    add sp, sp, #304
; GISEL-NEXT:    .cfi_def_cfa_offset 0
; GISEL-NEXT:    .cfi_restore w30
; GISEL-NEXT:    .cfi_restore w29
; GISEL-NEXT:    .cfi_restore b8
; GISEL-NEXT:    .cfi_restore b9
; GISEL-NEXT:    .cfi_restore b10
; GISEL-NEXT:    .cfi_restore b11
; GISEL-NEXT:    .cfi_restore b12
; GISEL-NEXT:    .cfi_restore b13
; GISEL-NEXT:    .cfi_restore b14
; GISEL-NEXT:    .cfi_restore b15
; GISEL-NEXT:    .cfi_restore b16
; GISEL-NEXT:    .cfi_restore b17
; GISEL-NEXT:    .cfi_restore b18
; GISEL-NEXT:    .cfi_restore b19
; GISEL-NEXT:    .cfi_restore b20
; GISEL-NEXT:    .cfi_restore b21
; GISEL-NEXT:    .cfi_restore b22
; GISEL-NEXT:    .cfi_restore b23
; GISEL-NEXT:    ret
  %result = invoke aarch64_vector_pcs <4 x i32> @may_throw_neon(<4 x i32> %v) to label %.Lcontinue unwind label %.Lunwind
.Lcontinue:
  ret <4 x i32> %result
.Lunwind:
  %lp = landingpad { ptr, i32 } cleanup
  ret <4 x i32> %v;
}

declare aarch64_vector_pcs <4 x i32> @may_throw_neon(<4 x i32> %v);
