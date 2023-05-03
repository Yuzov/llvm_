; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -force-streaming-compatible-sve < %s | FileCheck %s

target triple = "aarch64-unknown-linux-gnu"

;
; UADDV
;

define i8 @uaddv_v8i8(<8 x i8> %a) #0 {
; CHECK-LABEL: uaddv_v8i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    // kill: def $d0 killed $d0 def $z0
; CHECK-NEXT:    ptrue p0.b, vl8
; CHECK-NEXT:    uaddv d0, p0, z0.b
; CHECK-NEXT:    fmov x0, d0
; CHECK-NEXT:    // kill: def $w0 killed $w0 killed $x0
; CHECK-NEXT:    ret
  %res = call i8 @llvm.vector.reduce.add.v8i8(<8 x i8> %a)
  ret i8 %res
}

define i8 @uaddv_v16i8(<16 x i8> %a) #0 {
; CHECK-LABEL: uaddv_v16i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    // kill: def $q0 killed $q0 def $z0
; CHECK-NEXT:    ptrue p0.b, vl16
; CHECK-NEXT:    uaddv d0, p0, z0.b
; CHECK-NEXT:    fmov x0, d0
; CHECK-NEXT:    // kill: def $w0 killed $w0 killed $x0
; CHECK-NEXT:    ret
  %res = call i8 @llvm.vector.reduce.add.v16i8(<16 x i8> %a)
  ret i8 %res
}

define i8 @uaddv_v32i8(ptr %a) #0 {
; CHECK-LABEL: uaddv_v32i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldp q1, q0, [x0]
; CHECK-NEXT:    ptrue p0.b, vl16
; CHECK-NEXT:    add z0.b, z1.b, z0.b
; CHECK-NEXT:    uaddv d0, p0, z0.b
; CHECK-NEXT:    fmov x0, d0
; CHECK-NEXT:    // kill: def $w0 killed $w0 killed $x0
; CHECK-NEXT:    ret
  %op = load <32 x i8>, ptr %a
  %res = call i8 @llvm.vector.reduce.add.v32i8(<32 x i8> %op)
  ret i8 %res
}

define i16 @uaddv_v4i16(<4 x i16> %a) #0 {
; CHECK-LABEL: uaddv_v4i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    // kill: def $d0 killed $d0 def $z0
; CHECK-NEXT:    ptrue p0.h, vl4
; CHECK-NEXT:    uaddv d0, p0, z0.h
; CHECK-NEXT:    fmov x0, d0
; CHECK-NEXT:    // kill: def $w0 killed $w0 killed $x0
; CHECK-NEXT:    ret
  %res = call i16 @llvm.vector.reduce.add.v4i16(<4 x i16> %a)
  ret i16 %res
}

define i16 @uaddv_v8i16(<8 x i16> %a) #0 {
; CHECK-LABEL: uaddv_v8i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    // kill: def $q0 killed $q0 def $z0
; CHECK-NEXT:    ptrue p0.h, vl8
; CHECK-NEXT:    uaddv d0, p0, z0.h
; CHECK-NEXT:    fmov x0, d0
; CHECK-NEXT:    // kill: def $w0 killed $w0 killed $x0
; CHECK-NEXT:    ret
  %res = call i16 @llvm.vector.reduce.add.v8i16(<8 x i16> %a)
  ret i16 %res
}

define i16 @uaddv_v16i16(ptr %a) #0 {
; CHECK-LABEL: uaddv_v16i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldp q1, q0, [x0]
; CHECK-NEXT:    ptrue p0.h, vl8
; CHECK-NEXT:    add z0.h, z1.h, z0.h
; CHECK-NEXT:    uaddv d0, p0, z0.h
; CHECK-NEXT:    fmov x0, d0
; CHECK-NEXT:    // kill: def $w0 killed $w0 killed $x0
; CHECK-NEXT:    ret
  %op = load <16 x i16>, ptr %a
  %res = call i16 @llvm.vector.reduce.add.v16i16(<16 x i16> %op)
  ret i16 %res
}

define i32 @uaddv_v2i32(<2 x i32> %a) #0 {
; CHECK-LABEL: uaddv_v2i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    // kill: def $d0 killed $d0 def $z0
; CHECK-NEXT:    ptrue p0.s, vl2
; CHECK-NEXT:    uaddv d0, p0, z0.s
; CHECK-NEXT:    fmov x0, d0
; CHECK-NEXT:    // kill: def $w0 killed $w0 killed $x0
; CHECK-NEXT:    ret
  %res = call i32 @llvm.vector.reduce.add.v2i32(<2 x i32> %a)
  ret i32 %res
}

define i32 @uaddv_v4i32(<4 x i32> %a) #0 {
; CHECK-LABEL: uaddv_v4i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    // kill: def $q0 killed $q0 def $z0
; CHECK-NEXT:    ptrue p0.s, vl4
; CHECK-NEXT:    uaddv d0, p0, z0.s
; CHECK-NEXT:    fmov x0, d0
; CHECK-NEXT:    // kill: def $w0 killed $w0 killed $x0
; CHECK-NEXT:    ret
  %res = call i32 @llvm.vector.reduce.add.v4i32(<4 x i32> %a)
  ret i32 %res
}

define i32 @uaddv_v8i32(ptr %a) #0 {
; CHECK-LABEL: uaddv_v8i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldp q1, q0, [x0]
; CHECK-NEXT:    ptrue p0.s, vl4
; CHECK-NEXT:    add z0.s, z1.s, z0.s
; CHECK-NEXT:    uaddv d0, p0, z0.s
; CHECK-NEXT:    fmov x0, d0
; CHECK-NEXT:    // kill: def $w0 killed $w0 killed $x0
; CHECK-NEXT:    ret
  %op = load <8 x i32>, ptr %a
  %res = call i32 @llvm.vector.reduce.add.v8i32(<8 x i32> %op)
  ret i32 %res
}

define i64 @uaddv_v2i64(<2 x i64> %a) #0 {
; CHECK-LABEL: uaddv_v2i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    // kill: def $q0 killed $q0 def $z0
; CHECK-NEXT:    ptrue p0.d, vl2
; CHECK-NEXT:    uaddv d0, p0, z0.d
; CHECK-NEXT:    fmov x0, d0
; CHECK-NEXT:    ret
  %res = call i64 @llvm.vector.reduce.add.v2i64(<2 x i64> %a)
  ret i64 %res
}

define i64 @uaddv_v4i64(ptr %a) #0 {
; CHECK-LABEL: uaddv_v4i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldp q1, q0, [x0]
; CHECK-NEXT:    ptrue p0.d, vl2
; CHECK-NEXT:    add z0.d, z1.d, z0.d
; CHECK-NEXT:    uaddv d0, p0, z0.d
; CHECK-NEXT:    fmov x0, d0
; CHECK-NEXT:    ret
  %op = load <4 x i64>, ptr %a
  %res = call i64 @llvm.vector.reduce.add.v4i64(<4 x i64> %op)
  ret i64 %res
}

;
; SMAXV
;

define i8 @smaxv_v8i8(<8 x i8> %a) #0 {
; CHECK-LABEL: smaxv_v8i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    // kill: def $d0 killed $d0 def $z0
; CHECK-NEXT:    ptrue p0.b, vl8
; CHECK-NEXT:    smaxv b0, p0, z0.b
; CHECK-NEXT:    fmov w0, s0
; CHECK-NEXT:    ret
  %res = call i8 @llvm.vector.reduce.smax.v8i8(<8 x i8> %a)
  ret i8 %res
}

define i8 @smaxv_v16i8(<16 x i8> %a) #0 {
; CHECK-LABEL: smaxv_v16i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    // kill: def $q0 killed $q0 def $z0
; CHECK-NEXT:    ptrue p0.b, vl16
; CHECK-NEXT:    smaxv b0, p0, z0.b
; CHECK-NEXT:    fmov w0, s0
; CHECK-NEXT:    ret
  %res = call i8 @llvm.vector.reduce.smax.v16i8(<16 x i8> %a)
  ret i8 %res
}

define i8 @smaxv_v32i8(ptr %a) #0 {
; CHECK-LABEL: smaxv_v32i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldp q1, q0, [x0]
; CHECK-NEXT:    ptrue p0.b, vl16
; CHECK-NEXT:    smax z0.b, p0/m, z0.b, z1.b
; CHECK-NEXT:    smaxv b0, p0, z0.b
; CHECK-NEXT:    fmov w0, s0
; CHECK-NEXT:    ret
  %op = load <32 x i8>, ptr %a
  %res = call i8 @llvm.vector.reduce.smax.v32i8(<32 x i8> %op)
  ret i8 %res
}

define i16 @smaxv_v4i16(<4 x i16> %a) #0 {
; CHECK-LABEL: smaxv_v4i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    // kill: def $d0 killed $d0 def $z0
; CHECK-NEXT:    ptrue p0.h, vl4
; CHECK-NEXT:    smaxv h0, p0, z0.h
; CHECK-NEXT:    fmov w0, s0
; CHECK-NEXT:    ret
  %res = call i16 @llvm.vector.reduce.smax.v4i16(<4 x i16> %a)
  ret i16 %res
}

define i16 @smaxv_v8i16(<8 x i16> %a) #0 {
; CHECK-LABEL: smaxv_v8i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    // kill: def $q0 killed $q0 def $z0
; CHECK-NEXT:    ptrue p0.h, vl8
; CHECK-NEXT:    smaxv h0, p0, z0.h
; CHECK-NEXT:    fmov w0, s0
; CHECK-NEXT:    ret
  %res = call i16 @llvm.vector.reduce.smax.v8i16(<8 x i16> %a)
  ret i16 %res
}

define i16 @smaxv_v16i16(ptr %a) #0 {
; CHECK-LABEL: smaxv_v16i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldp q1, q0, [x0]
; CHECK-NEXT:    ptrue p0.h, vl8
; CHECK-NEXT:    smax z0.h, p0/m, z0.h, z1.h
; CHECK-NEXT:    smaxv h0, p0, z0.h
; CHECK-NEXT:    fmov w0, s0
; CHECK-NEXT:    ret
  %op = load <16 x i16>, ptr %a
  %res = call i16 @llvm.vector.reduce.smax.v16i16(<16 x i16> %op)
  ret i16 %res
}

define i32 @smaxv_v2i32(<2 x i32> %a) #0 {
; CHECK-LABEL: smaxv_v2i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    // kill: def $d0 killed $d0 def $z0
; CHECK-NEXT:    ptrue p0.s, vl2
; CHECK-NEXT:    smaxv s0, p0, z0.s
; CHECK-NEXT:    fmov w0, s0
; CHECK-NEXT:    ret
  %res = call i32 @llvm.vector.reduce.smax.v2i32(<2 x i32> %a)
  ret i32 %res
}

define i32 @smaxv_v4i32(<4 x i32> %a) #0 {
; CHECK-LABEL: smaxv_v4i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    // kill: def $q0 killed $q0 def $z0
; CHECK-NEXT:    ptrue p0.s, vl4
; CHECK-NEXT:    smaxv s0, p0, z0.s
; CHECK-NEXT:    fmov w0, s0
; CHECK-NEXT:    ret
  %res = call i32 @llvm.vector.reduce.smax.v4i32(<4 x i32> %a)
  ret i32 %res
}

define i32 @smaxv_v8i32(ptr %a) #0 {
; CHECK-LABEL: smaxv_v8i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldp q1, q0, [x0]
; CHECK-NEXT:    ptrue p0.s, vl4
; CHECK-NEXT:    smax z0.s, p0/m, z0.s, z1.s
; CHECK-NEXT:    smaxv s0, p0, z0.s
; CHECK-NEXT:    fmov w0, s0
; CHECK-NEXT:    ret
  %op = load <8 x i32>, ptr %a
  %res = call i32 @llvm.vector.reduce.smax.v8i32(<8 x i32> %op)
  ret i32 %res
}

; No NEON 64-bit vector SMAXV support. Use SVE.
define i64 @smaxv_v2i64(<2 x i64> %a) #0 {
; CHECK-LABEL: smaxv_v2i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    // kill: def $q0 killed $q0 def $z0
; CHECK-NEXT:    ptrue p0.d, vl2
; CHECK-NEXT:    smaxv d0, p0, z0.d
; CHECK-NEXT:    fmov x0, d0
; CHECK-NEXT:    ret
  %res = call i64 @llvm.vector.reduce.smax.v2i64(<2 x i64> %a)
  ret i64 %res
}

define i64 @smaxv_v4i64(ptr %a) #0 {
; CHECK-LABEL: smaxv_v4i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldp q1, q0, [x0]
; CHECK-NEXT:    ptrue p0.d, vl2
; CHECK-NEXT:    smax z0.d, p0/m, z0.d, z1.d
; CHECK-NEXT:    smaxv d0, p0, z0.d
; CHECK-NEXT:    fmov x0, d0
; CHECK-NEXT:    ret
  %op = load <4 x i64>, ptr %a
  %res = call i64 @llvm.vector.reduce.smax.v4i64(<4 x i64> %op)
  ret i64 %res
}

;
; SMINV
;

define i8 @sminv_v8i8(<8 x i8> %a) #0 {
; CHECK-LABEL: sminv_v8i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    // kill: def $d0 killed $d0 def $z0
; CHECK-NEXT:    ptrue p0.b, vl8
; CHECK-NEXT:    sminv b0, p0, z0.b
; CHECK-NEXT:    fmov w0, s0
; CHECK-NEXT:    ret
  %res = call i8 @llvm.vector.reduce.smin.v8i8(<8 x i8> %a)
  ret i8 %res
}

define i8 @sminv_v16i8(<16 x i8> %a) #0 {
; CHECK-LABEL: sminv_v16i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    // kill: def $q0 killed $q0 def $z0
; CHECK-NEXT:    ptrue p0.b, vl16
; CHECK-NEXT:    sminv b0, p0, z0.b
; CHECK-NEXT:    fmov w0, s0
; CHECK-NEXT:    ret
  %res = call i8 @llvm.vector.reduce.smin.v16i8(<16 x i8> %a)
  ret i8 %res
}

define i8 @sminv_v32i8(ptr %a) #0 {
; CHECK-LABEL: sminv_v32i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldp q1, q0, [x0]
; CHECK-NEXT:    ptrue p0.b, vl16
; CHECK-NEXT:    smin z0.b, p0/m, z0.b, z1.b
; CHECK-NEXT:    sminv b0, p0, z0.b
; CHECK-NEXT:    fmov w0, s0
; CHECK-NEXT:    ret
  %op = load <32 x i8>, ptr %a
  %res = call i8 @llvm.vector.reduce.smin.v32i8(<32 x i8> %op)
  ret i8 %res
}

define i16 @sminv_v4i16(<4 x i16> %a) #0 {
; CHECK-LABEL: sminv_v4i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    // kill: def $d0 killed $d0 def $z0
; CHECK-NEXT:    ptrue p0.h, vl4
; CHECK-NEXT:    sminv h0, p0, z0.h
; CHECK-NEXT:    fmov w0, s0
; CHECK-NEXT:    ret
  %res = call i16 @llvm.vector.reduce.smin.v4i16(<4 x i16> %a)
  ret i16 %res
}

define i16 @sminv_v8i16(<8 x i16> %a) #0 {
; CHECK-LABEL: sminv_v8i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    // kill: def $q0 killed $q0 def $z0
; CHECK-NEXT:    ptrue p0.h, vl8
; CHECK-NEXT:    sminv h0, p0, z0.h
; CHECK-NEXT:    fmov w0, s0
; CHECK-NEXT:    ret
  %res = call i16 @llvm.vector.reduce.smin.v8i16(<8 x i16> %a)
  ret i16 %res
}

define i16 @sminv_v16i16(ptr %a) #0 {
; CHECK-LABEL: sminv_v16i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldp q1, q0, [x0]
; CHECK-NEXT:    ptrue p0.h, vl8
; CHECK-NEXT:    smin z0.h, p0/m, z0.h, z1.h
; CHECK-NEXT:    sminv h0, p0, z0.h
; CHECK-NEXT:    fmov w0, s0
; CHECK-NEXT:    ret
  %op = load <16 x i16>, ptr %a
  %res = call i16 @llvm.vector.reduce.smin.v16i16(<16 x i16> %op)
  ret i16 %res
}

define i32 @sminv_v2i32(<2 x i32> %a) #0 {
; CHECK-LABEL: sminv_v2i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    // kill: def $d0 killed $d0 def $z0
; CHECK-NEXT:    ptrue p0.s, vl2
; CHECK-NEXT:    sminv s0, p0, z0.s
; CHECK-NEXT:    fmov w0, s0
; CHECK-NEXT:    ret
  %res = call i32 @llvm.vector.reduce.smin.v2i32(<2 x i32> %a)
  ret i32 %res
}

define i32 @sminv_v4i32(<4 x i32> %a) #0 {
; CHECK-LABEL: sminv_v4i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    // kill: def $q0 killed $q0 def $z0
; CHECK-NEXT:    ptrue p0.s, vl4
; CHECK-NEXT:    sminv s0, p0, z0.s
; CHECK-NEXT:    fmov w0, s0
; CHECK-NEXT:    ret
  %res = call i32 @llvm.vector.reduce.smin.v4i32(<4 x i32> %a)
  ret i32 %res
}

define i32 @sminv_v8i32(ptr %a) #0 {
; CHECK-LABEL: sminv_v8i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldp q1, q0, [x0]
; CHECK-NEXT:    ptrue p0.s, vl4
; CHECK-NEXT:    smin z0.s, p0/m, z0.s, z1.s
; CHECK-NEXT:    sminv s0, p0, z0.s
; CHECK-NEXT:    fmov w0, s0
; CHECK-NEXT:    ret
  %op = load <8 x i32>, ptr %a
  %res = call i32 @llvm.vector.reduce.smin.v8i32(<8 x i32> %op)
  ret i32 %res
}

; No NEON 64-bit vector SMINV support. Use SVE.
define i64 @sminv_v2i64(<2 x i64> %a) #0 {
; CHECK-LABEL: sminv_v2i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    // kill: def $q0 killed $q0 def $z0
; CHECK-NEXT:    ptrue p0.d, vl2
; CHECK-NEXT:    sminv d0, p0, z0.d
; CHECK-NEXT:    fmov x0, d0
; CHECK-NEXT:    ret
  %res = call i64 @llvm.vector.reduce.smin.v2i64(<2 x i64> %a)
  ret i64 %res
}

define i64 @sminv_v4i64(ptr %a) #0 {
; CHECK-LABEL: sminv_v4i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldp q1, q0, [x0]
; CHECK-NEXT:    ptrue p0.d, vl2
; CHECK-NEXT:    smin z0.d, p0/m, z0.d, z1.d
; CHECK-NEXT:    sminv d0, p0, z0.d
; CHECK-NEXT:    fmov x0, d0
; CHECK-NEXT:    ret
  %op = load <4 x i64>, ptr %a
  %res = call i64 @llvm.vector.reduce.smin.v4i64(<4 x i64> %op)
  ret i64 %res
}

;
; UMAXV
;

define i8 @umaxv_v8i8(<8 x i8> %a) #0 {
; CHECK-LABEL: umaxv_v8i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    // kill: def $d0 killed $d0 def $z0
; CHECK-NEXT:    ptrue p0.b, vl8
; CHECK-NEXT:    umaxv b0, p0, z0.b
; CHECK-NEXT:    fmov w0, s0
; CHECK-NEXT:    ret
  %res = call i8 @llvm.vector.reduce.umax.v8i8(<8 x i8> %a)
  ret i8 %res
}

define i8 @umaxv_v16i8(<16 x i8> %a) #0 {
; CHECK-LABEL: umaxv_v16i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    // kill: def $q0 killed $q0 def $z0
; CHECK-NEXT:    ptrue p0.b, vl16
; CHECK-NEXT:    umaxv b0, p0, z0.b
; CHECK-NEXT:    fmov w0, s0
; CHECK-NEXT:    ret
  %res = call i8 @llvm.vector.reduce.umax.v16i8(<16 x i8> %a)
  ret i8 %res
}

define i8 @umaxv_v32i8(ptr %a) #0 {
; CHECK-LABEL: umaxv_v32i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldp q1, q0, [x0]
; CHECK-NEXT:    ptrue p0.b, vl16
; CHECK-NEXT:    umax z0.b, p0/m, z0.b, z1.b
; CHECK-NEXT:    umaxv b0, p0, z0.b
; CHECK-NEXT:    fmov w0, s0
; CHECK-NEXT:    ret
  %op = load <32 x i8>, ptr %a
  %res = call i8 @llvm.vector.reduce.umax.v32i8(<32 x i8> %op)
  ret i8 %res
}

define i16 @umaxv_v4i16(<4 x i16> %a) #0 {
; CHECK-LABEL: umaxv_v4i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    // kill: def $d0 killed $d0 def $z0
; CHECK-NEXT:    ptrue p0.h, vl4
; CHECK-NEXT:    umaxv h0, p0, z0.h
; CHECK-NEXT:    fmov w0, s0
; CHECK-NEXT:    ret
  %res = call i16 @llvm.vector.reduce.umax.v4i16(<4 x i16> %a)
  ret i16 %res
}

define i16 @umaxv_v8i16(<8 x i16> %a) #0 {
; CHECK-LABEL: umaxv_v8i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    // kill: def $q0 killed $q0 def $z0
; CHECK-NEXT:    ptrue p0.h, vl8
; CHECK-NEXT:    umaxv h0, p0, z0.h
; CHECK-NEXT:    fmov w0, s0
; CHECK-NEXT:    ret
  %res = call i16 @llvm.vector.reduce.umax.v8i16(<8 x i16> %a)
  ret i16 %res
}

define i16 @umaxv_v16i16(ptr %a) #0 {
; CHECK-LABEL: umaxv_v16i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldp q1, q0, [x0]
; CHECK-NEXT:    ptrue p0.h, vl8
; CHECK-NEXT:    umax z0.h, p0/m, z0.h, z1.h
; CHECK-NEXT:    umaxv h0, p0, z0.h
; CHECK-NEXT:    fmov w0, s0
; CHECK-NEXT:    ret
  %op = load <16 x i16>, ptr %a
  %res = call i16 @llvm.vector.reduce.umax.v16i16(<16 x i16> %op)
  ret i16 %res
}

define i32 @umaxv_v2i32(<2 x i32> %a) #0 {
; CHECK-LABEL: umaxv_v2i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    // kill: def $d0 killed $d0 def $z0
; CHECK-NEXT:    ptrue p0.s, vl2
; CHECK-NEXT:    umaxv s0, p0, z0.s
; CHECK-NEXT:    fmov w0, s0
; CHECK-NEXT:    ret
  %res = call i32 @llvm.vector.reduce.umax.v2i32(<2 x i32> %a)
  ret i32 %res
}

define i32 @umaxv_v4i32(<4 x i32> %a) #0 {
; CHECK-LABEL: umaxv_v4i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    // kill: def $q0 killed $q0 def $z0
; CHECK-NEXT:    ptrue p0.s, vl4
; CHECK-NEXT:    umaxv s0, p0, z0.s
; CHECK-NEXT:    fmov w0, s0
; CHECK-NEXT:    ret
  %res = call i32 @llvm.vector.reduce.umax.v4i32(<4 x i32> %a)
  ret i32 %res
}

define i32 @umaxv_v8i32(ptr %a) #0 {
; CHECK-LABEL: umaxv_v8i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldp q1, q0, [x0]
; CHECK-NEXT:    ptrue p0.s, vl4
; CHECK-NEXT:    umax z0.s, p0/m, z0.s, z1.s
; CHECK-NEXT:    umaxv s0, p0, z0.s
; CHECK-NEXT:    fmov w0, s0
; CHECK-NEXT:    ret
  %op = load <8 x i32>, ptr %a
  %res = call i32 @llvm.vector.reduce.umax.v8i32(<8 x i32> %op)
  ret i32 %res
}

; No NEON 64-bit vector UMAXV support. Use SVE.
define i64 @umaxv_v2i64(<2 x i64> %a) #0 {
; CHECK-LABEL: umaxv_v2i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    // kill: def $q0 killed $q0 def $z0
; CHECK-NEXT:    ptrue p0.d, vl2
; CHECK-NEXT:    umaxv d0, p0, z0.d
; CHECK-NEXT:    fmov x0, d0
; CHECK-NEXT:    ret
  %res = call i64 @llvm.vector.reduce.umax.v2i64(<2 x i64> %a)
  ret i64 %res
}

define i64 @umaxv_v4i64(ptr %a) #0 {
; CHECK-LABEL: umaxv_v4i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldp q1, q0, [x0]
; CHECK-NEXT:    ptrue p0.d, vl2
; CHECK-NEXT:    umax z0.d, p0/m, z0.d, z1.d
; CHECK-NEXT:    umaxv d0, p0, z0.d
; CHECK-NEXT:    fmov x0, d0
; CHECK-NEXT:    ret
  %op = load <4 x i64>, ptr %a
  %res = call i64 @llvm.vector.reduce.umax.v4i64(<4 x i64> %op)
  ret i64 %res
}

;
; UMINV
;

define i8 @uminv_v8i8(<8 x i8> %a) #0 {
; CHECK-LABEL: uminv_v8i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    // kill: def $d0 killed $d0 def $z0
; CHECK-NEXT:    ptrue p0.b, vl8
; CHECK-NEXT:    uminv b0, p0, z0.b
; CHECK-NEXT:    fmov w0, s0
; CHECK-NEXT:    ret
  %res = call i8 @llvm.vector.reduce.umin.v8i8(<8 x i8> %a)
  ret i8 %res
}

define i8 @uminv_v16i8(<16 x i8> %a) #0 {
; CHECK-LABEL: uminv_v16i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    // kill: def $q0 killed $q0 def $z0
; CHECK-NEXT:    ptrue p0.b, vl16
; CHECK-NEXT:    uminv b0, p0, z0.b
; CHECK-NEXT:    fmov w0, s0
; CHECK-NEXT:    ret
  %res = call i8 @llvm.vector.reduce.umin.v16i8(<16 x i8> %a)
  ret i8 %res
}

define i8 @uminv_v32i8(ptr %a) #0 {
; CHECK-LABEL: uminv_v32i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldp q1, q0, [x0]
; CHECK-NEXT:    ptrue p0.b, vl16
; CHECK-NEXT:    umin z0.b, p0/m, z0.b, z1.b
; CHECK-NEXT:    uminv b0, p0, z0.b
; CHECK-NEXT:    fmov w0, s0
; CHECK-NEXT:    ret
  %op = load <32 x i8>, ptr %a
  %res = call i8 @llvm.vector.reduce.umin.v32i8(<32 x i8> %op)
  ret i8 %res
}

define i16 @uminv_v4i16(<4 x i16> %a) #0 {
; CHECK-LABEL: uminv_v4i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    // kill: def $d0 killed $d0 def $z0
; CHECK-NEXT:    ptrue p0.h, vl4
; CHECK-NEXT:    uminv h0, p0, z0.h
; CHECK-NEXT:    fmov w0, s0
; CHECK-NEXT:    ret
  %res = call i16 @llvm.vector.reduce.umin.v4i16(<4 x i16> %a)
  ret i16 %res
}

define i16 @uminv_v8i16(<8 x i16> %a) #0 {
; CHECK-LABEL: uminv_v8i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    // kill: def $q0 killed $q0 def $z0
; CHECK-NEXT:    ptrue p0.h, vl8
; CHECK-NEXT:    uminv h0, p0, z0.h
; CHECK-NEXT:    fmov w0, s0
; CHECK-NEXT:    ret
  %res = call i16 @llvm.vector.reduce.umin.v8i16(<8 x i16> %a)
  ret i16 %res
}

define i16 @uminv_v16i16(ptr %a) #0 {
; CHECK-LABEL: uminv_v16i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldp q1, q0, [x0]
; CHECK-NEXT:    ptrue p0.h, vl8
; CHECK-NEXT:    umin z0.h, p0/m, z0.h, z1.h
; CHECK-NEXT:    uminv h0, p0, z0.h
; CHECK-NEXT:    fmov w0, s0
; CHECK-NEXT:    ret
  %op = load <16 x i16>, ptr %a
  %res = call i16 @llvm.vector.reduce.umin.v16i16(<16 x i16> %op)
  ret i16 %res
}

define i32 @uminv_v2i32(<2 x i32> %a) #0 {
; CHECK-LABEL: uminv_v2i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    // kill: def $d0 killed $d0 def $z0
; CHECK-NEXT:    ptrue p0.s, vl2
; CHECK-NEXT:    uminv s0, p0, z0.s
; CHECK-NEXT:    fmov w0, s0
; CHECK-NEXT:    ret
  %res = call i32 @llvm.vector.reduce.umin.v2i32(<2 x i32> %a)
  ret i32 %res
}

define i32 @uminv_v4i32(<4 x i32> %a) #0 {
; CHECK-LABEL: uminv_v4i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    // kill: def $q0 killed $q0 def $z0
; CHECK-NEXT:    ptrue p0.s, vl4
; CHECK-NEXT:    uminv s0, p0, z0.s
; CHECK-NEXT:    fmov w0, s0
; CHECK-NEXT:    ret
  %res = call i32 @llvm.vector.reduce.umin.v4i32(<4 x i32> %a)
  ret i32 %res
}

define i32 @uminv_v8i32(ptr %a) #0 {
; CHECK-LABEL: uminv_v8i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldp q1, q0, [x0]
; CHECK-NEXT:    ptrue p0.s, vl4
; CHECK-NEXT:    umin z0.s, p0/m, z0.s, z1.s
; CHECK-NEXT:    uminv s0, p0, z0.s
; CHECK-NEXT:    fmov w0, s0
; CHECK-NEXT:    ret
  %op = load <8 x i32>, ptr %a
  %res = call i32 @llvm.vector.reduce.umin.v8i32(<8 x i32> %op)
  ret i32 %res
}

; No NEON 64-bit vector UMINV support. Use SVE.
define i64 @uminv_v2i64(<2 x i64> %a) #0 {
; CHECK-LABEL: uminv_v2i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    // kill: def $q0 killed $q0 def $z0
; CHECK-NEXT:    ptrue p0.d, vl2
; CHECK-NEXT:    uminv d0, p0, z0.d
; CHECK-NEXT:    fmov x0, d0
; CHECK-NEXT:    ret
  %res = call i64 @llvm.vector.reduce.umin.v2i64(<2 x i64> %a)
  ret i64 %res
}

define i64 @uminv_v4i64(ptr %a) #0 {
; CHECK-LABEL: uminv_v4i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldp q1, q0, [x0]
; CHECK-NEXT:    ptrue p0.d, vl2
; CHECK-NEXT:    umin z0.d, p0/m, z0.d, z1.d
; CHECK-NEXT:    uminv d0, p0, z0.d
; CHECK-NEXT:    fmov x0, d0
; CHECK-NEXT:    ret
  %op = load <4 x i64>, ptr %a
  %res = call i64 @llvm.vector.reduce.umin.v4i64(<4 x i64> %op)
  ret i64 %res
}

attributes #0 = { "target-features"="+sve" }

declare i8 @llvm.vector.reduce.add.v8i8(<8 x i8>)
declare i8 @llvm.vector.reduce.add.v16i8(<16 x i8>)
declare i8 @llvm.vector.reduce.add.v32i8(<32 x i8>)

declare i16 @llvm.vector.reduce.add.v4i16(<4 x i16>)
declare i16 @llvm.vector.reduce.add.v8i16(<8 x i16>)
declare i16 @llvm.vector.reduce.add.v16i16(<16 x i16>)

declare i32 @llvm.vector.reduce.add.v2i32(<2 x i32>)
declare i32 @llvm.vector.reduce.add.v4i32(<4 x i32>)
declare i32 @llvm.vector.reduce.add.v8i32(<8 x i32>)

declare i64 @llvm.vector.reduce.add.v2i64(<2 x i64>)
declare i64 @llvm.vector.reduce.add.v4i64(<4 x i64>)

declare i8 @llvm.vector.reduce.smax.v8i8(<8 x i8>)
declare i8 @llvm.vector.reduce.smax.v16i8(<16 x i8>)
declare i8 @llvm.vector.reduce.smax.v32i8(<32 x i8>)

declare i16 @llvm.vector.reduce.smax.v4i16(<4 x i16>)
declare i16 @llvm.vector.reduce.smax.v8i16(<8 x i16>)
declare i16 @llvm.vector.reduce.smax.v16i16(<16 x i16>)

declare i32 @llvm.vector.reduce.smax.v2i32(<2 x i32>)
declare i32 @llvm.vector.reduce.smax.v4i32(<4 x i32>)
declare i32 @llvm.vector.reduce.smax.v8i32(<8 x i32>)

declare i64 @llvm.vector.reduce.smax.v2i64(<2 x i64>)
declare i64 @llvm.vector.reduce.smax.v4i64(<4 x i64>)

declare i8 @llvm.vector.reduce.smin.v8i8(<8 x i8>)
declare i8 @llvm.vector.reduce.smin.v16i8(<16 x i8>)
declare i8 @llvm.vector.reduce.smin.v32i8(<32 x i8>)

declare i16 @llvm.vector.reduce.smin.v4i16(<4 x i16>)
declare i16 @llvm.vector.reduce.smin.v8i16(<8 x i16>)
declare i16 @llvm.vector.reduce.smin.v16i16(<16 x i16>)

declare i32 @llvm.vector.reduce.smin.v2i32(<2 x i32>)
declare i32 @llvm.vector.reduce.smin.v4i32(<4 x i32>)
declare i32 @llvm.vector.reduce.smin.v8i32(<8 x i32>)

declare i64 @llvm.vector.reduce.smin.v2i64(<2 x i64>)
declare i64 @llvm.vector.reduce.smin.v4i64(<4 x i64>)

declare i8 @llvm.vector.reduce.umax.v8i8(<8 x i8>)
declare i8 @llvm.vector.reduce.umax.v16i8(<16 x i8>)
declare i8 @llvm.vector.reduce.umax.v32i8(<32 x i8>)

declare i16 @llvm.vector.reduce.umax.v4i16(<4 x i16>)
declare i16 @llvm.vector.reduce.umax.v8i16(<8 x i16>)
declare i16 @llvm.vector.reduce.umax.v16i16(<16 x i16>)

declare i32 @llvm.vector.reduce.umax.v2i32(<2 x i32>)
declare i32 @llvm.vector.reduce.umax.v4i32(<4 x i32>)
declare i32 @llvm.vector.reduce.umax.v8i32(<8 x i32>)

declare i64 @llvm.vector.reduce.umax.v2i64(<2 x i64>)
declare i64 @llvm.vector.reduce.umax.v4i64(<4 x i64>)

declare i8 @llvm.vector.reduce.umin.v8i8(<8 x i8>)
declare i8 @llvm.vector.reduce.umin.v16i8(<16 x i8>)
declare i8 @llvm.vector.reduce.umin.v32i8(<32 x i8>)

declare i16 @llvm.vector.reduce.umin.v4i16(<4 x i16>)
declare i16 @llvm.vector.reduce.umin.v8i16(<8 x i16>)
declare i16 @llvm.vector.reduce.umin.v16i16(<16 x i16>)

declare i32 @llvm.vector.reduce.umin.v2i32(<2 x i32>)
declare i32 @llvm.vector.reduce.umin.v4i32(<4 x i32>)
declare i32 @llvm.vector.reduce.umin.v8i32(<8 x i32>)

declare i64 @llvm.vector.reduce.umin.v2i64(<2 x i64>)
declare i64 @llvm.vector.reduce.umin.v4i64(<4 x i64>)
