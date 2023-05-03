; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -o - %s -mtriple=x86_64-- | FileCheck %s
; Example of a decref operation with "immortal" objects.
; void decref(long* refcount) {
;  long count = *refcount;
;  if (count == 1) { free_object() }
;  else if (count > 1) { *refcount = count - 1; }
;  else { /* immortal */ }
; }
; Resulting assembly should share flags from single CMP instruction for both
; conditions!
define void @decref(ptr %p) {
; CHECK-LABEL: decref:
; CHECK:       # %bb.0:
; CHECK-NEXT:    pushq %rax
; CHECK-NEXT:    .cfi_def_cfa_offset 16
; CHECK-NEXT:    movl (%rdi), %eax
; CHECK-NEXT:    cmpl $1, %eax
; CHECK-NEXT:    jne .LBB0_2
; CHECK-NEXT:  # %bb.1: # %bb_free
; CHECK-NEXT:    callq free_object@PLT
; CHECK-NEXT:  .LBB0_4: # %end
; CHECK-NEXT:    popq %rax
; CHECK-NEXT:    .cfi_def_cfa_offset 8
; CHECK-NEXT:    retq
; CHECK-NEXT:  .LBB0_2: # %bb2
; CHECK-NEXT:    .cfi_def_cfa_offset 16
; CHECK-NEXT:    jle .LBB0_4
; CHECK-NEXT:  # %bb.3: # %bb_dec
; CHECK-NEXT:    decl %eax
; CHECK-NEXT:    movl %eax, (%rdi)
; CHECK-NEXT:    popq %rax
; CHECK-NEXT:    .cfi_def_cfa_offset 8
; CHECK-NEXT:    retq
  %count = load i32, ptr %p, align 4
  %cmp0 = icmp eq i32 %count, 1
  br i1 %cmp0, label %bb_free, label %bb2

bb2:
  %cmp1 = icmp sgt i32 %count, 1
  br i1 %cmp1, label %bb_dec, label %end

bb_dec:
  %dec = add nsw i32 %count, -1
  store i32 %dec, ptr %p, align 4
  br label %end

bb_free:
  call void @free_object()
  br label %end

end:
  ret void
}

declare void @free_object()
