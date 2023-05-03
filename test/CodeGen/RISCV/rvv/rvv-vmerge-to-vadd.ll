; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=riscv64 -mattr=+v -verify-machineinstrs | FileCheck %s
define <vscale x 1 x i8> @vpmerge_mf8(<vscale x 1 x i8> %x, <vscale x 1 x i8> %y, i32 zeroext %vl) {
; CHECK-LABEL: vpmerge_mf8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e8, mf8, tu, ma
; CHECK-NEXT:    vadd.vi v8, v9, 0
; CHECK-NEXT:    ret
  %splat = insertelement <vscale x 1 x i1> poison, i1 -1, i8 0
  %allones = shufflevector <vscale x 1 x i1> %splat, <vscale x 1 x i1> poison, <vscale x 1 x i32> zeroinitializer
  %1 = call <vscale x 1 x i8> @llvm.vp.merge.nxv1i8(<vscale x 1 x i1> %allones, <vscale x 1 x i8> %y, <vscale x 1 x i8> %x, i32 %vl)
  ret <vscale x 1 x i8> %1
}

define <vscale x 2 x i8> @vpmerge_mf4(<vscale x 2 x i8> %x, <vscale x 2 x i8> %y, i32 zeroext %vl) {
; CHECK-LABEL: vpmerge_mf4:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e8, mf4, tu, ma
; CHECK-NEXT:    vadd.vi v8, v9, 0
; CHECK-NEXT:    ret
  %splat = insertelement <vscale x 2 x i1> poison, i1 -1, i8 0
  %allones = shufflevector <vscale x 2 x i1> %splat, <vscale x 2 x i1> poison, <vscale x 2 x i32> zeroinitializer
  %1 = call <vscale x 2 x i8> @llvm.vp.merge.nxv2i8(<vscale x 2 x i1> %allones, <vscale x 2 x i8> %y, <vscale x 2 x i8> %x, i32 %vl)
  ret <vscale x 2 x i8> %1
}

define <vscale x 4 x i8> @vpmerge_mf2(<vscale x 4 x i8> %x, <vscale x 4 x i8> %y, i32 zeroext %vl) {
; CHECK-LABEL: vpmerge_mf2:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e8, mf2, tu, ma
; CHECK-NEXT:    vadd.vi v8, v9, 0
; CHECK-NEXT:    ret
  %splat = insertelement <vscale x 4 x i1> poison, i1 -1, i8 0
  %allones = shufflevector <vscale x 4 x i1> %splat, <vscale x 4 x i1> poison, <vscale x 4 x i32> zeroinitializer
  %1 = call <vscale x 4 x i8> @llvm.vp.merge.nxv4i8(<vscale x 4 x i1> %allones, <vscale x 4 x i8> %y, <vscale x 4 x i8> %x, i32 %vl)
  ret <vscale x 4 x i8> %1
}

define <vscale x 8 x i8> @vpmerge_m1(<vscale x 8 x i8> %x, <vscale x 8 x i8> %y, i32 zeroext %vl) {
; CHECK-LABEL: vpmerge_m1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e8, m1, tu, ma
; CHECK-NEXT:    vadd.vi v8, v9, 0
; CHECK-NEXT:    ret
  %splat = insertelement <vscale x 8 x i1> poison, i1 -1, i8 0
  %allones = shufflevector <vscale x 8 x i1> %splat, <vscale x 8 x i1> poison, <vscale x 8 x i32> zeroinitializer
  %1 = call <vscale x 8 x i8> @llvm.vp.merge.nxv8i8(<vscale x 8 x i1> %allones, <vscale x 8 x i8> %y, <vscale x 8 x i8> %x, i32 %vl)
  ret <vscale x 8 x i8> %1
}

define <vscale x 8 x i16> @vpmerge_m2(<vscale x 8 x i16> %x, <vscale x 8 x i16> %y, i32 zeroext %vl) {
; CHECK-LABEL: vpmerge_m2:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e16, m2, tu, ma
; CHECK-NEXT:    vadd.vi v8, v10, 0
; CHECK-NEXT:    ret
  %splat = insertelement <vscale x 8 x i1> poison, i1 -1, i16 0
  %allones = shufflevector <vscale x 8 x i1> %splat, <vscale x 8 x i1> poison, <vscale x 8 x i32> zeroinitializer
  %1 = call <vscale x 8 x i16> @llvm.vp.merge.nxv8i16(<vscale x 8 x i1> %allones, <vscale x 8 x i16> %y, <vscale x 8 x i16> %x, i32 %vl)
  ret <vscale x 8 x i16> %1
}

define <vscale x 8 x i32> @vpmerge_m4(<vscale x 8 x i32> %x, <vscale x 8 x i32> %y, i32 zeroext %vl) {
; CHECK-LABEL: vpmerge_m4:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e32, m4, tu, ma
; CHECK-NEXT:    vadd.vi v8, v12, 0
; CHECK-NEXT:    ret
  %splat = insertelement <vscale x 8 x i1> poison, i1 -1, i32 0
  %allones = shufflevector <vscale x 8 x i1> %splat, <vscale x 8 x i1> poison, <vscale x 8 x i32> zeroinitializer
  %1 = call <vscale x 8 x i32> @llvm.vp.merge.nxv8i32(<vscale x 8 x i1> %allones, <vscale x 8 x i32> %y, <vscale x 8 x i32> %x, i32 %vl)
  ret <vscale x 8 x i32> %1
}

define <vscale x 8 x i64> @vpmerge_m8(<vscale x 8 x i64> %x, <vscale x 8 x i64> %y, i32 zeroext %vl) {
; CHECK-LABEL: vpmerge_m8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e64, m8, tu, ma
; CHECK-NEXT:    vadd.vi v8, v16, 0
; CHECK-NEXT:    ret
  %splat = insertelement <vscale x 8 x i1> poison, i1 -1, i64 0
  %allones = shufflevector <vscale x 8 x i1> %splat, <vscale x 8 x i1> poison, <vscale x 8 x i32> zeroinitializer
  %1 = call <vscale x 8 x i64> @llvm.vp.merge.nxv8i64(<vscale x 8 x i1> %allones, <vscale x 8 x i64> %y, <vscale x 8 x i64> %x, i32 %vl)
  ret <vscale x 8 x i64> %1
}

declare <vscale x 1 x i8> @llvm.vp.merge.nxv1i8(<vscale x 1 x i1>, <vscale x 1 x i8>, <vscale x 1 x i8>, i32)
declare <vscale x 2 x i8> @llvm.vp.merge.nxv2i8(<vscale x 2 x i1>, <vscale x 2 x i8>, <vscale x 2 x i8>, i32)
declare <vscale x 4 x i8> @llvm.vp.merge.nxv4i8(<vscale x 4 x i1>, <vscale x 4 x i8>, <vscale x 4 x i8>, i32)
declare <vscale x 8 x i8> @llvm.vp.merge.nxv8i8(<vscale x 8 x i1>, <vscale x 8 x i8>, <vscale x 8 x i8>, i32)
declare <vscale x 8 x i16> @llvm.vp.merge.nxv8i16(<vscale x 8 x i1>, <vscale x 8 x i16>, <vscale x 8 x i16>, i32)
declare <vscale x 8 x i32> @llvm.vp.merge.nxv8i32(<vscale x 8 x i1>, <vscale x 8 x i32>, <vscale x 8 x i32>, i32)
declare <vscale x 8 x i64> @llvm.vp.merge.nxv8i64(<vscale x 8 x i1>, <vscale x 8 x i64>, <vscale x 8 x i64>, i32)
