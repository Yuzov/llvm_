; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s | FileCheck %s

target triple = "aarch64-unknown-linux-gnu"

declare void @def(ptr)

define void @st1d_fixed(ptr %ptr) #0 {
; CHECK-LABEL: st1d_fixed:
; CHECK:       // %bb.0:
; CHECK-NEXT:    sub sp, sp, #144
; CHECK-NEXT:    stp x30, x19, [sp, #128] // 16-byte Folded Spill
; CHECK-NEXT:    mov x19, x0
; CHECK-NEXT:    mov x0, sp
; CHECK-NEXT:    bl def
; CHECK-NEXT:    ptrue p0.d
; CHECK-NEXT:    ld2d { z0.d, z1.d }, p0/z, [sp]
; CHECK-NEXT:    st1d { z0.d }, p0, [x19]
; CHECK-NEXT:    ldp x30, x19, [sp, #128] // 16-byte Folded Reload
; CHECK-NEXT:    add sp, sp, #144
; CHECK-NEXT:    ret
  %alloc = alloca [16 x double]
  call void @def(ptr %alloc)
  %load = load <8 x double>, ptr %alloc
  %strided.vec = shufflevector <8 x double> %load, <8 x double> poison, <4 x i32> <i32 0, i32 2, i32 4, i32 6>
  store <4 x double> %strided.vec, ptr %ptr
  ret void
}

attributes #0 = { "target-features"="+sve" vscale_range(2,2) nounwind }
