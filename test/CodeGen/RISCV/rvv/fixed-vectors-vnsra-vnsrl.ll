; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv32 -mattr=+v -riscv-v-vector-bits-min=128 -verify-machineinstrs < %s | FileCheck %s
; RUN: llc -mtriple=riscv64 -mattr=+v -riscv-v-vector-bits-min=128 -verify-machineinstrs < %s | FileCheck %s

define <8 x i8> @vnsra_v8i16_v8i8_scalar(<8 x i16> %x, i16 %y) {
; CHECK-LABEL: vnsra_v8i16_v8i8_scalar:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 8, e8, mf2, ta, ma
; CHECK-NEXT:    vnsra.wx v8, v8, a0
; CHECK-NEXT:    ret
  %insert = insertelement <8 x i16> poison, i16 %y, i16 0
  %splat = shufflevector <8 x i16> %insert, <8 x i16> poison, <8 x i32> zeroinitializer
  %a = ashr <8 x i16> %x, %splat
  %b = trunc <8 x i16> %a to <8 x i8>
  ret <8 x i8> %b
}

define <8 x i8> @vnsra_v8i16_v8i8_scalar_sext(<8 x i16> %x, i8 %y) {
; CHECK-LABEL: vnsra_v8i16_v8i8_scalar_sext:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 8, e8, mf2, ta, ma
; CHECK-NEXT:    vnsra.wx v8, v8, a0
; CHECK-NEXT:    ret
  %insert = insertelement <8 x i8> poison, i8 %y, i8 0
  %splat = shufflevector <8 x i8> %insert, <8 x i8> poison, <8 x i32> zeroinitializer
  %sext = sext <8 x i8> %splat to <8 x i16>
  %a = ashr <8 x i16> %x, %sext
  %b = trunc <8 x i16> %a to <8 x i8>
  ret <8 x i8> %b
}

define <8 x i8> @vnsra_v8i16_v8i8_scalar_zext(<8 x i16> %x, i8 %y) {
; CHECK-LABEL: vnsra_v8i16_v8i8_scalar_zext:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 8, e8, mf2, ta, ma
; CHECK-NEXT:    vnsra.wx v8, v8, a0
; CHECK-NEXT:    ret
  %insert = insertelement <8 x i8> poison, i8 %y, i8 0
  %splat = shufflevector <8 x i8> %insert, <8 x i8> poison, <8 x i32> zeroinitializer
  %zext = zext <8 x i8> %splat to <8 x i16>
  %a = ashr <8 x i16> %x, %zext
  %b = trunc <8 x i16> %a to <8 x i8>
  ret <8 x i8> %b
}

define <4 x i16> @vnsra_v4i32_v4i16_scalar(<4 x i32> %x, i32 %y) {
; CHECK-LABEL: vnsra_v4i32_v4i16_scalar:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 4, e16, mf2, ta, ma
; CHECK-NEXT:    vnsra.wx v8, v8, a0
; CHECK-NEXT:    ret
  %insert = insertelement <4 x i32> poison, i32 %y, i32 0
  %splat = shufflevector <4 x i32> %insert, <4 x i32> poison, <4 x i32> zeroinitializer
  %a = ashr <4 x i32> %x, %splat
  %b = trunc <4 x i32> %a to <4 x i16>
  ret <4 x i16> %b
}

define <4 x i16> @vnsra_v4i32_v4i16_scalar_sext(<4 x i32> %x, i16 %y) {
; CHECK-LABEL: vnsra_v4i32_v4i16_scalar_sext:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 4, e16, mf2, ta, ma
; CHECK-NEXT:    vnsra.wx v8, v8, a0
; CHECK-NEXT:    ret
  %insert = insertelement <4 x i16> poison, i16 %y, i16 0
  %splat = shufflevector <4 x i16> %insert, <4 x i16> poison, <4 x i32> zeroinitializer
  %sext = sext <4 x i16> %splat to <4 x i32>
  %a = ashr <4 x i32> %x, %sext
  %b = trunc <4 x i32> %a to <4 x i16>
  ret <4 x i16> %b
}

define <4 x i16> @vnsra_v4i32_v4i16_scalar_zext(<4 x i32> %x, i16 %y) {
; CHECK-LABEL: vnsra_v4i32_v4i16_scalar_zext:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 4, e16, mf2, ta, ma
; CHECK-NEXT:    vnsra.wx v8, v8, a0
; CHECK-NEXT:    ret
  %insert = insertelement <4 x i16> poison, i16 %y, i16 0
  %splat = shufflevector <4 x i16> %insert, <4 x i16> poison, <4 x i32> zeroinitializer
  %zext = zext <4 x i16> %splat to <4 x i32>
  %a = ashr <4 x i32> %x, %zext
  %b = trunc <4 x i32> %a to <4 x i16>
  ret <4 x i16> %b
}

define <2 x i32> @vnsra_v2i64_v2i32_scalar(<2 x i64> %x, i64 %y) {
; CHECK-LABEL: vnsra_v2i64_v2i32_scalar:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 2, e32, mf2, ta, ma
; CHECK-NEXT:    vnsra.wx v8, v8, a0
; CHECK-NEXT:    ret
  %insert = insertelement <2 x i64> poison, i64 %y, i32 0
  %splat = shufflevector <2 x i64> %insert, <2 x i64> poison, <2 x i32> zeroinitializer
  %a = ashr <2 x i64> %x, %splat
  %b = trunc <2 x i64> %a to <2 x i32>
  ret <2 x i32> %b
}

define <2 x i32> @vnsra_v2i64_v2i32_scalar_sext(<2 x i64> %x, i32 %y) {
; CHECK-LABEL: vnsra_v2i64_v2i32_scalar_sext:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 2, e32, mf2, ta, ma
; CHECK-NEXT:    vnsra.wx v8, v8, a0
; CHECK-NEXT:    ret
  %insert = insertelement <2 x i32> poison, i32 %y, i32 0
  %splat = shufflevector <2 x i32> %insert, <2 x i32> poison, <2 x i32> zeroinitializer
  %sext = sext <2 x i32> %splat to <2 x i64>
  %a = ashr <2 x i64> %x, %sext
  %b = trunc <2 x i64> %a to <2 x i32>
  ret <2 x i32> %b
}

define <2 x i32> @vnsra_v2i64_v2i32_scalar_zext(<2 x i64> %x, i32 %y) {
; CHECK-LABEL: vnsra_v2i64_v2i32_scalar_zext:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 2, e32, mf2, ta, ma
; CHECK-NEXT:    vnsra.wx v8, v8, a0
; CHECK-NEXT:    ret
  %insert = insertelement <2 x i32> poison, i32 %y, i32 0
  %splat = shufflevector <2 x i32> %insert, <2 x i32> poison, <2 x i32> zeroinitializer
  %zext = zext <2 x i32> %splat to <2 x i64>
  %a = ashr <2 x i64> %x, %zext
  %b = trunc <2 x i64> %a to <2 x i32>
  ret <2 x i32> %b
}

define <8 x i8> @vnsra_v8i16_v8i8_imm(<8 x i16> %x) {
; CHECK-LABEL: vnsra_v8i16_v8i8_imm:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 8, e8, mf2, ta, ma
; CHECK-NEXT:    vnsrl.wi v8, v8, 8
; CHECK-NEXT:    ret
  %a = ashr <8 x i16> %x, <i16 8, i16 8, i16 8, i16 8,i16 8, i16 8, i16 8, i16 8>
  %b = trunc <8 x i16> %a to <8 x i8>
  ret <8 x i8> %b
}

define <4 x i16> @vnsra_v4i32_v4i16_imm(<4 x i32> %x) {
; CHECK-LABEL: vnsra_v4i32_v4i16_imm:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 4, e16, mf2, ta, ma
; CHECK-NEXT:    vnsrl.wi v8, v8, 16
; CHECK-NEXT:    ret
  %a = ashr <4 x i32> %x, <i32 16, i32 16, i32 16, i32 16>
  %b = trunc <4 x i32> %a to <4 x i16>
  ret <4 x i16> %b
}

define <2 x i32> @vnsra_v2i64_v2i32_imm(<2 x i64> %x) {
; CHECK-LABEL: vnsra_v2i64_v2i32_imm:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 2, e32, mf2, ta, ma
; CHECK-NEXT:    vnsrl.wi v8, v8, 31
; CHECK-NEXT:    ret
  %a = ashr <2 x i64> %x, <i64 31, i64 31>
  %b = trunc <2 x i64> %a to <2 x i32>
  ret <2 x i32> %b
}

define <8 x i8> @vnsrl_v8i16_v8i8_scalar(<8 x i16> %x, i16 %y) {
; CHECK-LABEL: vnsrl_v8i16_v8i8_scalar:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 8, e8, mf2, ta, ma
; CHECK-NEXT:    vnsrl.wx v8, v8, a0
; CHECK-NEXT:    ret
  %insert = insertelement <8 x i16> poison, i16 %y, i16 0
  %splat = shufflevector <8 x i16> %insert, <8 x i16> poison, <8 x i32> zeroinitializer
  %a = lshr <8 x i16> %x, %splat
  %b = trunc <8 x i16> %a to <8 x i8>
  ret <8 x i8> %b
}

define <8 x i8> @vnsrl_v8i16_v8i8_scalar_sext(<8 x i16> %x, i8 %y) {
; CHECK-LABEL: vnsrl_v8i16_v8i8_scalar_sext:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 8, e8, mf2, ta, ma
; CHECK-NEXT:    vnsrl.wx v8, v8, a0
; CHECK-NEXT:    ret
  %insert = insertelement <8 x i8> poison, i8 %y, i16 0
  %splat = shufflevector <8 x i8> %insert, <8 x i8> poison, <8 x i32> zeroinitializer
  %sext = sext <8 x i8> %splat to <8 x i16>
  %a = lshr <8 x i16> %x, %sext
  %b = trunc <8 x i16> %a to <8 x i8>
  ret <8 x i8> %b
}

define <8 x i8> @vnsrl_v8i16_v8i8_scalar_zext(<8 x i16> %x, i8 %y) {
; CHECK-LABEL: vnsrl_v8i16_v8i8_scalar_zext:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 8, e8, mf2, ta, ma
; CHECK-NEXT:    vnsrl.wx v8, v8, a0
; CHECK-NEXT:    ret
  %insert = insertelement <8 x i8> poison, i8 %y, i16 0
  %splat = shufflevector <8 x i8> %insert, <8 x i8> poison, <8 x i32> zeroinitializer
  %zext = zext <8 x i8> %splat to <8 x i16>
  %a = lshr <8 x i16> %x, %zext
  %b = trunc <8 x i16> %a to <8 x i8>
  ret <8 x i8> %b
}

define <4 x i16> @vnsrl_v4i32_v4i16_scalar(<4 x i32> %x, i32 %y) {
; CHECK-LABEL: vnsrl_v4i32_v4i16_scalar:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 4, e16, mf2, ta, ma
; CHECK-NEXT:    vnsrl.wx v8, v8, a0
; CHECK-NEXT:    ret
  %insert = insertelement <4 x i32> poison, i32 %y, i32 0
  %splat = shufflevector <4 x i32> %insert, <4 x i32> poison, <4 x i32> zeroinitializer
  %a = lshr <4 x i32> %x, %splat
  %b = trunc <4 x i32> %a to <4 x i16>
  ret <4 x i16> %b
}

define <4 x i16> @vnsrl_v4i32_v4i16_scalar_sext(<4 x i32> %x, i16 %y) {
; CHECK-LABEL: vnsrl_v4i32_v4i16_scalar_sext:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 4, e16, mf2, ta, ma
; CHECK-NEXT:    vnsrl.wx v8, v8, a0
; CHECK-NEXT:    ret
  %insert = insertelement <4 x i16> poison, i16 %y, i16 0
  %splat = shufflevector <4 x i16> %insert, <4 x i16> poison, <4 x i32> zeroinitializer
  %sext = sext <4 x i16> %splat to <4 x i32>
  %a = lshr <4 x i32> %x, %sext
  %b = trunc <4 x i32> %a to <4 x i16>
  ret <4 x i16> %b
}

define <4 x i16> @vnsrl_v4i32_v4i16_scalar_zext(<4 x i32> %x, i16 %y) {
; CHECK-LABEL: vnsrl_v4i32_v4i16_scalar_zext:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 4, e16, mf2, ta, ma
; CHECK-NEXT:    vnsrl.wx v8, v8, a0
; CHECK-NEXT:    ret
  %insert = insertelement <4 x i16> poison, i16 %y, i16 0
  %splat = shufflevector <4 x i16> %insert, <4 x i16> poison, <4 x i32> zeroinitializer
  %zext = zext <4 x i16> %splat to <4 x i32>
  %a = lshr <4 x i32> %x, %zext
  %b = trunc <4 x i32> %a to <4 x i16>
  ret <4 x i16> %b
}

define <2 x i32> @vnsrl_v2i64_v2i32_scalar(<2 x i64> %x, i64 %y) {
; CHECK-LABEL: vnsrl_v2i64_v2i32_scalar:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 2, e32, mf2, ta, ma
; CHECK-NEXT:    vnsrl.wx v8, v8, a0
; CHECK-NEXT:    ret
  %insert = insertelement <2 x i64> poison, i64 %y, i32 0
  %splat = shufflevector <2 x i64> %insert, <2 x i64> poison, <2 x i32> zeroinitializer
  %a = lshr <2 x i64> %x, %splat
  %b = trunc <2 x i64> %a to <2 x i32>
  ret <2 x i32> %b
}

define <2 x i32> @vnsrl_v2i64_v2i32_scalar_sext(<2 x i64> %x, i32 %y) {
; CHECK-LABEL: vnsrl_v2i64_v2i32_scalar_sext:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 2, e32, mf2, ta, ma
; CHECK-NEXT:    vnsrl.wx v8, v8, a0
; CHECK-NEXT:    ret
  %insert = insertelement <2 x i32> poison, i32 %y, i32 0
  %splat = shufflevector <2 x i32> %insert, <2 x i32> poison, <2 x i32> zeroinitializer
  %sext = sext <2 x i32> %splat to <2 x i64>
  %a = lshr <2 x i64> %x, %sext
  %b = trunc <2 x i64> %a to <2 x i32>
  ret <2 x i32> %b
}

define <2 x i32> @vnsrl_v2i64_v2i32_scalar_zext(<2 x i64> %x, i32 %y) {
; CHECK-LABEL: vnsrl_v2i64_v2i32_scalar_zext:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 2, e32, mf2, ta, ma
; CHECK-NEXT:    vnsrl.wx v8, v8, a0
; CHECK-NEXT:    ret
  %insert = insertelement <2 x i32> poison, i32 %y, i32 0
  %splat = shufflevector <2 x i32> %insert, <2 x i32> poison, <2 x i32> zeroinitializer
  %zext = zext <2 x i32> %splat to <2 x i64>
  %a = lshr <2 x i64> %x, %zext
  %b = trunc <2 x i64> %a to <2 x i32>
  ret <2 x i32> %b
}

define <8 x i8> @vnsrl_v8i16_v8i8_imm(<8 x i16> %x) {
; CHECK-LABEL: vnsrl_v8i16_v8i8_imm:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 8, e8, mf2, ta, ma
; CHECK-NEXT:    vnsrl.wi v8, v8, 8
; CHECK-NEXT:    ret
  %a = lshr <8 x i16> %x, <i16 8, i16 8, i16 8, i16 8,i16 8, i16 8, i16 8, i16 8>
  %b = trunc <8 x i16> %a to <8 x i8>
  ret <8 x i8> %b
}

define <4 x i16> @vnsrl_v4i32_v4i16_imm(<4 x i32> %x) {
; CHECK-LABEL: vnsrl_v4i32_v4i16_imm:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 4, e16, mf2, ta, ma
; CHECK-NEXT:    vnsrl.wi v8, v8, 16
; CHECK-NEXT:    ret
  %a = lshr <4 x i32> %x, <i32 16, i32 16, i32 16, i32 16>
  %b = trunc <4 x i32> %a to <4 x i16>
  ret <4 x i16> %b
}

define <2 x i32> @vnsrl_v2i64_v2i32_imm(<2 x i64> %x) {
; CHECK-LABEL: vnsrl_v2i64_v2i32_imm:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 2, e32, mf2, ta, ma
; CHECK-NEXT:    vnsrl.wi v8, v8, 31
; CHECK-NEXT:    ret
  %a = lshr <2 x i64> %x, <i64 31, i64 31>
  %b = trunc <2 x i64> %a to <2 x i32>
  ret <2 x i32> %b
}
