; NOTE: Assertions have been autogenerated by utils/update_mir_test_checks.py
; RUN: llc -opaque-pointers=0 -verify-machineinstrs -stop-before=ppc-vsx-copy -vec-extabi \
; RUN:     -mcpu=pwr7  -mtriple powerpc64-ibm-aix-xcoff < %s | \
; RUN: FileCheck %s

;; Fixed vector arguments to variadic functions are passed differently than
;; either arguments to non-variadic functions or arguments passed through
;; ellipses.
define double @callee(i32 signext %count, <4 x i32> %vsi, double %next, ...) {
  ; CHECK-LABEL: name: callee
  ; CHECK: bb.0.entry:
  ; CHECK:   liveins: $x8, $x9, $x10
  ; CHECK:   [[COPY:%[0-9]+]]:g8rc = COPY $x10
  ; CHECK:   [[COPY1:%[0-9]+]]:g8rc = COPY $x9
  ; CHECK:   [[COPY2:%[0-9]+]]:g8rc = COPY $x8
  ; CHECK:   STD [[COPY2]], 0, %fixed-stack.0 :: (store (s64) into %fixed-stack.0)
  ; CHECK:   STD [[COPY1]], 8, %fixed-stack.0 :: (store (s64) into %fixed-stack.0 + 8)
  ; CHECK:   STD [[COPY]], 16, %fixed-stack.0 :: (store (s64))
  ; CHECK:   LIFETIME_START %stack.0.arg_list
  ; CHECK:   [[ADDI8_:%[0-9]+]]:g8rc = ADDI8 %fixed-stack.0, 0
  ; CHECK:   STD killed [[ADDI8_]], 0, %stack.0.arg_list :: (store (s64) into %ir.0)
  ; CHECK:   [[ADDI8_1:%[0-9]+]]:g8rc = ADDI8 %fixed-stack.0, 15
  ; CHECK:   [[RLDICR:%[0-9]+]]:g8rc_and_g8rc_nox0 = RLDICR killed [[ADDI8_1]], 0, 59
  ; CHECK:   [[LFD:%[0-9]+]]:f8rc = LFD 16, killed [[RLDICR]] :: (load (s64) from %ir.4, align 16)
  ; CHECK:   LIFETIME_END %stack.0.arg_list
  ; CHECK:   $f1 = COPY [[LFD]]
  ; CHECK:   BLR8 implicit $lr8, implicit $rm, implicit $f1
entry:
  %arg_list = alloca i8*, align 8
  %0 = bitcast i8** %arg_list to i8*
  call void @llvm.lifetime.start.p0i8(i64 8, i8* nonnull %0)
  call void @llvm.va_start(i8* nonnull %0)
  %argp.cur = load i8*, i8** %arg_list, align 8
  %1 = ptrtoint i8* %argp.cur to i64
  %2 = add i64 %1, 15
  %3 = and i64 %2, -16
  %argp.cur.aligned = inttoptr i64 %3 to i8*
  %argp.next = getelementptr inbounds i8, i8* %argp.cur.aligned, i64 16
  %argp.next3 = getelementptr inbounds i8, i8* %argp.cur.aligned, i64 24
  store i8* %argp.next3, i8** %arg_list, align 8
  %4 = bitcast i8* %argp.next to double*
  %5 = load double, double* %4, align 16
  call void @llvm.va_end(i8* nonnull %0)
  call void @llvm.lifetime.end.p0i8(i64 8, i8* nonnull %0)
  ret double %5
}

declare void @llvm.lifetime.start.p0i8(i64 immarg, i8* nocapture)

declare void @llvm.va_start(i8*)

declare void @llvm.va_end(i8*)

declare void @llvm.lifetime.end.p0i8(i64 immarg, i8* nocapture)
