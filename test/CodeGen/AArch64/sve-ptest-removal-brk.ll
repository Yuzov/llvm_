; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=aarch64--linux-gnu -mattr=+sve %s -o - | FileCheck %s

; Test that redundant ptest instruction is removed when using a flag setting brk

define i32 @brkpa(<vscale x 16 x i1> %pg, <vscale x 16 x i1> %a, <vscale x 16 x i1> %b) {
; CHECK-LABEL: brkpa:
; CHECK:       // %bb.0:
; CHECK-NEXT:    brkpas p0.b, p0/z, p1.b, p2.b
; CHECK-NEXT:    cset w0, ne
; CHECK-NEXT:    ret
  %1 = tail call <vscale x 16 x i1> @llvm.aarch64.sve.brkpa.z.nxv16i1(<vscale x 16 x i1> %pg, <vscale x 16 x i1> %a, <vscale x 16 x i1> %b)
  %2 = tail call i1 @llvm.aarch64.sve.ptest.any.nxv16i1(<vscale x 16 x i1> %pg, <vscale x 16 x i1> %1)
  %conv = zext i1 %2 to i32
  ret i32 %conv
}

define i32 @brkpb(<vscale x 16 x i1> %pg, <vscale x 16 x i1> %a, <vscale x 16 x i1> %b) {
; CHECK-LABEL: brkpb:
; CHECK:       // %bb.0:
; CHECK-NEXT:    brkpbs p0.b, p0/z, p1.b, p2.b
; CHECK-NEXT:    cset w0, ne
; CHECK-NEXT:    ret
  %1 = tail call <vscale x 16 x i1> @llvm.aarch64.sve.brkpb.z.nxv16i1(<vscale x 16 x i1> %pg, <vscale x 16 x i1> %a, <vscale x 16 x i1> %b)
  %2 = tail call i1 @llvm.aarch64.sve.ptest.any.nxv16i1(<vscale x 16 x i1> %pg, <vscale x 16 x i1> %1)
  %conv = zext i1 %2 to i32
  ret i32 %conv
}

define i32 @brka(<vscale x 16 x i1> %pg, <vscale x 16 x i1> %a) {
; CHECK-LABEL: brka:
; CHECK:       // %bb.0:
; CHECK-NEXT:    brkas p0.b, p0/z, p1.b
; CHECK-NEXT:    cset w0, ne
; CHECK-NEXT:    ret
  %1 = tail call <vscale x 16 x i1> @llvm.aarch64.sve.brka.z.nxv16i1(<vscale x 16 x i1> %pg, <vscale x 16 x i1> %a)
  %2 = tail call i1 @llvm.aarch64.sve.ptest.any.nxv16i1(<vscale x 16 x i1> %pg, <vscale x 16 x i1> %1)
  %conv = zext i1 %2 to i32
  ret i32 %conv
}

define i32 @brkb(<vscale x 16 x i1> %pg, <vscale x 16 x i1> %a) {
; CHECK-LABEL: brkb:
; CHECK:       // %bb.0:
; CHECK-NEXT:    brkbs p0.b, p0/z, p1.b
; CHECK-NEXT:    cset w0, ne
; CHECK-NEXT:    ret
  %1 = tail call <vscale x 16 x i1> @llvm.aarch64.sve.brkb.z.nxv16i1(<vscale x 16 x i1> %pg, <vscale x 16 x i1> %a)
  %2 = tail call i1 @llvm.aarch64.sve.ptest.any.nxv16i1(<vscale x 16 x i1> %pg, <vscale x 16 x i1> %1)
  %conv = zext i1 %2 to i32
  ret i32 %conv
}

define i32 @brkn_all_active(<vscale x 16 x i1> %pg, <vscale x 16 x i1> %a, <vscale x 16 x i1> %b) {
; CHECK-LABEL: brkn_all_active:
; CHECK:       // %bb.0:
; CHECK-NEXT:    brkns p2.b, p0/z, p1.b, p2.b
; CHECK-NEXT:    cset w0, ne
; CHECK-NEXT:    ret
  %1 = tail call <vscale x 16 x i1> @llvm.aarch64.sve.brkn.z.nxv16i1(<vscale x 16 x i1> %pg, <vscale x 16 x i1> %a, <vscale x 16 x i1> %b)
  %2 = call <vscale x 16 x i1> @llvm.aarch64.sve.ptrue.nxv16i1(i32 31)
  %3 = tail call i1 @llvm.aarch64.sve.ptest.any.nxv16i1(<vscale x 16 x i1> %2, <vscale x 16 x i1> %1)
  %conv = zext i1 %3 to i32
  ret i32 %conv
}

; Test that ptest instruction is not removed when using a non-flag setting brk

define i32 @brkpa_neg(<vscale x 16 x i1> %pg, <vscale x 16 x i1> %a, <vscale x 16 x i1> %b) {
; CHECK-LABEL: brkpa_neg:
; CHECK:       // %bb.0:
; CHECK-NEXT:    brkpa p0.b, p0/z, p1.b, p2.b
; CHECK-NEXT:    ptest p1, p0.b
; CHECK-NEXT:    cset w0, ne
; CHECK-NEXT:    ret
  %1 = tail call <vscale x 16 x i1> @llvm.aarch64.sve.brkpa.z.nxv16i1(<vscale x 16 x i1> %pg, <vscale x 16 x i1> %a, <vscale x 16 x i1> %b)
  %2 = tail call i1 @llvm.aarch64.sve.ptest.any.nxv16i1(<vscale x 16 x i1> %a, <vscale x 16 x i1> %1)
  %conv = zext i1 %2 to i32
  ret i32 %conv
}

define i32 @brkpb_neg(<vscale x 16 x i1> %pg, <vscale x 16 x i1> %a, <vscale x 16 x i1> %b) {
; CHECK-LABEL: brkpb_neg:
; CHECK:       // %bb.0:
; CHECK-NEXT:    brkpb p0.b, p0/z, p1.b, p2.b
; CHECK-NEXT:    ptest p1, p0.b
; CHECK-NEXT:    cset w0, ne
; CHECK-NEXT:    ret
  %1 = tail call <vscale x 16 x i1> @llvm.aarch64.sve.brkpb.z.nxv16i1(<vscale x 16 x i1> %pg, <vscale x 16 x i1> %a, <vscale x 16 x i1> %b)
  %2 = tail call i1 @llvm.aarch64.sve.ptest.any.nxv16i1(<vscale x 16 x i1> %a, <vscale x 16 x i1> %1)
  %conv = zext i1 %2 to i32
  ret i32 %conv
}

define i32 @brka_neg(<vscale x 16 x i1> %pg, <vscale x 16 x i1> %a) {
; CHECK-LABEL: brka_neg:
; CHECK:       // %bb.0:
; CHECK-NEXT:    brka p0.b, p0/z, p1.b
; CHECK-NEXT:    ptest p1, p0.b
; CHECK-NEXT:    cset w0, ne
; CHECK-NEXT:    ret
  %1 = tail call <vscale x 16 x i1> @llvm.aarch64.sve.brka.z.nxv16i1(<vscale x 16 x i1> %pg, <vscale x 16 x i1> %a)
  %2 = tail call i1 @llvm.aarch64.sve.ptest.any.nxv16i1(<vscale x 16 x i1> %a, <vscale x 16 x i1> %1)
  %conv = zext i1 %2 to i32
  ret i32 %conv
}

define i32 @brkb_neg(<vscale x 16 x i1> %pg, <vscale x 16 x i1> %a) {
; CHECK-LABEL: brkb_neg:
; CHECK:       // %bb.0:
; CHECK-NEXT:    brkb p0.b, p0/z, p1.b
; CHECK-NEXT:    ptest p1, p0.b
; CHECK-NEXT:    cset w0, ne
; CHECK-NEXT:    ret
  %1 = tail call <vscale x 16 x i1> @llvm.aarch64.sve.brkb.z.nxv16i1(<vscale x 16 x i1> %pg, <vscale x 16 x i1> %a)
  %2 = tail call i1 @llvm.aarch64.sve.ptest.any.nxv16i1(<vscale x 16 x i1> %a, <vscale x 16 x i1> %1)
  %conv = zext i1 %2 to i32
  ret i32 %conv
}

define i32 @brkn_neg(<vscale x 16 x i1> %pg, <vscale x 16 x i1> %a, <vscale x 16 x i1> %b) {
; CHECK-LABEL: brkn_neg:
; CHECK:       // %bb.0:
; CHECK-NEXT:    brkn p2.b, p0/z, p1.b, p2.b
; CHECK-NEXT:    ptest p1, p2.b
; CHECK-NEXT:    cset w0, ne
; CHECK-NEXT:    ret
  %1 = tail call <vscale x 16 x i1> @llvm.aarch64.sve.brkn.z.nxv16i1(<vscale x 16 x i1> %pg, <vscale x 16 x i1> %a, <vscale x 16 x i1> %b)
  %2 = tail call i1 @llvm.aarch64.sve.ptest.any.nxv16i1(<vscale x 16 x i1> %a, <vscale x 16 x i1> %1)
  %conv = zext i1 %2 to i32
  ret i32 %conv
}

define i32 @brkn_neg2(<vscale x 16 x i1> %pg, <vscale x 16 x i1> %a, <vscale x 16 x i1> %b) {
; CHECK-LABEL: brkn_neg2:
; CHECK:       // %bb.0:
; CHECK-NEXT:    brkn p2.b, p0/z, p1.b, p2.b
; CHECK-NEXT:    ptest p0, p2.b
; CHECK-NEXT:    cset w0, ne
; CHECK-NEXT:    ret
  %1 = tail call <vscale x 16 x i1> @llvm.aarch64.sve.brkn.z.nxv16i1(<vscale x 16 x i1> %pg, <vscale x 16 x i1> %a, <vscale x 16 x i1> %b)
  %2 = tail call i1 @llvm.aarch64.sve.ptest.any.nxv16i1(<vscale x 16 x i1> %pg, <vscale x 16 x i1> %1)
  %conv = zext i1 %2 to i32
  ret i32 %conv
}

declare <vscale x 16 x i1> @llvm.aarch64.sve.brkpa.z.nxv16i1(<vscale x 16 x i1>, <vscale x 16 x i1>, <vscale x 16 x i1>)
declare <vscale x 16 x i1> @llvm.aarch64.sve.brkpb.z.nxv16i1(<vscale x 16 x i1>, <vscale x 16 x i1>, <vscale x 16 x i1>)
declare <vscale x 16 x i1> @llvm.aarch64.sve.brka.z.nxv16i1(<vscale x 16 x i1>, <vscale x 16 x i1>)
declare <vscale x 16 x i1> @llvm.aarch64.sve.brkb.z.nxv16i1(<vscale x 16 x i1>, <vscale x 16 x i1>)
declare <vscale x 16 x i1> @llvm.aarch64.sve.brkn.z.nxv16i1(<vscale x 16 x i1>, <vscale x 16 x i1>, <vscale x 16 x i1>)
declare i1 @llvm.aarch64.sve.ptest.any.nxv16i1(<vscale x 16 x i1>, <vscale x 16 x i1>)
declare <vscale x 16 x i1> @llvm.aarch64.sve.ptrue.nxv16i1(i32)
