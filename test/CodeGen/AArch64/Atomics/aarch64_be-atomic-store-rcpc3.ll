; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --filter-out "\b(sp)\b" --filter "^\s*(ld[^r]|st|swp|cas|bl|add|and|eor|orn|orr|sub|mvn|sxt|cmp|ccmp|csel|dmb)"
; The base test file was generated by ./llvm/test/CodeGen/AArch64/Atomics/generate-tests.py
; RUN: llc %s -o - -verify-machineinstrs -mtriple=aarch64_be -mattr=+rcpc3 -O0 | FileCheck %s --check-prefixes=CHECK,-O0
; RUN: llc %s -o - -verify-machineinstrs -mtriple=aarch64_be -mattr=+rcpc3 -O1 | FileCheck %s --check-prefixes=CHECK,-O1

define dso_local void @store_atomic_i8_aligned_unordered(i8 %value, ptr %ptr) {
; CHECK-LABEL: store_atomic_i8_aligned_unordered:
; CHECK:    strb w0, [x1]
    store atomic i8 %value, ptr %ptr unordered, align 1
    ret void
}

define dso_local void @store_atomic_i8_aligned_monotonic(i8 %value, ptr %ptr) {
; CHECK-LABEL: store_atomic_i8_aligned_monotonic:
; CHECK:    strb w0, [x1]
    store atomic i8 %value, ptr %ptr monotonic, align 1
    ret void
}

define dso_local void @store_atomic_i8_aligned_release(i8 %value, ptr %ptr) {
; CHECK-LABEL: store_atomic_i8_aligned_release:
; CHECK:    stlrb w0, [x1]
    store atomic i8 %value, ptr %ptr release, align 1
    ret void
}

define dso_local void @store_atomic_i8_aligned_seq_cst(i8 %value, ptr %ptr) {
; CHECK-LABEL: store_atomic_i8_aligned_seq_cst:
; CHECK:    stlrb w0, [x1]
    store atomic i8 %value, ptr %ptr seq_cst, align 1
    ret void
}

define dso_local void @store_atomic_i16_aligned_unordered(i16 %value, ptr %ptr) {
; CHECK-LABEL: store_atomic_i16_aligned_unordered:
; CHECK:    strh w0, [x1]
    store atomic i16 %value, ptr %ptr unordered, align 2
    ret void
}

define dso_local void @store_atomic_i16_aligned_monotonic(i16 %value, ptr %ptr) {
; CHECK-LABEL: store_atomic_i16_aligned_monotonic:
; CHECK:    strh w0, [x1]
    store atomic i16 %value, ptr %ptr monotonic, align 2
    ret void
}

define dso_local void @store_atomic_i16_aligned_release(i16 %value, ptr %ptr) {
; CHECK-LABEL: store_atomic_i16_aligned_release:
; CHECK:    stlrh w0, [x1]
    store atomic i16 %value, ptr %ptr release, align 2
    ret void
}

define dso_local void @store_atomic_i16_aligned_seq_cst(i16 %value, ptr %ptr) {
; CHECK-LABEL: store_atomic_i16_aligned_seq_cst:
; CHECK:    stlrh w0, [x1]
    store atomic i16 %value, ptr %ptr seq_cst, align 2
    ret void
}

define dso_local void @store_atomic_i32_aligned_unordered(i32 %value, ptr %ptr) {
; CHECK-LABEL: store_atomic_i32_aligned_unordered:
; CHECK:    str w0, [x1]
    store atomic i32 %value, ptr %ptr unordered, align 4
    ret void
}

define dso_local void @store_atomic_i32_aligned_monotonic(i32 %value, ptr %ptr) {
; CHECK-LABEL: store_atomic_i32_aligned_monotonic:
; CHECK:    str w0, [x1]
    store atomic i32 %value, ptr %ptr monotonic, align 4
    ret void
}

define dso_local void @store_atomic_i32_aligned_release(i32 %value, ptr %ptr) {
; CHECK-LABEL: store_atomic_i32_aligned_release:
; CHECK:    stlr w0, [x1]
    store atomic i32 %value, ptr %ptr release, align 4
    ret void
}

define dso_local void @store_atomic_i32_aligned_seq_cst(i32 %value, ptr %ptr) {
; CHECK-LABEL: store_atomic_i32_aligned_seq_cst:
; CHECK:    stlr w0, [x1]
    store atomic i32 %value, ptr %ptr seq_cst, align 4
    ret void
}

define dso_local void @store_atomic_i64_aligned_unordered(i64 %value, ptr %ptr) {
; CHECK-LABEL: store_atomic_i64_aligned_unordered:
; CHECK:    str x0, [x1]
    store atomic i64 %value, ptr %ptr unordered, align 8
    ret void
}

define dso_local void @store_atomic_i64_aligned_monotonic(i64 %value, ptr %ptr) {
; CHECK-LABEL: store_atomic_i64_aligned_monotonic:
; CHECK:    str x0, [x1]
    store atomic i64 %value, ptr %ptr monotonic, align 8
    ret void
}

define dso_local void @store_atomic_i64_aligned_release(i64 %value, ptr %ptr) {
; CHECK-LABEL: store_atomic_i64_aligned_release:
; CHECK:    stlr x0, [x1]
    store atomic i64 %value, ptr %ptr release, align 8
    ret void
}

define dso_local void @store_atomic_i64_aligned_seq_cst(i64 %value, ptr %ptr) {
; CHECK-LABEL: store_atomic_i64_aligned_seq_cst:
; CHECK:    stlr x0, [x1]
    store atomic i64 %value, ptr %ptr seq_cst, align 8
    ret void
}

define dso_local void @store_atomic_i128_aligned_unordered(i128 %value, ptr %ptr) {
; -O0-LABEL: store_atomic_i128_aligned_unordered:
; -O0:    ldxp x10, x12, [x9]
; -O0:    cmp x10, x11
; -O0:    cmp x12, x13
; -O0:    stxp w8, x14, x15, [x9]
; -O0:    stxp w8, x10, x12, [x9]
; -O0:    subs x12, x12, x13
; -O0:    ccmp x10, x11, #0, eq
;
; -O1-LABEL: store_atomic_i128_aligned_unordered:
; -O1:    ldxp xzr, x8, [x2]
; -O1:    stxp w8, x1, x0, [x2]
    store atomic i128 %value, ptr %ptr unordered, align 16
    ret void
}

define dso_local void @store_atomic_i128_aligned_monotonic(i128 %value, ptr %ptr) {
; -O0-LABEL: store_atomic_i128_aligned_monotonic:
; -O0:    ldxp x10, x12, [x9]
; -O0:    cmp x10, x11
; -O0:    cmp x12, x13
; -O0:    stxp w8, x14, x15, [x9]
; -O0:    stxp w8, x10, x12, [x9]
; -O0:    subs x12, x12, x13
; -O0:    ccmp x10, x11, #0, eq
;
; -O1-LABEL: store_atomic_i128_aligned_monotonic:
; -O1:    ldxp xzr, x8, [x2]
; -O1:    stxp w8, x1, x0, [x2]
    store atomic i128 %value, ptr %ptr monotonic, align 16
    ret void
}

define dso_local void @store_atomic_i128_aligned_release(i128 %value, ptr %ptr) {
; -O0-LABEL: store_atomic_i128_aligned_release:
; -O0:    ldxp x10, x12, [x9]
; -O0:    cmp x10, x11
; -O0:    cmp x12, x13
; -O0:    stlxp w8, x14, x15, [x9]
; -O0:    stlxp w8, x10, x12, [x9]
; -O0:    subs x12, x12, x13
; -O0:    ccmp x10, x11, #0, eq
;
; -O1-LABEL: store_atomic_i128_aligned_release:
; -O1:    ldxp xzr, x8, [x2]
; -O1:    stlxp w8, x1, x0, [x2]
    store atomic i128 %value, ptr %ptr release, align 16
    ret void
}

define dso_local void @store_atomic_i128_aligned_seq_cst(i128 %value, ptr %ptr) {
; -O0-LABEL: store_atomic_i128_aligned_seq_cst:
; -O0:    ldaxp x10, x12, [x9]
; -O0:    cmp x10, x11
; -O0:    cmp x12, x13
; -O0:    stlxp w8, x14, x15, [x9]
; -O0:    stlxp w8, x10, x12, [x9]
; -O0:    subs x12, x12, x13
; -O0:    ccmp x10, x11, #0, eq
;
; -O1-LABEL: store_atomic_i128_aligned_seq_cst:
; -O1:    ldaxp xzr, x8, [x2]
; -O1:    stlxp w8, x1, x0, [x2]
    store atomic i128 %value, ptr %ptr seq_cst, align 16
    ret void
}

define dso_local void @store_atomic_i8_unaligned_unordered(i8 %value, ptr %ptr) {
; CHECK-LABEL: store_atomic_i8_unaligned_unordered:
; CHECK:    strb w0, [x1]
    store atomic i8 %value, ptr %ptr unordered, align 1
    ret void
}

define dso_local void @store_atomic_i8_unaligned_monotonic(i8 %value, ptr %ptr) {
; CHECK-LABEL: store_atomic_i8_unaligned_monotonic:
; CHECK:    strb w0, [x1]
    store atomic i8 %value, ptr %ptr monotonic, align 1
    ret void
}

define dso_local void @store_atomic_i8_unaligned_release(i8 %value, ptr %ptr) {
; CHECK-LABEL: store_atomic_i8_unaligned_release:
; CHECK:    stlrb w0, [x1]
    store atomic i8 %value, ptr %ptr release, align 1
    ret void
}

define dso_local void @store_atomic_i8_unaligned_seq_cst(i8 %value, ptr %ptr) {
; CHECK-LABEL: store_atomic_i8_unaligned_seq_cst:
; CHECK:    stlrb w0, [x1]
    store atomic i8 %value, ptr %ptr seq_cst, align 1
    ret void
}

define dso_local void @store_atomic_i16_unaligned_unordered(i16 %value, ptr %ptr) {
; CHECK-LABEL: store_atomic_i16_unaligned_unordered:
; CHECK:    bl __atomic_store
    store atomic i16 %value, ptr %ptr unordered, align 1
    ret void
}

define dso_local void @store_atomic_i16_unaligned_monotonic(i16 %value, ptr %ptr) {
; CHECK-LABEL: store_atomic_i16_unaligned_monotonic:
; CHECK:    bl __atomic_store
    store atomic i16 %value, ptr %ptr monotonic, align 1
    ret void
}

define dso_local void @store_atomic_i16_unaligned_release(i16 %value, ptr %ptr) {
; CHECK-LABEL: store_atomic_i16_unaligned_release:
; CHECK:    bl __atomic_store
    store atomic i16 %value, ptr %ptr release, align 1
    ret void
}

define dso_local void @store_atomic_i16_unaligned_seq_cst(i16 %value, ptr %ptr) {
; CHECK-LABEL: store_atomic_i16_unaligned_seq_cst:
; CHECK:    bl __atomic_store
    store atomic i16 %value, ptr %ptr seq_cst, align 1
    ret void
}

define dso_local void @store_atomic_i32_unaligned_unordered(i32 %value, ptr %ptr) {
; CHECK-LABEL: store_atomic_i32_unaligned_unordered:
; CHECK:    bl __atomic_store
    store atomic i32 %value, ptr %ptr unordered, align 1
    ret void
}

define dso_local void @store_atomic_i32_unaligned_monotonic(i32 %value, ptr %ptr) {
; CHECK-LABEL: store_atomic_i32_unaligned_monotonic:
; CHECK:    bl __atomic_store
    store atomic i32 %value, ptr %ptr monotonic, align 1
    ret void
}

define dso_local void @store_atomic_i32_unaligned_release(i32 %value, ptr %ptr) {
; CHECK-LABEL: store_atomic_i32_unaligned_release:
; CHECK:    bl __atomic_store
    store atomic i32 %value, ptr %ptr release, align 1
    ret void
}

define dso_local void @store_atomic_i32_unaligned_seq_cst(i32 %value, ptr %ptr) {
; CHECK-LABEL: store_atomic_i32_unaligned_seq_cst:
; CHECK:    bl __atomic_store
    store atomic i32 %value, ptr %ptr seq_cst, align 1
    ret void
}

define dso_local void @store_atomic_i64_unaligned_unordered(i64 %value, ptr %ptr) {
; CHECK-LABEL: store_atomic_i64_unaligned_unordered:
; CHECK:    bl __atomic_store
    store atomic i64 %value, ptr %ptr unordered, align 1
    ret void
}

define dso_local void @store_atomic_i64_unaligned_monotonic(i64 %value, ptr %ptr) {
; CHECK-LABEL: store_atomic_i64_unaligned_monotonic:
; CHECK:    bl __atomic_store
    store atomic i64 %value, ptr %ptr monotonic, align 1
    ret void
}

define dso_local void @store_atomic_i64_unaligned_release(i64 %value, ptr %ptr) {
; CHECK-LABEL: store_atomic_i64_unaligned_release:
; CHECK:    bl __atomic_store
    store atomic i64 %value, ptr %ptr release, align 1
    ret void
}

define dso_local void @store_atomic_i64_unaligned_seq_cst(i64 %value, ptr %ptr) {
; CHECK-LABEL: store_atomic_i64_unaligned_seq_cst:
; CHECK:    bl __atomic_store
    store atomic i64 %value, ptr %ptr seq_cst, align 1
    ret void
}

define dso_local void @store_atomic_i128_unaligned_unordered(i128 %value, ptr %ptr) {
; CHECK-LABEL: store_atomic_i128_unaligned_unordered:
; CHECK:    bl __atomic_store
    store atomic i128 %value, ptr %ptr unordered, align 1
    ret void
}

define dso_local void @store_atomic_i128_unaligned_monotonic(i128 %value, ptr %ptr) {
; CHECK-LABEL: store_atomic_i128_unaligned_monotonic:
; CHECK:    bl __atomic_store
    store atomic i128 %value, ptr %ptr monotonic, align 1
    ret void
}

define dso_local void @store_atomic_i128_unaligned_release(i128 %value, ptr %ptr) {
; CHECK-LABEL: store_atomic_i128_unaligned_release:
; CHECK:    bl __atomic_store
    store atomic i128 %value, ptr %ptr release, align 1
    ret void
}

define dso_local void @store_atomic_i128_unaligned_seq_cst(i128 %value, ptr %ptr) {
; CHECK-LABEL: store_atomic_i128_unaligned_seq_cst:
; CHECK:    bl __atomic_store
    store atomic i128 %value, ptr %ptr seq_cst, align 1
    ret void
}
