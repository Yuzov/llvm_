; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s --mattr=+mve.fp,+fp64 -o - | FileCheck %s

target triple = "thumbv8.1m.main-none-none-eabi"

; Expected to transform
define arm_aapcs_vfpcc <4 x float> @mul_mul(<4 x float> %a, <4 x float> %b, <4 x float> %c) {
; CHECK-LABEL: mul_mul:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vcmul.f32 q3, q0, q1, #0
; CHECK-NEXT:    vcmla.f32 q3, q0, q1, #90
; CHECK-NEXT:    vcmul.f32 q0, q3, q2, #0
; CHECK-NEXT:    vcmla.f32 q0, q3, q2, #90
; CHECK-NEXT:    bx lr
entry:
  %strided.vec = shufflevector <4 x float> %a, <4 x float> poison, <2 x i32> <i32 0, i32 2>
  %strided.vec151 = shufflevector <4 x float> %a, <4 x float> poison, <2 x i32> <i32 1, i32 3>
  %strided.vec153 = shufflevector <4 x float> %b, <4 x float> poison, <2 x i32> <i32 0, i32 2>
  %strided.vec154 = shufflevector <4 x float> %b, <4 x float> poison, <2 x i32> <i32 1, i32 3>
  %0 = fmul fast <2 x float> %strided.vec154, %strided.vec151
  %1 = fmul fast <2 x float> %strided.vec153, %strided.vec
  %2 = fmul fast <2 x float> %strided.vec154, %strided.vec
  %3 = fmul fast <2 x float> %strided.vec153, %strided.vec151
  %4 = fadd fast <2 x float> %3, %2
  %5 = fsub fast <2 x float> %1, %0
  %strided.vec156 = shufflevector <4 x float> %c, <4 x float> poison, <2 x i32> <i32 0, i32 2>
  %strided.vec157 = shufflevector <4 x float> %c, <4 x float> poison, <2 x i32> <i32 1, i32 3>
  %6 = fmul fast <2 x float> %4, %strided.vec156
  %7 = fmul fast <2 x float> %5, %strided.vec157
  %8 = fadd fast <2 x float> %6, %7
  %9 = fmul fast <2 x float> %strided.vec156, %5
  %10 = fmul fast <2 x float> %4, %strided.vec157
  %11 = fsub fast <2 x float> %9, %10
  %interleaved.vec = shufflevector <2 x float> %11, <2 x float> %8, <4 x i32> <i32 0, i32 2, i32 1, i32 3>
  ret <4 x float> %interleaved.vec
}

; Expected to not transform
define arm_aapcs_vfpcc <4 x float> @add_mul(<4 x float> %a, <4 x float> %b, <4 x float> %c) {
; CHECK-LABEL: add_mul:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    .vsave {d8, d9}
; CHECK-NEXT:    vpush {d8, d9}
; CHECK-NEXT:    vsub.f32 q3, q1, q2
; CHECK-NEXT:    vsub.f32 q0, q1, q0
; CHECK-NEXT:    vmov.f32 s16, s9
; CHECK-NEXT:    vmov.f32 s13, s14
; CHECK-NEXT:    vmov.f32 s17, s11
; CHECK-NEXT:    vmov.f32 s0, s1
; CHECK-NEXT:    vmul.f32 q1, q3, q4
; CHECK-NEXT:    vmov.f32 s1, s3
; CHECK-NEXT:    vmov.f32 s9, s10
; CHECK-NEXT:    vfma.f32 q1, q2, q0
; CHECK-NEXT:    vmul.f32 q0, q4, q0
; CHECK-NEXT:    vneg.f32 q4, q0
; CHECK-NEXT:    vmov.f32 s1, s4
; CHECK-NEXT:    vfma.f32 q4, q2, q3
; CHECK-NEXT:    vmov.f32 s3, s5
; CHECK-NEXT:    vmov.f32 s0, s16
; CHECK-NEXT:    vmov.f32 s2, s17
; CHECK-NEXT:    vpop {d8, d9}
; CHECK-NEXT:    bx lr
entry:
  %0 = fsub fast <4 x float> %b, %c
  %1 = shufflevector <4 x float> %0, <4 x float> poison, <2 x i32> <i32 0, i32 2>
  %strided.vec58 = shufflevector <4 x float> %c, <4 x float> poison, <2 x i32> <i32 0, i32 2>
  %strided.vec59 = shufflevector <4 x float> %c, <4 x float> poison, <2 x i32> <i32 1, i32 3>
  %2 = fmul fast <2 x float> %1, %strided.vec59
  %3 = fsub fast <4 x float> %b, %a
  %4 = shufflevector <4 x float> %3, <4 x float> poison, <2 x i32> <i32 1, i32 3>
  %5 = fmul fast <2 x float> %strided.vec58, %4
  %6 = fadd fast <2 x float> %5, %2
  %7 = fmul fast <2 x float> %strided.vec58, %1
  %8 = fmul fast <2 x float> %strided.vec59, %4
  %9 = fsub fast <2 x float> %7, %8
  %interleaved.vec = shufflevector <2 x float> %9, <2 x float> %6, <4 x i32> <i32 0, i32 2, i32 1, i32 3>
  ret <4 x float> %interleaved.vec
}

; Expected to not transform
define arm_aapcs_vfpcc <4 x float> @mul_mul270_mul(<4 x float> %a, <4 x float> %b, <4 x float> %c) {
; CHECK-LABEL: mul_mul270_mul:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    .vsave {d12}
; CHECK-NEXT:    vpush {d12}
; CHECK-NEXT:    .vsave {d10}
; CHECK-NEXT:    vpush {d10}
; CHECK-NEXT:    .vsave {d8}
; CHECK-NEXT:    vpush {d8}
; CHECK-NEXT:    vmov.f32 s20, s4
; CHECK-NEXT:    vmov.f32 s16, s8
; CHECK-NEXT:    vmov.f32 s17, s10
; CHECK-NEXT:    vmov.f32 s21, s6
; CHECK-NEXT:    vmul.f32 q3, q5, q4
; CHECK-NEXT:    vmov.f32 s4, s5
; CHECK-NEXT:    vneg.f32 q3, q3
; CHECK-NEXT:    vmov.f32 s24, s9
; CHECK-NEXT:    vmov.f32 s25, s11
; CHECK-NEXT:    vmov.f32 s5, s7
; CHECK-NEXT:    vmul.f32 q2, q1, q4
; CHECK-NEXT:    vmov.f32 s16, s0
; CHECK-NEXT:    vfma.f32 q3, q1, q6
; CHECK-NEXT:    vmov.f32 s17, s2
; CHECK-NEXT:    vmov.f32 s0, s1
; CHECK-NEXT:    vfma.f32 q2, q5, q6
; CHECK-NEXT:    vmul.f32 q1, q3, q4
; CHECK-NEXT:    vmov.f32 s1, s3
; CHECK-NEXT:    vfma.f32 q1, q2, q0
; CHECK-NEXT:    vmul.f32 q0, q3, q0
; CHECK-NEXT:    vneg.f32 q3, q0
; CHECK-NEXT:    vmov.f32 s1, s4
; CHECK-NEXT:    vfma.f32 q3, q2, q4
; CHECK-NEXT:    vmov.f32 s3, s5
; CHECK-NEXT:    vmov.f32 s0, s12
; CHECK-NEXT:    vmov.f32 s2, s13
; CHECK-NEXT:    vpop {d8}
; CHECK-NEXT:    vpop {d10}
; CHECK-NEXT:    vpop {d12}
; CHECK-NEXT:    bx lr
entry:
  %strided.vec = shufflevector <4 x float> %c, <4 x float> poison, <2 x i32> <i32 0, i32 2>
  %strided.vec81 = shufflevector <4 x float> %c, <4 x float> poison, <2 x i32> <i32 1, i32 3>
  %strided.vec83 = shufflevector <4 x float> %b, <4 x float> poison, <2 x i32> <i32 0, i32 2>
  %strided.vec84 = shufflevector <4 x float> %b, <4 x float> poison, <2 x i32> <i32 1, i32 3>
  %0 = fmul fast <2 x float> %strided.vec84, %strided.vec
  %1 = fmul fast <2 x float> %strided.vec83, %strided.vec81
  %2 = fadd fast <2 x float> %1, %0
  %strided.vec86 = shufflevector <4 x float> %a, <4 x float> poison, <2 x i32> <i32 0, i32 2>
  %strided.vec87 = shufflevector <4 x float> %a, <4 x float> poison, <2 x i32> <i32 1, i32 3>
  %3 = fmul fast <2 x float> %2, %strided.vec87
  %4 = fmul fast <2 x float> %strided.vec84, %strided.vec81
  %5 = fmul fast <2 x float> %strided.vec83, %strided.vec
  %6 = fsub fast <2 x float> %4, %5
  %7 = fmul fast <2 x float> %6, %strided.vec86
  %8 = fadd fast <2 x float> %3, %7
  %9 = fmul fast <2 x float> %2, %strided.vec86
  %10 = fmul fast <2 x float> %6, %strided.vec87
  %11 = fsub fast <2 x float> %9, %10
  %interleaved.vec = shufflevector <2 x float> %11, <2 x float> %8, <4 x i32> <i32 0, i32 2, i32 1, i32 3>
  ret <4 x float> %interleaved.vec
}

; (a * b) * a
; Expected to transform
define arm_aapcs_vfpcc <4 x float> @mul_triangle(<4 x float> %a, <4 x float> %b) {
; CHECK-LABEL: mul_triangle:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vcmul.f32 q2, q1, q0, #0
; CHECK-NEXT:    vcmla.f32 q2, q1, q0, #90
; CHECK-NEXT:    vcmul.f32 q1, q0, q2, #0
; CHECK-NEXT:    vcmla.f32 q1, q0, q2, #90
; CHECK-NEXT:    vmov q0, q1
; CHECK-NEXT:    bx lr
entry:
  %strided.vec = shufflevector <4 x float> %a, <4 x float> poison, <2 x i32> <i32 0, i32 2>
  %strided.vec35 = shufflevector <4 x float> %a, <4 x float> poison, <2 x i32> <i32 1, i32 3>
  %strided.vec37 = shufflevector <4 x float> %b, <4 x float> poison, <2 x i32> <i32 0, i32 2>
  %strided.vec38 = shufflevector <4 x float> %b, <4 x float> poison, <2 x i32> <i32 1, i32 3>
  %0 = fmul fast <2 x float> %strided.vec37, %strided.vec
  %1 = fmul fast <2 x float> %strided.vec38, %strided.vec35
  %2 = fsub fast <2 x float> %0, %1
  %3 = fmul fast <2 x float> %2, %strided.vec35
  %4 = fmul fast <2 x float> %strided.vec38, %strided.vec
  %5 = fmul fast <2 x float> %strided.vec35, %strided.vec37
  %6 = fadd fast <2 x float> %4, %5
  %7 = fmul fast <2 x float> %6, %strided.vec
  %8 = fadd fast <2 x float> %3, %7
  %9 = fmul fast <2 x float> %2, %strided.vec
  %10 = fmul fast <2 x float> %6, %strided.vec35
  %11 = fsub fast <2 x float> %9, %10
  %interleaved.vec = shufflevector <2 x float> %11, <2 x float> %8, <4 x i32> <i32 0, i32 2, i32 1, i32 3>
  ret <4 x float> %interleaved.vec
}


; d * (b * a) * (c * a)
; Expected to transform
define arm_aapcs_vfpcc <4 x float> @mul_diamond(<4 x float> %a, <4 x float> %b, <4 x float> %c, <4 x float> %d) {
; CHECK-LABEL: mul_diamond:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    .vsave {d8, d9}
; CHECK-NEXT:    vpush {d8, d9}
; CHECK-NEXT:    vcmul.f32 q4, q1, q0, #0
; CHECK-NEXT:    vcmla.f32 q4, q1, q0, #90
; CHECK-NEXT:    vcmul.f32 q1, q4, q3, #0
; CHECK-NEXT:    vcmla.f32 q1, q4, q3, #90
; CHECK-NEXT:    vcmul.f32 q3, q2, q0, #0
; CHECK-NEXT:    vcmla.f32 q3, q2, q0, #90
; CHECK-NEXT:    vcmul.f32 q0, q3, q1, #0
; CHECK-NEXT:    vcmla.f32 q0, q3, q1, #90
; CHECK-NEXT:    vpop {d8, d9}
; CHECK-NEXT:    bx lr
entry:
  %a.real = shufflevector <4 x float> %a, <4 x float> poison, <2 x i32> <i32 0, i32 2>
  %a.imag = shufflevector <4 x float> %a, <4 x float> poison, <2 x i32> <i32 1, i32 3>
  %b.real = shufflevector <4 x float> %b, <4 x float> poison, <2 x i32> <i32 0, i32 2>
  %b.imag = shufflevector <4 x float> %b, <4 x float> poison, <2 x i32> <i32 1, i32 3>
  %c.real = shufflevector <4 x float> %c, <4 x float> poison, <2 x i32> <i32 0, i32 2>
  %c.imag = shufflevector <4 x float> %c, <4 x float> poison, <2 x i32> <i32 1, i32 3>
  %d.real = shufflevector <4 x float> %d, <4 x float> poison, <2 x i32> <i32 0, i32 2>
  %d.imag = shufflevector <4 x float> %d, <4 x float> poison, <2 x i32> <i32 1, i32 3>
  %0 = fmul fast <2 x float> %a.imag, %b.real
  %1 = fmul fast <2 x float> %a.real, %b.imag
  %2 = fadd fast <2 x float> %1, %0
  %3 = fmul fast <2 x float> %a.real, %b.real
  %4 = fmul fast <2 x float> %b.imag, %a.imag
  %5 = fsub fast <2 x float> %3, %4
  %6 = fmul fast <2 x float> %d.real, %5
  %7 = fmul fast <2 x float> %2, %d.imag
  %8 = fmul fast <2 x float> %d.real, %2
  %9 = fmul fast <2 x float> %5, %d.imag
  %10 = fsub fast <2 x float> %6, %7
  %11 = fadd fast <2 x float> %8, %9
  %12 = fmul fast <2 x float> %c.real, %a.imag
  %13 = fmul fast <2 x float> %c.imag, %a.real
  %14 = fadd fast <2 x float> %13, %12
  %15 = fmul fast <2 x float> %14, %10
  %16 = fmul fast <2 x float> %c.real, %a.real
  %17 = fmul fast <2 x float> %c.imag, %a.imag
  %18 = fsub fast <2 x float> %16, %17
  %19 = fmul fast <2 x float> %18, %11
  %20 = fadd fast <2 x float> %15, %19
  %21 = fmul fast <2 x float> %18, %10
  %22 = fmul fast <2 x float> %14, %11
  %23 = fsub fast <2 x float> %21, %22
  %interleaved.vec = shufflevector <2 x float> %23, <2 x float> %20, <4 x i32> <i32 0, i32 2, i32 1, i32 3>
  ret <4 x float> %interleaved.vec
}

; Expected to transform
define arm_aapcs_vfpcc <4 x float> @mul_add90_mul(<4 x float> %a, <4 x float> %b, <4 x float> %c) {
; CHECK-LABEL: mul_add90_mul:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    .vsave {d8, d9}
; CHECK-NEXT:    vpush {d8, d9}
; CHECK-NEXT:    vcmul.f32 q3, q2, q0, #0
; CHECK-NEXT:    vcmul.f32 q4, q1, q0, #0
; CHECK-NEXT:    vcmla.f32 q4, q1, q0, #90
; CHECK-NEXT:    vcmla.f32 q3, q2, q0, #90
; CHECK-NEXT:    vcadd.f32 q0, q3, q4, #90
; CHECK-NEXT:    vpop {d8, d9}
; CHECK-NEXT:    bx lr
entry:
  %ar = shufflevector <4 x float> %a, <4 x float> poison, <2 x i32> <i32 0, i32 2>
  %ai = shufflevector <4 x float> %a, <4 x float> poison, <2 x i32> <i32 1, i32 3>
  %br = shufflevector <4 x float> %b, <4 x float> poison, <2 x i32> <i32 0, i32 2>
  %bi = shufflevector <4 x float> %b, <4 x float> poison, <2 x i32> <i32 1, i32 3>
  %cr = shufflevector <4 x float> %c, <4 x float> poison, <2 x i32> <i32 0, i32 2>
  %ci = shufflevector <4 x float> %c, <4 x float> poison, <2 x i32> <i32 1, i32 3>

  %i6 = fmul fast <2 x float> %br, %ar
  %i7 = fmul fast <2 x float> %bi, %ai
  %xr = fsub fast <2 x float> %i6, %i7
  %i9 = fmul fast <2 x float> %bi, %ar
  %i10 = fmul fast <2 x float> %br, %ai
  %xi = fadd fast <2 x float> %i9, %i10

  %j6 = fmul fast <2 x float> %cr, %ar
  %j7 = fmul fast <2 x float> %ci, %ai
  %yr = fsub fast <2 x float> %j6, %j7
  %j9 = fmul fast <2 x float> %ci, %ar
  %j10 = fmul fast <2 x float> %cr, %ai
  %yi = fadd fast <2 x float> %j9, %j10

  %zr = fsub fast <2 x float> %yr, %xi
  %zi = fadd fast <2 x float> %yi, %xr
  %interleaved.vec = shufflevector <2 x float> %zr, <2 x float> %zi, <4 x i32> <i32 0, i32 2, i32 1, i32 3>
  ret <4 x float> %interleaved.vec
}

; Expected to not transform
define arm_aapcs_vfpcc <4 x float> @mul_triangle_addmul(<4 x float> %a, <4 x float> %b, <4 x float> %c) {
; CHECK-LABEL: mul_triangle_addmul:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    .vsave {d8, d9, d10, d11, d12, d13, d14, d15}
; CHECK-NEXT:    vpush {d8, d9, d10, d11, d12, d13, d14, d15}
; CHECK-NEXT:    vmov.f32 s16, s0
; CHECK-NEXT:    vmov.f32 s20, s5
; CHECK-NEXT:    vmov.f32 s17, s2
; CHECK-NEXT:    vmov.f32 s21, s7
; CHECK-NEXT:    vmov.f32 s5, s6
; CHECK-NEXT:    vmul.f32 q3, q5, q4
; CHECK-NEXT:    vmul.f32 q4, q1, q4
; CHECK-NEXT:    vmov.f32 s0, s1
; CHECK-NEXT:    vmov.f32 s1, s3
; CHECK-NEXT:    vmov q6, q4
; CHECK-NEXT:    vfms.f32 q6, q5, q0
; CHECK-NEXT:    vmov q7, q3
; CHECK-NEXT:    vfma.f32 q3, q1, q0
; CHECK-NEXT:    vmov.f32 s20, s8
; CHECK-NEXT:    vmov.f32 s21, s10
; CHECK-NEXT:    vmov.f32 s4, s9
; CHECK-NEXT:    vfma.f32 q7, q5, q0
; CHECK-NEXT:    vmov.f32 s5, s11
; CHECK-NEXT:    vadd.f32 q5, q7, q6
; CHECK-NEXT:    vfms.f32 q4, q1, q0
; CHECK-NEXT:    vmov.f32 s1, s20
; CHECK-NEXT:    vsub.f32 q1, q4, q3
; CHECK-NEXT:    vmov.f32 s3, s21
; CHECK-NEXT:    vmov.f32 s0, s4
; CHECK-NEXT:    vmov.f32 s2, s5
; CHECK-NEXT:    vpop {d8, d9, d10, d11, d12, d13, d14, d15}
; CHECK-NEXT:    bx lr
entry:
  %ar = shufflevector <4 x float> %a, <4 x float> poison, <2 x i32> <i32 0, i32 2>
  %ai = shufflevector <4 x float> %a, <4 x float> poison, <2 x i32> <i32 1, i32 3>
  %br = shufflevector <4 x float> %b, <4 x float> poison, <2 x i32> <i32 0, i32 2>
  %bi = shufflevector <4 x float> %b, <4 x float> poison, <2 x i32> <i32 1, i32 3>
  %cr = shufflevector <4 x float> %c, <4 x float> poison, <2 x i32> <i32 0, i32 2>
  %ci = shufflevector <4 x float> %c, <4 x float> poison, <2 x i32> <i32 1, i32 3>

  %i6 = fmul fast <2 x float> %br, %ar
  %i7 = fmul fast <2 x float> %bi, %ai
  %xr = fsub fast <2 x float> %i6, %i7
  %i9 = fmul fast <2 x float> %bi, %ar
  %i10 = fmul fast <2 x float> %br, %ai
  %xi = fadd fast <2 x float> %i9, %i10

  ;%j6 = fmul fast <2 x float> %cr, %ar
  %j7 = fmul fast <2 x float> %ci, %ai
  %yr = fsub fast <2 x float> %i6, %j7
  ;%j9 = fmul fast <2 x float> %ci, %ar
  %j10 = fmul fast <2 x float> %cr, %ai
  %yi = fadd fast <2 x float> %i9, %j10

  %zr = fsub fast <2 x float> %yr, %xi
  %zi = fadd fast <2 x float> %yi, %xr
  %interleaved.vec = shufflevector <2 x float> %zr, <2 x float> %zi, <4 x i32> <i32 0, i32 2, i32 1, i32 3>
  ret <4 x float> %interleaved.vec
}

; Expected to not transform
define arm_aapcs_vfpcc <4 x float> @mul_triangle_multiuses(<4 x float> %a, <4 x float> %b, ptr %p) {
; CHECK-LABEL: mul_triangle_multiuses:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    .vsave {d8, d9}
; CHECK-NEXT:    vpush {d8, d9}
; CHECK-NEXT:    vmov.f32 s16, s4
; CHECK-NEXT:    vmov.f32 s8, s1
; CHECK-NEXT:    vmov.f32 s17, s6
; CHECK-NEXT:    vmov.f32 s9, s3
; CHECK-NEXT:    vmov.f32 s4, s5
; CHECK-NEXT:    vmul.f32 q3, q2, q4
; CHECK-NEXT:    vmov.f32 s1, s2
; CHECK-NEXT:    vmov.f32 s5, s7
; CHECK-NEXT:    vfma.f32 q3, q1, q0
; CHECK-NEXT:    vmul.f32 q1, q1, q2
; CHECK-NEXT:    vneg.f32 q1, q1
; CHECK-NEXT:    vfma.f32 q1, q4, q0
; CHECK-NEXT:    vmov.f32 s18, s12
; CHECK-NEXT:    vmov.f32 s16, s4
; CHECK-NEXT:    vmov.f32 s17, s5
; CHECK-NEXT:    vmov.f32 s19, s13
; CHECK-NEXT:    vstrw.32 q4, [r0]
; CHECK-NEXT:    vmul.f32 q4, q3, q0
; CHECK-NEXT:    vfma.f32 q4, q1, q2
; CHECK-NEXT:    vmul.f32 q2, q3, q2
; CHECK-NEXT:    vneg.f32 q2, q2
; CHECK-NEXT:    vfma.f32 q2, q1, q0
; CHECK-NEXT:    vmov.f32 s1, s16
; CHECK-NEXT:    vmov.f32 s0, s8
; CHECK-NEXT:    vmov.f32 s2, s9
; CHECK-NEXT:    vmov.f32 s3, s17
; CHECK-NEXT:    vpop {d8, d9}
; CHECK-NEXT:    bx lr
entry:
  %strided.vec = shufflevector <4 x float> %a, <4 x float> poison, <2 x i32> <i32 0, i32 2>
  %strided.vec35 = shufflevector <4 x float> %a, <4 x float> poison, <2 x i32> <i32 1, i32 3>
  %strided.vec37 = shufflevector <4 x float> %b, <4 x float> poison, <2 x i32> <i32 0, i32 2>
  %strided.vec38 = shufflevector <4 x float> %b, <4 x float> poison, <2 x i32> <i32 1, i32 3>
  %0 = fmul fast <2 x float> %strided.vec37, %strided.vec
  %1 = fmul fast <2 x float> %strided.vec38, %strided.vec35
  %2 = fsub fast <2 x float> %0, %1
  %3 = fmul fast <2 x float> %2, %strided.vec35
  %4 = fmul fast <2 x float> %strided.vec38, %strided.vec
  %5 = fmul fast <2 x float> %strided.vec35, %strided.vec37
  %6 = fadd fast <2 x float> %4, %5
  %otheruse = shufflevector <2 x float> %2, <2 x float> %6, <4 x i32> <i32 0, i32 1, i32 2, i32 3>
  store <4 x float> %otheruse, ptr %p
  %7 = fmul fast <2 x float> %6, %strided.vec
  %8 = fadd fast <2 x float> %3, %7
  %9 = fmul fast <2 x float> %2, %strided.vec
  %10 = fmul fast <2 x float> %6, %strided.vec35
  %11 = fsub fast <2 x float> %9, %10
  %interleaved.vec = shufflevector <2 x float> %11, <2 x float> %8, <4 x i32> <i32 0, i32 2, i32 1, i32 3>
  ret <4 x float> %interleaved.vec
}
