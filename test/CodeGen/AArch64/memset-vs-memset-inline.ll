; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=aarch64-unknown-linux-gnu | FileCheck %s

declare void @llvm.memset.p0.i64(ptr nocapture, i8, i64, i1) nounwind
declare void @llvm.memset.inline.p0.i64(ptr nocapture, i8, i64, i1) nounwind

define void @test1(ptr %a, i8 %value) nounwind {
; CHECK-LABEL: test1:
; CHECK:       // %bb.0:
; CHECK-NEXT:    // kill: def $w1 killed $w1 def $x1
; CHECK-NEXT:    mov x8, #72340172838076673
; CHECK-NEXT:    and x9, x1, #0xff
; CHECK-NEXT:    mul x8, x9, x8
; CHECK-NEXT:    str x8, [x0]
; CHECK-NEXT:    ret
  tail call void @llvm.memset.inline.p0.i64(ptr %a, i8 %value, i64 8, i1 0)
  ret void
}

define void @regular_memset_calls_external_function(ptr %a, i8 %value) nounwind {
; CHECK-LABEL: regular_memset_calls_external_function:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w2, #1024
; CHECK-NEXT:    b memset
  tail call void @llvm.memset.p0.i64(ptr %a, i8 %value, i64 1024, i1 0)
  ret void
}

define void @inlined_set_doesnt_call_external_function(ptr %a, i8 %value) nounwind {
; CHECK-LABEL: inlined_set_doesnt_call_external_function:
; CHECK:       // %bb.0:
; CHECK-NEXT:    dup v0.16b, w1
; CHECK-NEXT:    stp q0, q0, [x0]
; CHECK-NEXT:    stp q0, q0, [x0, #32]
  tail call void @llvm.memset.inline.p0.i64(ptr %a, i8 %value, i64 1024, i1 0)
  ret void
}
