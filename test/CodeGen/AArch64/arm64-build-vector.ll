; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=aarch64-eabi -aarch64-neon-syntax=apple | FileCheck %s

; Check that building a vector from floats doesn't insert an unnecessary
; copy for lane zero.
define <4 x float>  @foo(float %a, float %b, float %c, float %d) nounwind {
; CHECK-LABEL: foo:
; CHECK:       // %bb.0:
; CHECK-NEXT:    // kill: def $s0 killed $s0 def $q0
; CHECK-NEXT:    // kill: def $s1 killed $s1 def $q1
; CHECK-NEXT:    // kill: def $s2 killed $s2 def $q2
; CHECK-NEXT:    // kill: def $s3 killed $s3 def $q3
; CHECK-NEXT:    mov.s v0[1], v1[0]
; CHECK-NEXT:    mov.s v0[2], v2[0]
; CHECK-NEXT:    mov.s v0[3], v3[0]
; CHECK-NEXT:    ret
  %1 = insertelement <4 x float> undef, float %a, i32 0
  %2 = insertelement <4 x float> %1, float %b, i32 1
  %3 = insertelement <4 x float> %2, float %c, i32 2
  %4 = insertelement <4 x float> %3, float %d, i32 3
  ret <4 x float> %4
}

define <8 x i16> @build_all_zero(<8 x i16> %a) #1 {
; CHECK-LABEL: build_all_zero:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w8, #44672
; CHECK-NEXT:    fmov s1, w8
; CHECK-NEXT:    mul.8h v0, v0, v1
; CHECK-NEXT:    ret
  %b = add <8 x i16> %a, <i16 -32768, i16 undef, i16 undef, i16 undef, i16 undef, i16 undef, i16 undef, i16 undef>
  %c = mul <8 x i16> %b, <i16 -20864, i16 undef, i16 undef, i16 undef, i16 undef, i16 undef, i16 undef, i16 undef>
  ret <8 x i16> %c
}

; There is an optimization in DAG Combiner as following:
;   fold (concat_vectors (BUILD_VECTOR A, B, ...), (BUILD_VECTOR C, D, ...))
;        -> (BUILD_VECTOR A, B, ..., C, D, ...)
; This case checks when A,B and C,D are different types, there should be no
; assertion failure.
define <8 x i16> @concat_2_build_vector(<4 x i16> %in0) {
; CHECK-LABEL: concat_2_build_vector:
; CHECK:       // %bb.0:
; CHECK-NEXT:    movi.2d v0, #0000000000000000
; CHECK-NEXT:    ret
  %vshl_n = shl <4 x i16> %in0, <i16 8, i16 8, i16 8, i16 8>
  %vshl_n2 = shl <4 x i16> %vshl_n, <i16 9, i16 9, i16 9, i16 9>
  %shuffle.i = shufflevector <4 x i16> %vshl_n2, <4 x i16> zeroinitializer, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>
  ret <8 x i16> %shuffle.i
}

; The lowering of a widened f16 BUILD_VECTOR tries to optimize it by building
; an equivalent integer vector and BITCAST-ing that. This case checks that
; normalizing the vector generates a valid result. The choice of the
; constant prevents earlier passes from replacing the BUILD_VECTOR.
define void @widen_f16_build_vector(ptr %addr) {
; CHECK-LABEL: widen_f16_build_vector:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w8, #13294
; CHECK-NEXT:    movk w8, #13294, lsl #16
; CHECK-NEXT:    str w8, [x0]
; CHECK-NEXT:    ret
  store <2 x half> <half 0xH33EE, half 0xH33EE>, ptr %addr, align 2
  ret void
}

; Check that a single element vector is constructed with a mov
define <1 x i64> @single_element_vector_i64(<1 x i64> %arg) {
; CHECK-LABEL: single_element_vector_i64:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    mov w8, #1
; CHECK-NEXT:    fmov d1, x8
; CHECK-NEXT:    add d0, d0, d1
; CHECK-NEXT:    ret
entry:
  %add = add <1 x i64> %arg, <i64 1>
  ret <1 x i64> %add
}

define <1 x double> @single_element_vector_double(<1 x double> %arg) {
; CHECK-LABEL: single_element_vector_double:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    fmov d1, #1.00000000
; CHECK-NEXT:    fadd d0, d0, d1
; CHECK-NEXT:    ret
entry:
  %add = fadd <1 x double> %arg, <double 1.0>
  ret <1 x double> %add
}

; Make sure BUILD_VECTOR does not get stuck in a loop trying to convert a
; single element FP vector constant from a scalar to vector.
define <1 x double> @convert_single_fp_vector_constant(i1 %cmp) {
; CHECK-LABEL: convert_single_fp_vector_constant:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    tst w0, #0x1
; CHECK-NEXT:    mov x8, #4607182418800017408
; CHECK-NEXT:    csetm x9, ne
; CHECK-NEXT:    fmov d0, x8
; CHECK-NEXT:    fmov d1, x9
; CHECK-NEXT:    and.8b v0, v0, v1
; CHECK-NEXT:    ret
entry:
  %sel = select i1 %cmp, <1 x double> <double 1.000000e+00>, <1 x double> zeroinitializer
  ret <1 x double> %sel
}
