; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -verify-machineinstrs -ppc-asm-full-reg-names < %s \
; RUN:   -mtriple=powerpc64le-unknown-linux-gnu | FileCheck %s

@res = dso_local local_unnamed_addr global i32 0, align 4
@res2 = dso_local local_unnamed_addr global i32 0, align 4

define void @foo(i32 signext %var1) {
; CHECK-LABEL: foo:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    xori r3, r3, 1
; CHECK-NEXT:    addis r4, r2, res@toc@ha
; CHECK-NEXT:    cntlzw r3, r3
; CHECK-NEXT:    rlwinm r3, r3, 14, 0, 12
; CHECK-NEXT:    stw r3, res@toc@l(r4)
; CHECK-NEXT:    blr
entry:
  %cmp = icmp eq i32 %var1, 1
  %conv = zext i1 %cmp to i32
  %shl = shl nuw nsw i32 %conv, 19
  store i32 %shl, ptr @res, align 4
  ret void
}

define void @foo_multiple_use(i32 signext %var1) {
; CHECK-LABEL: foo_multiple_use:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    xori r3, r3, 1
; CHECK-NEXT:    addis r4, r2, res2@toc@ha
; CHECK-NEXT:    addis r6, r2, res@toc@ha
; CHECK-NEXT:    cntlzw r3, r3
; CHECK-NEXT:    srwi r5, r3, 5
; CHECK-NEXT:    rlwinm r3, r3, 14, 0, 12
; CHECK-NEXT:    stw r5, res2@toc@l(r4)
; CHECK-NEXT:    stw r3, res@toc@l(r6)
; CHECK-NEXT:    blr
entry:
  %cmp = icmp eq i32 %var1, 1
  %conv = zext i1 %cmp to i32
  store i32 %conv, ptr @res2, align 4
  %shl = shl nuw nsw i32 %conv, 19
  store i32 %shl, ptr @res, align 4
  ret void
}
