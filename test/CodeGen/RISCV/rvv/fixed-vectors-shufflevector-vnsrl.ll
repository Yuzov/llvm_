; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=riscv64 -mattr=+v,+zfh,+experimental-zvfh,+zvl256b \
; RUN:   -verify-machineinstrs | FileCheck %s --check-prefixes=CHECK,V
; RUN: llc < %s -mtriple=riscv64 -mattr=+f,+zve32f,+zfh,+experimental-zvfh,+zvl256b \
; RUN:   -verify-machineinstrs | FileCheck %s --check-prefixes=CHECK,ZVE32F

define void @vnsrl_0_i8(ptr %in, ptr %out) {
; CHECK-LABEL: vnsrl_0_i8:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetivli zero, 16, e8, mf2, ta, ma
; CHECK-NEXT:    vle8.v v8, (a0)
; CHECK-NEXT:    vsetivli zero, 8, e8, mf4, ta, ma
; CHECK-NEXT:    vnsrl.wi v8, v8, 0
; CHECK-NEXT:    vse8.v v8, (a1)
; CHECK-NEXT:    ret
entry:
  %0 = load <16 x i8>, ptr %in, align 1
  %shuffle.i5 = shufflevector <16 x i8> %0, <16 x i8> poison, <8 x i32> <i32 0, i32 2, i32 4, i32 6, i32 8, i32 10, i32 12, i32 14>
  store <8 x i8> %shuffle.i5, ptr %out, align 1
  ret void
}

define void @vnsrl_8_i8(ptr %in, ptr %out) {
; CHECK-LABEL: vnsrl_8_i8:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetivli zero, 16, e8, mf2, ta, ma
; CHECK-NEXT:    vle8.v v8, (a0)
; CHECK-NEXT:    vsetivli zero, 8, e8, mf4, ta, ma
; CHECK-NEXT:    vnsrl.wi v8, v8, 8
; CHECK-NEXT:    vse8.v v8, (a1)
; CHECK-NEXT:    ret
entry:
  %0 = load <16 x i8>, ptr %in, align 1
  %shuffle.i5 = shufflevector <16 x i8> %0, <16 x i8> poison, <8 x i32> <i32 1, i32 3, i32 5, i32 7, i32 9, i32 11, i32 13, i32 15>
  store <8 x i8> %shuffle.i5, ptr %out, align 1
  ret void
}

define void @vnsrl_0_i16(ptr %in, ptr %out) {
; V-LABEL: vnsrl_0_i16:
; V:       # %bb.0: # %entry
; V-NEXT:    vsetivli zero, 8, e16, mf2, ta, ma
; V-NEXT:    vle16.v v8, (a0)
; V-NEXT:    vsetivli zero, 4, e16, mf4, ta, ma
; V-NEXT:    vnsrl.wi v8, v8, 0
; V-NEXT:    vse16.v v8, (a1)
; V-NEXT:    ret
;
; ZVE32F-LABEL: vnsrl_0_i16:
; ZVE32F:       # %bb.0: # %entry
; ZVE32F-NEXT:    vsetivli zero, 8, e16, mf2, ta, ma
; ZVE32F-NEXT:    vle16.v v8, (a0)
; ZVE32F-NEXT:    vsetivli zero, 4, e16, mf2, ta, ma
; ZVE32F-NEXT:    vnsrl.wi v8, v8, 0
; ZVE32F-NEXT:    vse16.v v8, (a1)
; ZVE32F-NEXT:    ret
entry:
  %0 = load <8 x i16>, ptr %in, align 2
  %shuffle.i5 = shufflevector <8 x i16> %0, <8 x i16> poison, <4 x i32> <i32 0, i32 2, i32 4, i32 6>
  store <4 x i16> %shuffle.i5, ptr %out, align 2
  ret void
}

define void @vnsrl_16_i16(ptr %in, ptr %out) {
; V-LABEL: vnsrl_16_i16:
; V:       # %bb.0: # %entry
; V-NEXT:    vsetivli zero, 8, e16, mf2, ta, ma
; V-NEXT:    vle16.v v8, (a0)
; V-NEXT:    vsetivli zero, 4, e16, mf4, ta, ma
; V-NEXT:    vnsrl.wi v8, v8, 16
; V-NEXT:    vse16.v v8, (a1)
; V-NEXT:    ret
;
; ZVE32F-LABEL: vnsrl_16_i16:
; ZVE32F:       # %bb.0: # %entry
; ZVE32F-NEXT:    vsetivli zero, 8, e16, mf2, ta, ma
; ZVE32F-NEXT:    vle16.v v8, (a0)
; ZVE32F-NEXT:    vsetivli zero, 4, e16, mf2, ta, ma
; ZVE32F-NEXT:    vnsrl.wi v8, v8, 16
; ZVE32F-NEXT:    vse16.v v8, (a1)
; ZVE32F-NEXT:    ret
entry:
  %0 = load <8 x i16>, ptr %in, align 2
  %shuffle.i5 = shufflevector <8 x i16> %0, <8 x i16> poison, <4 x i32> <i32 1, i32 3, i32 5, i32 7>
  store <4 x i16> %shuffle.i5, ptr %out, align 2
  ret void
}

define void @vnsrl_0_half(ptr %in, ptr %out) {
; V-LABEL: vnsrl_0_half:
; V:       # %bb.0: # %entry
; V-NEXT:    vsetivli zero, 8, e16, mf2, ta, ma
; V-NEXT:    vle16.v v8, (a0)
; V-NEXT:    vsetivli zero, 4, e16, mf4, ta, ma
; V-NEXT:    vnsrl.wi v8, v8, 0
; V-NEXT:    vse16.v v8, (a1)
; V-NEXT:    ret
;
; ZVE32F-LABEL: vnsrl_0_half:
; ZVE32F:       # %bb.0: # %entry
; ZVE32F-NEXT:    vsetivli zero, 8, e16, mf2, ta, ma
; ZVE32F-NEXT:    vle16.v v8, (a0)
; ZVE32F-NEXT:    vsetivli zero, 4, e16, mf2, ta, ma
; ZVE32F-NEXT:    vnsrl.wi v8, v8, 0
; ZVE32F-NEXT:    vse16.v v8, (a1)
; ZVE32F-NEXT:    ret
entry:
  %0 = load <8 x half>, ptr %in, align 2
  %shuffle.i5 = shufflevector <8 x half> %0, <8 x half> poison, <4 x i32> <i32 0, i32 2, i32 4, i32 6>
  store <4 x half> %shuffle.i5, ptr %out, align 2
  ret void
}

define void @vnsrl_16_half(ptr %in, ptr %out) {
; V-LABEL: vnsrl_16_half:
; V:       # %bb.0: # %entry
; V-NEXT:    vsetivli zero, 8, e16, mf2, ta, ma
; V-NEXT:    vle16.v v8, (a0)
; V-NEXT:    vsetivli zero, 4, e16, mf4, ta, ma
; V-NEXT:    vnsrl.wi v8, v8, 16
; V-NEXT:    vse16.v v8, (a1)
; V-NEXT:    ret
;
; ZVE32F-LABEL: vnsrl_16_half:
; ZVE32F:       # %bb.0: # %entry
; ZVE32F-NEXT:    vsetivli zero, 8, e16, mf2, ta, ma
; ZVE32F-NEXT:    vle16.v v8, (a0)
; ZVE32F-NEXT:    vsetivli zero, 4, e16, mf2, ta, ma
; ZVE32F-NEXT:    vnsrl.wi v8, v8, 16
; ZVE32F-NEXT:    vse16.v v8, (a1)
; ZVE32F-NEXT:    ret
entry:
  %0 = load <8 x half>, ptr %in, align 2
  %shuffle.i5 = shufflevector <8 x half> %0, <8 x half> poison, <4 x i32> <i32 1, i32 3, i32 5, i32 7>
  store <4 x half> %shuffle.i5, ptr %out, align 2
  ret void
}

define void @vnsrl_0_i32(ptr %in, ptr %out) {
; V-LABEL: vnsrl_0_i32:
; V:       # %bb.0: # %entry
; V-NEXT:    vsetivli zero, 4, e32, mf2, ta, ma
; V-NEXT:    vle32.v v8, (a0)
; V-NEXT:    vsetivli zero, 2, e32, mf2, ta, ma
; V-NEXT:    vnsrl.wi v8, v8, 0
; V-NEXT:    vse32.v v8, (a1)
; V-NEXT:    ret
;
; ZVE32F-LABEL: vnsrl_0_i32:
; ZVE32F:       # %bb.0: # %entry
; ZVE32F-NEXT:    vsetivli zero, 4, e32, m1, ta, ma
; ZVE32F-NEXT:    vle32.v v8, (a0)
; ZVE32F-NEXT:    vsetivli zero, 2, e32, m1, ta, mu
; ZVE32F-NEXT:    vslidedown.vi v9, v8, 2
; ZVE32F-NEXT:    li a0, 2
; ZVE32F-NEXT:    vmv.s.x v0, a0
; ZVE32F-NEXT:    vrgather.vi v10, v8, 0
; ZVE32F-NEXT:    vrgather.vi v10, v9, 0, v0.t
; ZVE32F-NEXT:    vse32.v v10, (a1)
; ZVE32F-NEXT:    ret
entry:
  %0 = load <4 x i32>, ptr %in, align 4
  %shuffle.i5 = shufflevector <4 x i32> %0, <4 x i32> poison, <2 x i32> <i32 0, i32 2>
  store <2 x i32> %shuffle.i5, ptr %out, align 4
  ret void
}

define void @vnsrl_32_i32(ptr %in, ptr %out) {
; V-LABEL: vnsrl_32_i32:
; V:       # %bb.0: # %entry
; V-NEXT:    vsetivli zero, 4, e32, mf2, ta, ma
; V-NEXT:    vle32.v v8, (a0)
; V-NEXT:    li a0, 32
; V-NEXT:    vsetivli zero, 2, e32, mf2, ta, ma
; V-NEXT:    vnsrl.wx v8, v8, a0
; V-NEXT:    vse32.v v8, (a1)
; V-NEXT:    ret
;
; ZVE32F-LABEL: vnsrl_32_i32:
; ZVE32F:       # %bb.0: # %entry
; ZVE32F-NEXT:    vsetivli zero, 4, e32, m1, ta, ma
; ZVE32F-NEXT:    vle32.v v8, (a0)
; ZVE32F-NEXT:    vsetivli zero, 2, e32, m1, ta, mu
; ZVE32F-NEXT:    vslidedown.vi v9, v8, 2
; ZVE32F-NEXT:    li a0, 2
; ZVE32F-NEXT:    vmv.s.x v0, a0
; ZVE32F-NEXT:    vrgather.vi v10, v8, 1
; ZVE32F-NEXT:    vrgather.vi v10, v9, 1, v0.t
; ZVE32F-NEXT:    vse32.v v10, (a1)
; ZVE32F-NEXT:    ret
entry:
  %0 = load <4 x i32>, ptr %in, align 4
  %shuffle.i5 = shufflevector <4 x i32> %0, <4 x i32> poison, <2 x i32> <i32 1, i32 3>
  store <2 x i32> %shuffle.i5, ptr %out, align 4
  ret void
}

define void @vnsrl_0_float(ptr %in, ptr %out) {
; V-LABEL: vnsrl_0_float:
; V:       # %bb.0: # %entry
; V-NEXT:    vsetivli zero, 4, e32, mf2, ta, ma
; V-NEXT:    vle32.v v8, (a0)
; V-NEXT:    vsetivli zero, 2, e32, mf2, ta, ma
; V-NEXT:    vnsrl.wi v8, v8, 0
; V-NEXT:    vse32.v v8, (a1)
; V-NEXT:    ret
;
; ZVE32F-LABEL: vnsrl_0_float:
; ZVE32F:       # %bb.0: # %entry
; ZVE32F-NEXT:    vsetivli zero, 4, e32, m1, ta, ma
; ZVE32F-NEXT:    vle32.v v8, (a0)
; ZVE32F-NEXT:    vsetivli zero, 2, e32, m1, ta, mu
; ZVE32F-NEXT:    vslidedown.vi v9, v8, 2
; ZVE32F-NEXT:    li a0, 2
; ZVE32F-NEXT:    vmv.s.x v0, a0
; ZVE32F-NEXT:    vrgather.vi v10, v8, 0
; ZVE32F-NEXT:    vrgather.vi v10, v9, 0, v0.t
; ZVE32F-NEXT:    vse32.v v10, (a1)
; ZVE32F-NEXT:    ret
entry:
  %0 = load <4 x float>, ptr %in, align 4
  %shuffle.i5 = shufflevector <4 x float> %0, <4 x float> poison, <2 x i32> <i32 0, i32 2>
  store <2 x float> %shuffle.i5, ptr %out, align 4
  ret void
}

define void @vnsrl_32_float(ptr %in, ptr %out) {
; V-LABEL: vnsrl_32_float:
; V:       # %bb.0: # %entry
; V-NEXT:    vsetivli zero, 4, e32, mf2, ta, ma
; V-NEXT:    vle32.v v8, (a0)
; V-NEXT:    li a0, 32
; V-NEXT:    vsetivli zero, 2, e32, mf2, ta, ma
; V-NEXT:    vnsrl.wx v8, v8, a0
; V-NEXT:    vse32.v v8, (a1)
; V-NEXT:    ret
;
; ZVE32F-LABEL: vnsrl_32_float:
; ZVE32F:       # %bb.0: # %entry
; ZVE32F-NEXT:    vsetivli zero, 4, e32, m1, ta, ma
; ZVE32F-NEXT:    vle32.v v8, (a0)
; ZVE32F-NEXT:    vsetivli zero, 2, e32, m1, ta, mu
; ZVE32F-NEXT:    vslidedown.vi v9, v8, 2
; ZVE32F-NEXT:    li a0, 2
; ZVE32F-NEXT:    vmv.s.x v0, a0
; ZVE32F-NEXT:    vrgather.vi v10, v8, 1
; ZVE32F-NEXT:    vrgather.vi v10, v9, 1, v0.t
; ZVE32F-NEXT:    vse32.v v10, (a1)
; ZVE32F-NEXT:    ret
entry:
  %0 = load <4 x float>, ptr %in, align 4
  %shuffle.i5 = shufflevector <4 x float> %0, <4 x float> poison, <2 x i32> <i32 1, i32 3>
  store <2 x float> %shuffle.i5, ptr %out, align 4
  ret void
}

define void @vnsrl_0_i64(ptr %in, ptr %out) {
; V-LABEL: vnsrl_0_i64:
; V:       # %bb.0: # %entry
; V-NEXT:    vsetivli zero, 4, e64, m1, ta, ma
; V-NEXT:    vle64.v v8, (a0)
; V-NEXT:    vsetivli zero, 2, e64, m1, ta, mu
; V-NEXT:    vslidedown.vi v9, v8, 2
; V-NEXT:    li a0, 2
; V-NEXT:    vmv.s.x v0, a0
; V-NEXT:    vrgather.vi v10, v8, 0
; V-NEXT:    vrgather.vi v10, v9, 0, v0.t
; V-NEXT:    vse64.v v10, (a1)
; V-NEXT:    ret
;
; ZVE32F-LABEL: vnsrl_0_i64:
; ZVE32F:       # %bb.0: # %entry
; ZVE32F-NEXT:    ld a2, 16(a0)
; ZVE32F-NEXT:    ld a0, 0(a0)
; ZVE32F-NEXT:    sd a2, 8(a1)
; ZVE32F-NEXT:    sd a0, 0(a1)
; ZVE32F-NEXT:    ret
entry:
  %0 = load <4 x i64>, ptr %in, align 8
  %shuffle.i5 = shufflevector <4 x i64> %0, <4 x i64> poison, <2 x i32> <i32 0, i32 2>
  store <2 x i64> %shuffle.i5, ptr %out, align 8
  ret void
}

define void @vnsrl_64_i64(ptr %in, ptr %out) {
; V-LABEL: vnsrl_64_i64:
; V:       # %bb.0: # %entry
; V-NEXT:    vsetivli zero, 4, e64, m1, ta, ma
; V-NEXT:    vle64.v v8, (a0)
; V-NEXT:    vsetivli zero, 2, e64, m1, ta, mu
; V-NEXT:    vslidedown.vi v9, v8, 2
; V-NEXT:    li a0, 2
; V-NEXT:    vmv.s.x v0, a0
; V-NEXT:    vrgather.vi v10, v8, 1
; V-NEXT:    vrgather.vi v10, v9, 1, v0.t
; V-NEXT:    vse64.v v10, (a1)
; V-NEXT:    ret
;
; ZVE32F-LABEL: vnsrl_64_i64:
; ZVE32F:       # %bb.0: # %entry
; ZVE32F-NEXT:    ld a2, 24(a0)
; ZVE32F-NEXT:    ld a0, 8(a0)
; ZVE32F-NEXT:    sd a2, 8(a1)
; ZVE32F-NEXT:    sd a0, 0(a1)
; ZVE32F-NEXT:    ret
entry:
  %0 = load <4 x i64>, ptr %in, align 8
  %shuffle.i5 = shufflevector <4 x i64> %0, <4 x i64> poison, <2 x i32> <i32 1, i32 3>
  store <2 x i64> %shuffle.i5, ptr %out, align 8
  ret void
}

define void @vnsrl_0_double(ptr %in, ptr %out) {
; V-LABEL: vnsrl_0_double:
; V:       # %bb.0: # %entry
; V-NEXT:    vsetivli zero, 4, e64, m1, ta, ma
; V-NEXT:    vle64.v v8, (a0)
; V-NEXT:    vsetivli zero, 2, e64, m1, ta, mu
; V-NEXT:    vslidedown.vi v9, v8, 2
; V-NEXT:    li a0, 2
; V-NEXT:    vmv.s.x v0, a0
; V-NEXT:    vrgather.vi v10, v8, 0
; V-NEXT:    vrgather.vi v10, v9, 0, v0.t
; V-NEXT:    vse64.v v10, (a1)
; V-NEXT:    ret
;
; ZVE32F-LABEL: vnsrl_0_double:
; ZVE32F:       # %bb.0: # %entry
; ZVE32F-NEXT:    ld a2, 16(a0)
; ZVE32F-NEXT:    ld a0, 0(a0)
; ZVE32F-NEXT:    sd a2, 8(a1)
; ZVE32F-NEXT:    sd a0, 0(a1)
; ZVE32F-NEXT:    ret
entry:
  %0 = load <4 x double>, ptr %in, align 8
  %shuffle.i5 = shufflevector <4 x double> %0, <4 x double> poison, <2 x i32> <i32 0, i32 2>
  store <2 x double> %shuffle.i5, ptr %out, align 8
  ret void
}

define void @vnsrl_64_double(ptr %in, ptr %out) {
; V-LABEL: vnsrl_64_double:
; V:       # %bb.0: # %entry
; V-NEXT:    vsetivli zero, 4, e64, m1, ta, ma
; V-NEXT:    vle64.v v8, (a0)
; V-NEXT:    vsetivli zero, 2, e64, m1, ta, mu
; V-NEXT:    vslidedown.vi v9, v8, 2
; V-NEXT:    li a0, 2
; V-NEXT:    vmv.s.x v0, a0
; V-NEXT:    vrgather.vi v10, v8, 1
; V-NEXT:    vrgather.vi v10, v9, 1, v0.t
; V-NEXT:    vse64.v v10, (a1)
; V-NEXT:    ret
;
; ZVE32F-LABEL: vnsrl_64_double:
; ZVE32F:       # %bb.0: # %entry
; ZVE32F-NEXT:    ld a2, 24(a0)
; ZVE32F-NEXT:    ld a0, 8(a0)
; ZVE32F-NEXT:    sd a2, 8(a1)
; ZVE32F-NEXT:    sd a0, 0(a1)
; ZVE32F-NEXT:    ret
entry:
  %0 = load <4 x double>, ptr %in, align 8
  %shuffle.i5 = shufflevector <4 x double> %0, <4 x double> poison, <2 x i32> <i32 1, i32 3>
  store <2 x double> %shuffle.i5, ptr %out, align 8
  ret void
}
