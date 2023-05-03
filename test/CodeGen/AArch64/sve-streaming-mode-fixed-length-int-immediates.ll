; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -force-streaming-compatible-sve < %s | FileCheck %s

target triple = "aarch64-unknown-linux-gnu"

; Although SVE immediate packing should be fully tested using scalable vectors,
; these tests protects against the possibility that scalable nodes, resulting
; from lowering fixed length vector operations, trigger different isel patterns.

; FIXME: These instructions should have the immediate form

;
; ADD
;

define void @add_v32i8(ptr %a) #0 {
; CHECK-LABEL: add_v32i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldp q0, q1, [x0]
; CHECK-NEXT:    add z0.b, z0.b, #7 // =0x7
; CHECK-NEXT:    add z1.b, z1.b, #7 // =0x7
; CHECK-NEXT:    stp q0, q1, [x0]
; CHECK-NEXT:    ret
  %op1 = load <32 x i8>, ptr %a
  %ins = insertelement <32 x i8> undef, i8 7, i32 0
  %op2 = shufflevector <32 x i8> %ins, <32 x i8> undef, <32 x i32> zeroinitializer
  %res = add <32 x i8> %op1, %op2
  store <32 x i8> %res, ptr %a
  ret void
}

define void @add_v16i16(ptr %a) #0 {
; CHECK-LABEL: add_v16i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldp q0, q1, [x0]
; CHECK-NEXT:    add z0.h, z0.h, #15 // =0xf
; CHECK-NEXT:    add z1.h, z1.h, #15 // =0xf
; CHECK-NEXT:    stp q0, q1, [x0]
; CHECK-NEXT:    ret
  %op1 = load <16 x i16>, ptr %a
  %ins = insertelement <16 x i16> undef, i16 15, i64 0
  %op2 = shufflevector <16 x i16> %ins, <16 x i16> undef, <16 x i32> zeroinitializer
  %res = add <16 x i16> %op1, %op2
  store <16 x i16> %res, ptr %a
  ret void
}

define void @add_v8i32(ptr %a) #0 {
; CHECK-LABEL: add_v8i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldp q0, q1, [x0]
; CHECK-NEXT:    add z0.s, z0.s, #31 // =0x1f
; CHECK-NEXT:    add z1.s, z1.s, #31 // =0x1f
; CHECK-NEXT:    stp q0, q1, [x0]
; CHECK-NEXT:    ret
  %op1 = load <8 x i32>, ptr %a
  %ins = insertelement <8 x i32> undef, i32 31, i64 0
  %op2 = shufflevector <8 x i32> %ins, <8 x i32> undef, <8 x i32> zeroinitializer
  %res = add <8 x i32> %op1, %op2
  store <8 x i32> %res, ptr %a
  ret void
}

define void @add_v4i64(ptr %a) #0 {
; CHECK-LABEL: add_v4i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldp q0, q1, [x0]
; CHECK-NEXT:    add z0.d, z0.d, #63 // =0x3f
; CHECK-NEXT:    add z1.d, z1.d, #63 // =0x3f
; CHECK-NEXT:    stp q0, q1, [x0]
; CHECK-NEXT:    ret
  %op1 = load <4 x i64>, ptr %a
  %ins = insertelement <4 x i64> undef, i64 63, i64 0
  %op2 = shufflevector <4 x i64> %ins, <4 x i64> undef, <4 x i32> zeroinitializer
  %res = add <4 x i64> %op1, %op2
  store <4 x i64> %res, ptr %a
  ret void
}

;
; AND
;

define void @and_v32i8(ptr %a) #0 {
; CHECK-LABEL: and_v32i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldp q0, q1, [x0]
; CHECK-NEXT:    and z0.b, z0.b, #0x7
; CHECK-NEXT:    and z1.b, z1.b, #0x7
; CHECK-NEXT:    stp q0, q1, [x0]
; CHECK-NEXT:    ret
  %op1 = load <32 x i8>, ptr %a
  %ins = insertelement <32 x i8> undef, i8 7, i32 0
  %op2 = shufflevector <32 x i8> %ins, <32 x i8> undef, <32 x i32> zeroinitializer
  %res = and <32 x i8> %op1, %op2
  store <32 x i8> %res, ptr %a
  ret void
}

define void @and_v16i16(ptr %a) #0 {
; CHECK-LABEL: and_v16i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldp q0, q1, [x0]
; CHECK-NEXT:    and z0.h, z0.h, #0xf
; CHECK-NEXT:    and z1.h, z1.h, #0xf
; CHECK-NEXT:    stp q0, q1, [x0]
; CHECK-NEXT:    ret
  %op1 = load <16 x i16>, ptr %a
  %ins = insertelement <16 x i16> undef, i16 15, i64 0
  %op2 = shufflevector <16 x i16> %ins, <16 x i16> undef, <16 x i32> zeroinitializer
  %res = and <16 x i16> %op1, %op2
  store <16 x i16> %res, ptr %a
  ret void
}

define void @and_v8i32(ptr %a) #0 {
; CHECK-LABEL: and_v8i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldp q0, q1, [x0]
; CHECK-NEXT:    and z0.s, z0.s, #0x1f
; CHECK-NEXT:    and z1.s, z1.s, #0x1f
; CHECK-NEXT:    stp q0, q1, [x0]
; CHECK-NEXT:    ret
  %op1 = load <8 x i32>, ptr %a
  %ins = insertelement <8 x i32> undef, i32 31, i64 0
  %op2 = shufflevector <8 x i32> %ins, <8 x i32> undef, <8 x i32> zeroinitializer
  %res = and <8 x i32> %op1, %op2
  store <8 x i32> %res, ptr %a
  ret void
}

define void @and_v4i64(ptr %a) #0 {
; CHECK-LABEL: and_v4i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldp q0, q1, [x0]
; CHECK-NEXT:    and z0.d, z0.d, #0x3f
; CHECK-NEXT:    and z1.d, z1.d, #0x3f
; CHECK-NEXT:    stp q0, q1, [x0]
; CHECK-NEXT:    ret
  %op1 = load <4 x i64>, ptr %a
  %ins = insertelement <4 x i64> undef, i64 63, i64 0
  %op2 = shufflevector <4 x i64> %ins, <4 x i64> undef, <4 x i32> zeroinitializer
  %res = and <4 x i64> %op1, %op2
  store <4 x i64> %res, ptr %a
  ret void
}

;
; ASHR
;

define void @ashr_v32i8(ptr %a) #0 {
; CHECK-LABEL: ashr_v32i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldp q0, q1, [x0]
; CHECK-NEXT:    ptrue p0.b, vl16
; CHECK-NEXT:    asr z0.b, p0/m, z0.b, #7
; CHECK-NEXT:    asr z1.b, p0/m, z1.b, #7
; CHECK-NEXT:    stp q0, q1, [x0]
; CHECK-NEXT:    ret
  %op1 = load <32 x i8>, ptr %a
  %ins = insertelement <32 x i8> undef, i8 7, i32 0
  %op2 = shufflevector <32 x i8> %ins, <32 x i8> undef, <32 x i32> zeroinitializer
  %res = ashr <32 x i8> %op1, %op2
  store <32 x i8> %res, ptr %a
  ret void
}

define void @ashr_v16i16(ptr %a) #0 {
; CHECK-LABEL: ashr_v16i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldp q0, q1, [x0]
; CHECK-NEXT:    ptrue p0.h, vl8
; CHECK-NEXT:    asr z0.h, p0/m, z0.h, #15
; CHECK-NEXT:    asr z1.h, p0/m, z1.h, #15
; CHECK-NEXT:    stp q0, q1, [x0]
; CHECK-NEXT:    ret
  %op1 = load <16 x i16>, ptr %a
  %ins = insertelement <16 x i16> undef, i16 15, i64 0
  %op2 = shufflevector <16 x i16> %ins, <16 x i16> undef, <16 x i32> zeroinitializer
  %res = ashr <16 x i16> %op1, %op2
  store <16 x i16> %res, ptr %a
  ret void
}

define void @ashr_v8i32(ptr %a) #0 {
; CHECK-LABEL: ashr_v8i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldp q0, q1, [x0]
; CHECK-NEXT:    ptrue p0.s, vl4
; CHECK-NEXT:    asr z0.s, p0/m, z0.s, #31
; CHECK-NEXT:    asr z1.s, p0/m, z1.s, #31
; CHECK-NEXT:    stp q0, q1, [x0]
; CHECK-NEXT:    ret
  %op1 = load <8 x i32>, ptr %a
  %ins = insertelement <8 x i32> undef, i32 31, i64 0
  %op2 = shufflevector <8 x i32> %ins, <8 x i32> undef, <8 x i32> zeroinitializer
  %res = ashr <8 x i32> %op1, %op2
  store <8 x i32> %res, ptr %a
  ret void
}

define void @ashr_v4i64(ptr %a) #0 {
; CHECK-LABEL: ashr_v4i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldp q0, q1, [x0]
; CHECK-NEXT:    ptrue p0.d, vl2
; CHECK-NEXT:    asr z0.d, p0/m, z0.d, #63
; CHECK-NEXT:    asr z1.d, p0/m, z1.d, #63
; CHECK-NEXT:    stp q0, q1, [x0]
; CHECK-NEXT:    ret
  %op1 = load <4 x i64>, ptr %a
  %ins = insertelement <4 x i64> undef, i64 63, i64 0
  %op2 = shufflevector <4 x i64> %ins, <4 x i64> undef, <4 x i32> zeroinitializer
  %res = ashr <4 x i64> %op1, %op2
  store <4 x i64> %res, ptr %a
  ret void
}

;
; ICMP
;

define void @icmp_eq_v32i8(ptr %a) #0 {
; CHECK-LABEL: icmp_eq_v32i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldp q0, q1, [x0]
; CHECK-NEXT:    ptrue p0.b, vl16
; CHECK-NEXT:    cmpeq p1.b, p0/z, z0.b, #7
; CHECK-NEXT:    mov z0.b, p1/z, #-1 // =0xffffffffffffffff
; CHECK-NEXT:    cmpeq p0.b, p0/z, z1.b, #7
; CHECK-NEXT:    mov z1.b, p0/z, #-1 // =0xffffffffffffffff
; CHECK-NEXT:    stp q0, q1, [x0]
; CHECK-NEXT:    ret
  %op1 = load <32 x i8>, ptr %a
  %ins = insertelement <32 x i8> undef, i8 7, i64 0
  %op2 = shufflevector <32 x i8> %ins, <32 x i8> undef, <32 x i32> zeroinitializer
  %cmp = icmp eq <32 x i8> %op1, %op2
  %res = sext <32 x i1> %cmp to <32 x i8>
  store <32 x i8> %res, ptr %a
  ret void
}

define void @icmp_sge_v16i16(ptr %a) #0 {
; CHECK-LABEL: icmp_sge_v16i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldp q0, q1, [x0]
; CHECK-NEXT:    ptrue p0.h, vl8
; CHECK-NEXT:    cmpge p1.h, p0/z, z0.h, #15
; CHECK-NEXT:    mov z0.h, p1/z, #-1 // =0xffffffffffffffff
; CHECK-NEXT:    cmpge p0.h, p0/z, z1.h, #15
; CHECK-NEXT:    mov z1.h, p0/z, #-1 // =0xffffffffffffffff
; CHECK-NEXT:    stp q0, q1, [x0]
; CHECK-NEXT:    ret
  %op1 = load <16 x i16>, ptr %a
  %ins = insertelement <16 x i16> undef, i16 15, i64 0
  %op2 = shufflevector <16 x i16> %ins, <16 x i16> undef, <16 x i32> zeroinitializer
  %cmp = icmp sge <16 x i16> %op1, %op2
  %res = sext <16 x i1> %cmp to <16 x i16>
  store <16 x i16> %res, ptr %a
  ret void
}

define void @icmp_sgt_v8i32(ptr %a) #0 {
; CHECK-LABEL: icmp_sgt_v8i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldp q0, q1, [x0]
; CHECK-NEXT:    ptrue p0.s, vl4
; CHECK-NEXT:    cmpgt p1.s, p0/z, z0.s, #-8
; CHECK-NEXT:    mov z0.s, p1/z, #-1 // =0xffffffffffffffff
; CHECK-NEXT:    cmpgt p0.s, p0/z, z1.s, #-8
; CHECK-NEXT:    mov z1.s, p0/z, #-1 // =0xffffffffffffffff
; CHECK-NEXT:    stp q0, q1, [x0]
; CHECK-NEXT:    ret
  %op1 = load <8 x i32>, ptr %a
  %ins = insertelement <8 x i32> undef, i32 -8, i64 0
  %op2 = shufflevector <8 x i32> %ins, <8 x i32> undef, <8 x i32> zeroinitializer
  %cmp = icmp sgt <8 x i32> %op1, %op2
  %res = sext <8 x i1> %cmp to <8 x i32>
  store <8 x i32> %res, ptr %a
  ret void
}

define void @icmp_ult_v4i64(ptr %a) #0 {
; CHECK-LABEL: icmp_ult_v4i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldp q0, q1, [x0]
; CHECK-NEXT:    ptrue p0.d, vl2
; CHECK-NEXT:    cmplo p1.d, p0/z, z0.d, #63
; CHECK-NEXT:    mov z0.d, p1/z, #-1 // =0xffffffffffffffff
; CHECK-NEXT:    cmplo p0.d, p0/z, z1.d, #63
; CHECK-NEXT:    mov z1.d, p0/z, #-1 // =0xffffffffffffffff
; CHECK-NEXT:    stp q0, q1, [x0]
; CHECK-NEXT:    ret
  %op1 = load <4 x i64>, ptr %a
  %ins = insertelement <4 x i64> undef, i64 63, i64 0
  %op2 = shufflevector <4 x i64> %ins, <4 x i64> undef, <4 x i32> zeroinitializer
  %cmp = icmp ult <4 x i64> %op1, %op2
  %res = sext <4 x i1> %cmp to <4 x i64>
  store <4 x i64> %res, ptr %a
  ret void
}

;
; LSHR
;

define void @lshr_v32i8(ptr %a) #0 {
; CHECK-LABEL: lshr_v32i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldp q0, q1, [x0]
; CHECK-NEXT:    ptrue p0.b, vl16
; CHECK-NEXT:    lsr z0.b, p0/m, z0.b, #7
; CHECK-NEXT:    lsr z1.b, p0/m, z1.b, #7
; CHECK-NEXT:    stp q0, q1, [x0]
; CHECK-NEXT:    ret
  %op1 = load <32 x i8>, ptr %a
  %ins = insertelement <32 x i8> undef, i8 7, i64 0
  %op2 = shufflevector <32 x i8> %ins, <32 x i8> undef, <32 x i32> zeroinitializer
  %res = lshr <32 x i8> %op1, %op2
  store <32 x i8> %res, ptr %a
  ret void
}

define void @lshr_v16i16(ptr %a) #0 {
; CHECK-LABEL: lshr_v16i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldp q0, q1, [x0]
; CHECK-NEXT:    ptrue p0.h, vl8
; CHECK-NEXT:    lsr z0.h, p0/m, z0.h, #15
; CHECK-NEXT:    lsr z1.h, p0/m, z1.h, #15
; CHECK-NEXT:    stp q0, q1, [x0]
; CHECK-NEXT:    ret
  %op1 = load <16 x i16>, ptr %a
  %ins = insertelement <16 x i16> undef, i16 15, i64 0
  %op2 = shufflevector <16 x i16> %ins, <16 x i16> undef, <16 x i32> zeroinitializer
  %res = lshr <16 x i16> %op1, %op2
  store <16 x i16> %res, ptr %a
  ret void
}

define void @lshr_v8i32(ptr %a) #0 {
; CHECK-LABEL: lshr_v8i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldp q0, q1, [x0]
; CHECK-NEXT:    ptrue p0.s, vl4
; CHECK-NEXT:    lsr z0.s, p0/m, z0.s, #31
; CHECK-NEXT:    lsr z1.s, p0/m, z1.s, #31
; CHECK-NEXT:    stp q0, q1, [x0]
; CHECK-NEXT:    ret
  %op1 = load <8 x i32>, ptr %a
  %ins = insertelement <8 x i32> undef, i32 31, i64 0
  %op2 = shufflevector <8 x i32> %ins, <8 x i32> undef, <8 x i32> zeroinitializer
  %res = lshr <8 x i32> %op1, %op2
  store <8 x i32> %res, ptr %a
  ret void
}

define void @lshr_v4i64(ptr %a) #0 {
; CHECK-LABEL: lshr_v4i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldp q0, q1, [x0]
; CHECK-NEXT:    ptrue p0.d, vl2
; CHECK-NEXT:    lsr z0.d, p0/m, z0.d, #63
; CHECK-NEXT:    lsr z1.d, p0/m, z1.d, #63
; CHECK-NEXT:    stp q0, q1, [x0]
; CHECK-NEXT:    ret
  %op1 = load <4 x i64>, ptr %a
  %ins = insertelement <4 x i64> undef, i64 63, i64 0
  %op2 = shufflevector <4 x i64> %ins, <4 x i64> undef, <4 x i32> zeroinitializer
  %res = lshr <4 x i64> %op1, %op2
  store <4 x i64> %res, ptr %a
  ret void
}

;
; MUL
;

define void @mul_v32i8(ptr %a) #0 {
; CHECK-LABEL: mul_v32i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldp q0, q1, [x0]
; CHECK-NEXT:    mov z2.b, #7 // =0x7
; CHECK-NEXT:    ptrue p0.b, vl16
; CHECK-NEXT:    mul z0.b, p0/m, z0.b, z2.b
; CHECK-NEXT:    mul z1.b, p0/m, z1.b, z2.b
; CHECK-NEXT:    stp q0, q1, [x0]
; CHECK-NEXT:    ret
  %op1 = load <32 x i8>, ptr %a
  %ins = insertelement <32 x i8> undef, i8 7, i64 0
  %op2 = shufflevector <32 x i8> %ins, <32 x i8> undef, <32 x i32> zeroinitializer
  %res = mul <32 x i8> %op1, %op2
  store <32 x i8> %res, ptr %a
  ret void
}

define void @mul_v16i16(ptr %a) #0 {
; CHECK-LABEL: mul_v16i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldp q0, q1, [x0]
; CHECK-NEXT:    mov z2.h, #15 // =0xf
; CHECK-NEXT:    ptrue p0.h, vl8
; CHECK-NEXT:    mul z0.h, p0/m, z0.h, z2.h
; CHECK-NEXT:    mul z1.h, p0/m, z1.h, z2.h
; CHECK-NEXT:    stp q0, q1, [x0]
; CHECK-NEXT:    ret
  %op1 = load <16 x i16>, ptr %a
  %ins = insertelement <16 x i16> undef, i16 15, i64 0
  %op2 = shufflevector <16 x i16> %ins, <16 x i16> undef, <16 x i32> zeroinitializer
  %res = mul <16 x i16> %op1, %op2
  store <16 x i16> %res, ptr %a
  ret void
}

define void @mul_v8i32(ptr %a) #0 {
; CHECK-LABEL: mul_v8i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldp q0, q1, [x0]
; CHECK-NEXT:    mov z2.s, #31 // =0x1f
; CHECK-NEXT:    ptrue p0.s, vl4
; CHECK-NEXT:    mul z0.s, p0/m, z0.s, z2.s
; CHECK-NEXT:    mul z1.s, p0/m, z1.s, z2.s
; CHECK-NEXT:    stp q0, q1, [x0]
; CHECK-NEXT:    ret
  %op1 = load <8 x i32>, ptr %a
  %ins = insertelement <8 x i32> undef, i32 31, i64 0
  %op2 = shufflevector <8 x i32> %ins, <8 x i32> undef, <8 x i32> zeroinitializer
  %res = mul <8 x i32> %op1, %op2
  store <8 x i32> %res, ptr %a
  ret void
}

define void @mul_v4i64(ptr %a) #0 {
; CHECK-LABEL: mul_v4i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldp q0, q1, [x0]
; CHECK-NEXT:    mov z2.d, #63 // =0x3f
; CHECK-NEXT:    ptrue p0.d, vl2
; CHECK-NEXT:    mul z0.d, p0/m, z0.d, z2.d
; CHECK-NEXT:    mul z1.d, p0/m, z1.d, z2.d
; CHECK-NEXT:    stp q0, q1, [x0]
; CHECK-NEXT:    ret
  %op1 = load <4 x i64>, ptr %a
  %ins = insertelement <4 x i64> undef, i64 63, i64 0
  %op2 = shufflevector <4 x i64> %ins, <4 x i64> undef, <4 x i32> zeroinitializer
  %res = mul <4 x i64> %op1, %op2
  store <4 x i64> %res, ptr %a
  ret void
}

;
; OR
;

define void @or_v32i8(ptr %a) #0 {
; CHECK-LABEL: or_v32i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldp q0, q1, [x0]
; CHECK-NEXT:    orr z0.b, z0.b, #0x7
; CHECK-NEXT:    orr z1.b, z1.b, #0x7
; CHECK-NEXT:    stp q0, q1, [x0]
; CHECK-NEXT:    ret
  %op1 = load <32 x i8>, ptr %a
  %ins = insertelement <32 x i8> undef, i8 7, i64 0
  %op2 = shufflevector <32 x i8> %ins, <32 x i8> undef, <32 x i32> zeroinitializer
  %res = or <32 x i8> %op1, %op2
  store <32 x i8> %res, ptr %a
  ret void
}

define void @or_v16i16(ptr %a) #0 {
; CHECK-LABEL: or_v16i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldp q0, q1, [x0]
; CHECK-NEXT:    orr z0.h, z0.h, #0xf
; CHECK-NEXT:    orr z1.h, z1.h, #0xf
; CHECK-NEXT:    stp q0, q1, [x0]
; CHECK-NEXT:    ret
  %op1 = load <16 x i16>, ptr %a
  %ins = insertelement <16 x i16> undef, i16 15, i64 0
  %op2 = shufflevector <16 x i16> %ins, <16 x i16> undef, <16 x i32> zeroinitializer
  %res = or <16 x i16> %op1, %op2
  store <16 x i16> %res, ptr %a
  ret void
}

define void @or_v8i32(ptr %a) #0 {
; CHECK-LABEL: or_v8i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldp q0, q1, [x0]
; CHECK-NEXT:    orr z0.s, z0.s, #0x1f
; CHECK-NEXT:    orr z1.s, z1.s, #0x1f
; CHECK-NEXT:    stp q0, q1, [x0]
; CHECK-NEXT:    ret
  %op1 = load <8 x i32>, ptr %a
  %ins = insertelement <8 x i32> undef, i32 31, i64 0
  %op2 = shufflevector <8 x i32> %ins, <8 x i32> undef, <8 x i32> zeroinitializer
  %res = or <8 x i32> %op1, %op2
  store <8 x i32> %res, ptr %a
  ret void
}

define void @or_v4i64(ptr %a) #0 {
; CHECK-LABEL: or_v4i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldp q0, q1, [x0]
; CHECK-NEXT:    orr z0.d, z0.d, #0x3f
; CHECK-NEXT:    orr z1.d, z1.d, #0x3f
; CHECK-NEXT:    stp q0, q1, [x0]
; CHECK-NEXT:    ret
  %op1 = load <4 x i64>, ptr %a
  %ins = insertelement <4 x i64> undef, i64 63, i64 0
  %op2 = shufflevector <4 x i64> %ins, <4 x i64> undef, <4 x i32> zeroinitializer
  %res = or <4 x i64> %op1, %op2
  store <4 x i64> %res, ptr %a
  ret void
}

;
; SHL
;

define void @shl_v32i8(ptr %a) #0 {
; CHECK-LABEL: shl_v32i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldp q0, q1, [x0]
; CHECK-NEXT:    ptrue p0.b, vl16
; CHECK-NEXT:    lsl z0.b, p0/m, z0.b, #7
; CHECK-NEXT:    lsl z1.b, p0/m, z1.b, #7
; CHECK-NEXT:    stp q0, q1, [x0]
; CHECK-NEXT:    ret
  %op1 = load <32 x i8>, ptr %a
  %ins = insertelement <32 x i8> undef, i8 7, i64 0
  %op2 = shufflevector <32 x i8> %ins, <32 x i8> undef, <32 x i32> zeroinitializer
  %res = shl <32 x i8> %op1, %op2
  store <32 x i8> %res, ptr %a
  ret void
}

define void @shl_v16i16(ptr %a) #0 {
; CHECK-LABEL: shl_v16i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldp q0, q1, [x0]
; CHECK-NEXT:    ptrue p0.h, vl8
; CHECK-NEXT:    lsl z0.h, p0/m, z0.h, #15
; CHECK-NEXT:    lsl z1.h, p0/m, z1.h, #15
; CHECK-NEXT:    stp q0, q1, [x0]
; CHECK-NEXT:    ret
  %op1 = load <16 x i16>, ptr %a
  %ins = insertelement <16 x i16> undef, i16 15, i64 0
  %op2 = shufflevector <16 x i16> %ins, <16 x i16> undef, <16 x i32> zeroinitializer
  %res = shl <16 x i16> %op1, %op2
  store <16 x i16> %res, ptr %a
  ret void
}

define void @shl_v8i32(ptr %a) #0 {
; CHECK-LABEL: shl_v8i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldp q0, q1, [x0]
; CHECK-NEXT:    ptrue p0.s, vl4
; CHECK-NEXT:    lsl z0.s, p0/m, z0.s, #31
; CHECK-NEXT:    lsl z1.s, p0/m, z1.s, #31
; CHECK-NEXT:    stp q0, q1, [x0]
; CHECK-NEXT:    ret
  %op1 = load <8 x i32>, ptr %a
  %ins = insertelement <8 x i32> undef, i32 31, i64 0
  %op2 = shufflevector <8 x i32> %ins, <8 x i32> undef, <8 x i32> zeroinitializer
  %res = shl <8 x i32> %op1, %op2
  store <8 x i32> %res, ptr %a
  ret void
}

define void @shl_v4i64(ptr %a) #0 {
; CHECK-LABEL: shl_v4i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldp q0, q1, [x0]
; CHECK-NEXT:    ptrue p0.d, vl2
; CHECK-NEXT:    lsl z0.d, p0/m, z0.d, #63
; CHECK-NEXT:    lsl z1.d, p0/m, z1.d, #63
; CHECK-NEXT:    stp q0, q1, [x0]
; CHECK-NEXT:    ret
  %op1 = load <4 x i64>, ptr %a
  %ins = insertelement <4 x i64> undef, i64 63, i64 0
  %op2 = shufflevector <4 x i64> %ins, <4 x i64> undef, <4 x i32> zeroinitializer
  %res = shl <4 x i64> %op1, %op2
  store <4 x i64> %res, ptr %a
  ret void
}

;
; SMAX
;

define void @smax_v32i8(ptr %a) #0 {
; CHECK-LABEL: smax_v32i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldp q0, q1, [x0]
; CHECK-NEXT:    mov z2.b, #7 // =0x7
; CHECK-NEXT:    ptrue p0.b, vl16
; CHECK-NEXT:    smax z0.b, p0/m, z0.b, z2.b
; CHECK-NEXT:    smax z1.b, p0/m, z1.b, z2.b
; CHECK-NEXT:    stp q0, q1, [x0]
; CHECK-NEXT:    ret
  %op1 = load <32 x i8>, ptr %a
  %ins = insertelement <32 x i8> undef, i8 7, i64 0
  %op2 = shufflevector <32 x i8> %ins, <32 x i8> undef, <32 x i32> zeroinitializer
  %res = call <32 x i8> @llvm.smax.v32i8(<32 x i8> %op1, <32 x i8> %op2)
  store <32 x i8> %res, ptr %a
  ret void
}

define void @smax_v16i16(ptr %a) #0 {
; CHECK-LABEL: smax_v16i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldp q0, q1, [x0]
; CHECK-NEXT:    mov z2.h, #15 // =0xf
; CHECK-NEXT:    ptrue p0.h, vl8
; CHECK-NEXT:    smax z0.h, p0/m, z0.h, z2.h
; CHECK-NEXT:    smax z1.h, p0/m, z1.h, z2.h
; CHECK-NEXT:    stp q0, q1, [x0]
; CHECK-NEXT:    ret
  %op1 = load <16 x i16>, ptr %a
  %ins = insertelement <16 x i16> undef, i16 15, i64 0
  %op2 = shufflevector <16 x i16> %ins, <16 x i16> undef, <16 x i32> zeroinitializer
  %res = call <16 x i16> @llvm.smax.v16i16(<16 x i16> %op1, <16 x i16> %op2)
  store <16 x i16> %res, ptr %a
  ret void
}

define void @smax_v8i32(ptr %a) #0 {
; CHECK-LABEL: smax_v8i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldp q0, q1, [x0]
; CHECK-NEXT:    mov z2.s, #31 // =0x1f
; CHECK-NEXT:    ptrue p0.s, vl4
; CHECK-NEXT:    smax z0.s, p0/m, z0.s, z2.s
; CHECK-NEXT:    smax z1.s, p0/m, z1.s, z2.s
; CHECK-NEXT:    stp q0, q1, [x0]
; CHECK-NEXT:    ret
  %op1 = load <8 x i32>, ptr %a
  %ins = insertelement <8 x i32> undef, i32 31, i64 0
  %op2 = shufflevector <8 x i32> %ins, <8 x i32> undef, <8 x i32> zeroinitializer
  %res = call <8 x i32> @llvm.smax.v8i32(<8 x i32> %op1, <8 x i32> %op2)
  store <8 x i32> %res, ptr %a
  ret void
}

define void @smax_v4i64(ptr %a) #0 {
; CHECK-LABEL: smax_v4i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldp q0, q1, [x0]
; CHECK-NEXT:    mov z2.d, #63 // =0x3f
; CHECK-NEXT:    ptrue p0.d, vl2
; CHECK-NEXT:    smax z0.d, p0/m, z0.d, z2.d
; CHECK-NEXT:    smax z1.d, p0/m, z1.d, z2.d
; CHECK-NEXT:    stp q0, q1, [x0]
; CHECK-NEXT:    ret
  %op1 = load <4 x i64>, ptr %a
  %ins = insertelement <4 x i64> undef, i64 63, i64 0
  %op2 = shufflevector <4 x i64> %ins, <4 x i64> undef, <4 x i32> zeroinitializer
  %res = call <4 x i64> @llvm.smax.v4i64(<4 x i64> %op1, <4 x i64> %op2)
  store <4 x i64> %res, ptr %a
  ret void
}

;
; SMIN
;

define void @smin_v32i8(ptr %a) #0 {
; CHECK-LABEL: smin_v32i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldp q0, q1, [x0]
; CHECK-NEXT:    mov z2.b, #7 // =0x7
; CHECK-NEXT:    ptrue p0.b, vl16
; CHECK-NEXT:    smin z0.b, p0/m, z0.b, z2.b
; CHECK-NEXT:    smin z1.b, p0/m, z1.b, z2.b
; CHECK-NEXT:    stp q0, q1, [x0]
; CHECK-NEXT:    ret
  %op1 = load <32 x i8>, ptr %a
  %ins = insertelement <32 x i8> undef, i8 7, i64 0
  %op2 = shufflevector <32 x i8> %ins, <32 x i8> undef, <32 x i32> zeroinitializer
  %res = call <32 x i8> @llvm.smin.v32i8(<32 x i8> %op1, <32 x i8> %op2)
  store <32 x i8> %res, ptr %a
  ret void
}

define void @smin_v16i16(ptr %a) #0 {
; CHECK-LABEL: smin_v16i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldp q0, q1, [x0]
; CHECK-NEXT:    mov z2.h, #15 // =0xf
; CHECK-NEXT:    ptrue p0.h, vl8
; CHECK-NEXT:    smin z0.h, p0/m, z0.h, z2.h
; CHECK-NEXT:    smin z1.h, p0/m, z1.h, z2.h
; CHECK-NEXT:    stp q0, q1, [x0]
; CHECK-NEXT:    ret
  %op1 = load <16 x i16>, ptr %a
  %ins = insertelement <16 x i16> undef, i16 15, i64 0
  %op2 = shufflevector <16 x i16> %ins, <16 x i16> undef, <16 x i32> zeroinitializer
  %res = call <16 x i16> @llvm.smin.v16i16(<16 x i16> %op1, <16 x i16> %op2)
  store <16 x i16> %res, ptr %a
  ret void
}

define void @smin_v8i32(ptr %a) #0 {
; CHECK-LABEL: smin_v8i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldp q0, q1, [x0]
; CHECK-NEXT:    mov z2.s, #31 // =0x1f
; CHECK-NEXT:    ptrue p0.s, vl4
; CHECK-NEXT:    smin z0.s, p0/m, z0.s, z2.s
; CHECK-NEXT:    smin z1.s, p0/m, z1.s, z2.s
; CHECK-NEXT:    stp q0, q1, [x0]
; CHECK-NEXT:    ret
  %op1 = load <8 x i32>, ptr %a
  %ins = insertelement <8 x i32> undef, i32 31, i64 0
  %op2 = shufflevector <8 x i32> %ins, <8 x i32> undef, <8 x i32> zeroinitializer
  %res = call <8 x i32> @llvm.smin.v8i32(<8 x i32> %op1, <8 x i32> %op2)
  store <8 x i32> %res, ptr %a
  ret void
}

define void @smin_v4i64(ptr %a) #0 {
; CHECK-LABEL: smin_v4i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldp q0, q1, [x0]
; CHECK-NEXT:    mov z2.d, #63 // =0x3f
; CHECK-NEXT:    ptrue p0.d, vl2
; CHECK-NEXT:    smin z0.d, p0/m, z0.d, z2.d
; CHECK-NEXT:    smin z1.d, p0/m, z1.d, z2.d
; CHECK-NEXT:    stp q0, q1, [x0]
; CHECK-NEXT:    ret
  %op1 = load <4 x i64>, ptr %a
  %ins = insertelement <4 x i64> undef, i64 63, i64 0
  %op2 = shufflevector <4 x i64> %ins, <4 x i64> undef, <4 x i32> zeroinitializer
  %res = call <4 x i64> @llvm.smin.v4i64(<4 x i64> %op1, <4 x i64> %op2)
  store <4 x i64> %res, ptr %a
  ret void
}

;
; SUB
;

define void @sub_v32i8(ptr %a) #0 {
; CHECK-LABEL: sub_v32i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldp q0, q1, [x0]
; CHECK-NEXT:    sub z0.b, z0.b, #7 // =0x7
; CHECK-NEXT:    sub z1.b, z1.b, #7 // =0x7
; CHECK-NEXT:    stp q0, q1, [x0]
; CHECK-NEXT:    ret
  %op1 = load <32 x i8>, ptr %a
  %ins = insertelement <32 x i8> undef, i8 7, i64 0
  %op2 = shufflevector <32 x i8> %ins, <32 x i8> undef, <32 x i32> zeroinitializer
  %res = sub <32 x i8> %op1, %op2
  store <32 x i8> %res, ptr %a
  ret void
}

define void @sub_v16i16(ptr %a) #0 {
; CHECK-LABEL: sub_v16i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldp q0, q1, [x0]
; CHECK-NEXT:    sub z0.h, z0.h, #15 // =0xf
; CHECK-NEXT:    sub z1.h, z1.h, #15 // =0xf
; CHECK-NEXT:    stp q0, q1, [x0]
; CHECK-NEXT:    ret
  %op1 = load <16 x i16>, ptr %a
  %ins = insertelement <16 x i16> undef, i16 15, i64 0
  %op2 = shufflevector <16 x i16> %ins, <16 x i16> undef, <16 x i32> zeroinitializer
  %res = sub <16 x i16> %op1, %op2
  store <16 x i16> %res, ptr %a
  ret void
}

define void @sub_v8i32(ptr %a) #0 {
; CHECK-LABEL: sub_v8i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldp q0, q1, [x0]
; CHECK-NEXT:    sub z0.s, z0.s, #31 // =0x1f
; CHECK-NEXT:    sub z1.s, z1.s, #31 // =0x1f
; CHECK-NEXT:    stp q0, q1, [x0]
; CHECK-NEXT:    ret
  %op1 = load <8 x i32>, ptr %a
  %ins = insertelement <8 x i32> undef, i32 31, i64 0
  %op2 = shufflevector <8 x i32> %ins, <8 x i32> undef, <8 x i32> zeroinitializer
  %res = sub <8 x i32> %op1, %op2
  store <8 x i32> %res, ptr %a
  ret void
}

define void @sub_v4i64(ptr %a) #0 {
; CHECK-LABEL: sub_v4i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldp q0, q1, [x0]
; CHECK-NEXT:    sub z0.d, z0.d, #63 // =0x3f
; CHECK-NEXT:    sub z1.d, z1.d, #63 // =0x3f
; CHECK-NEXT:    stp q0, q1, [x0]
; CHECK-NEXT:    ret
  %op1 = load <4 x i64>, ptr %a
  %ins = insertelement <4 x i64> undef, i64 63, i64 0
  %op2 = shufflevector <4 x i64> %ins, <4 x i64> undef, <4 x i32> zeroinitializer
  %res = sub <4 x i64> %op1, %op2
  store <4 x i64> %res, ptr %a
  ret void
}

;
; UMAX
;

define void @umax_v32i8(ptr %a) #0 {
; CHECK-LABEL: umax_v32i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldp q0, q1, [x0]
; CHECK-NEXT:    mov z2.b, #7 // =0x7
; CHECK-NEXT:    ptrue p0.b, vl16
; CHECK-NEXT:    umax z0.b, p0/m, z0.b, z2.b
; CHECK-NEXT:    umax z1.b, p0/m, z1.b, z2.b
; CHECK-NEXT:    stp q0, q1, [x0]
; CHECK-NEXT:    ret
  %op1 = load <32 x i8>, ptr %a
  %ins = insertelement <32 x i8> undef, i8 7, i64 0
  %op2 = shufflevector <32 x i8> %ins, <32 x i8> undef, <32 x i32> zeroinitializer
  %res = call <32 x i8> @llvm.umax.v32i8(<32 x i8> %op1, <32 x i8> %op2)
  store <32 x i8> %res, ptr %a
  ret void
}

define void @umax_v16i16(ptr %a) #0 {
; CHECK-LABEL: umax_v16i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldp q0, q1, [x0]
; CHECK-NEXT:    mov z2.h, #15 // =0xf
; CHECK-NEXT:    ptrue p0.h, vl8
; CHECK-NEXT:    umax z0.h, p0/m, z0.h, z2.h
; CHECK-NEXT:    umax z1.h, p0/m, z1.h, z2.h
; CHECK-NEXT:    stp q0, q1, [x0]
; CHECK-NEXT:    ret
  %op1 = load <16 x i16>, ptr %a
  %ins = insertelement <16 x i16> undef, i16 15, i64 0
  %op2 = shufflevector <16 x i16> %ins, <16 x i16> undef, <16 x i32> zeroinitializer
  %res = call <16 x i16> @llvm.umax.v16i16(<16 x i16> %op1, <16 x i16> %op2)
  store <16 x i16> %res, ptr %a
  ret void
}

define void @umax_v8i32(ptr %a) #0 {
; CHECK-LABEL: umax_v8i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldp q0, q1, [x0]
; CHECK-NEXT:    mov z2.s, #31 // =0x1f
; CHECK-NEXT:    ptrue p0.s, vl4
; CHECK-NEXT:    umax z0.s, p0/m, z0.s, z2.s
; CHECK-NEXT:    umax z1.s, p0/m, z1.s, z2.s
; CHECK-NEXT:    stp q0, q1, [x0]
; CHECK-NEXT:    ret
  %op1 = load <8 x i32>, ptr %a
  %ins = insertelement <8 x i32> undef, i32 31, i64 0
  %op2 = shufflevector <8 x i32> %ins, <8 x i32> undef, <8 x i32> zeroinitializer
  %res = call <8 x i32> @llvm.umax.v8i32(<8 x i32> %op1, <8 x i32> %op2)
  store <8 x i32> %res, ptr %a
  ret void
}

define void @umax_v4i64(ptr %a) #0 {
; CHECK-LABEL: umax_v4i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldp q0, q1, [x0]
; CHECK-NEXT:    mov z2.d, #63 // =0x3f
; CHECK-NEXT:    ptrue p0.d, vl2
; CHECK-NEXT:    umax z0.d, p0/m, z0.d, z2.d
; CHECK-NEXT:    umax z1.d, p0/m, z1.d, z2.d
; CHECK-NEXT:    stp q0, q1, [x0]
; CHECK-NEXT:    ret
  %op1 = load <4 x i64>, ptr %a
  %ins = insertelement <4 x i64> undef, i64 63, i64 0
  %op2 = shufflevector <4 x i64> %ins, <4 x i64> undef, <4 x i32> zeroinitializer
  %res = call <4 x i64> @llvm.umax.v4i64(<4 x i64> %op1, <4 x i64> %op2)
  store <4 x i64> %res, ptr %a
  ret void
}

;
; UMIN
;

define void @umin_v32i8(ptr %a) #0 {
; CHECK-LABEL: umin_v32i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldp q0, q1, [x0]
; CHECK-NEXT:    mov z2.b, #7 // =0x7
; CHECK-NEXT:    ptrue p0.b, vl16
; CHECK-NEXT:    umin z0.b, p0/m, z0.b, z2.b
; CHECK-NEXT:    umin z1.b, p0/m, z1.b, z2.b
; CHECK-NEXT:    stp q0, q1, [x0]
; CHECK-NEXT:    ret
  %op1 = load <32 x i8>, ptr %a
  %ins = insertelement <32 x i8> undef, i8 7, i64 0
  %op2 = shufflevector <32 x i8> %ins, <32 x i8> undef, <32 x i32> zeroinitializer
  %res = call <32 x i8> @llvm.umin.v32i8(<32 x i8> %op1, <32 x i8> %op2)
  store <32 x i8> %res, ptr %a
  ret void
}

define void @umin_v16i16(ptr %a) #0 {
; CHECK-LABEL: umin_v16i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldp q0, q1, [x0]
; CHECK-NEXT:    mov z2.h, #15 // =0xf
; CHECK-NEXT:    ptrue p0.h, vl8
; CHECK-NEXT:    umin z0.h, p0/m, z0.h, z2.h
; CHECK-NEXT:    umin z1.h, p0/m, z1.h, z2.h
; CHECK-NEXT:    stp q0, q1, [x0]
; CHECK-NEXT:    ret
  %op1 = load <16 x i16>, ptr %a
  %ins = insertelement <16 x i16> undef, i16 15, i64 0
  %op2 = shufflevector <16 x i16> %ins, <16 x i16> undef, <16 x i32> zeroinitializer
  %res = call <16 x i16> @llvm.umin.v16i16(<16 x i16> %op1, <16 x i16> %op2)
  store <16 x i16> %res, ptr %a
  ret void
}

define void @umin_v8i32(ptr %a) #0 {
; CHECK-LABEL: umin_v8i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldp q0, q1, [x0]
; CHECK-NEXT:    mov z2.s, #31 // =0x1f
; CHECK-NEXT:    ptrue p0.s, vl4
; CHECK-NEXT:    umin z0.s, p0/m, z0.s, z2.s
; CHECK-NEXT:    umin z1.s, p0/m, z1.s, z2.s
; CHECK-NEXT:    stp q0, q1, [x0]
; CHECK-NEXT:    ret
  %op1 = load <8 x i32>, ptr %a
  %ins = insertelement <8 x i32> undef, i32 31, i64 0
  %op2 = shufflevector <8 x i32> %ins, <8 x i32> undef, <8 x i32> zeroinitializer
  %res = call <8 x i32> @llvm.umin.v8i32(<8 x i32> %op1, <8 x i32> %op2)
  store <8 x i32> %res, ptr %a
  ret void
}

define void @umin_v4i64(ptr %a) #0 {
; CHECK-LABEL: umin_v4i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldp q0, q1, [x0]
; CHECK-NEXT:    mov z2.d, #63 // =0x3f
; CHECK-NEXT:    ptrue p0.d, vl2
; CHECK-NEXT:    umin z0.d, p0/m, z0.d, z2.d
; CHECK-NEXT:    umin z1.d, p0/m, z1.d, z2.d
; CHECK-NEXT:    stp q0, q1, [x0]
; CHECK-NEXT:    ret
  %op1 = load <4 x i64>, ptr %a
  %ins = insertelement <4 x i64> undef, i64 63, i64 0
  %op2 = shufflevector <4 x i64> %ins, <4 x i64> undef, <4 x i32> zeroinitializer
  %res = call <4 x i64> @llvm.umin.v4i64(<4 x i64> %op1, <4 x i64> %op2)
  store <4 x i64> %res, ptr %a
  ret void
}

;
; XOR
;

define void @xor_v32i8(ptr %a) #0 {
; CHECK-LABEL: xor_v32i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldp q0, q1, [x0]
; CHECK-NEXT:    eor z0.b, z0.b, #0x7
; CHECK-NEXT:    eor z1.b, z1.b, #0x7
; CHECK-NEXT:    stp q0, q1, [x0]
; CHECK-NEXT:    ret
  %op1 = load <32 x i8>, ptr %a
  %ins = insertelement <32 x i8> undef, i8 7, i64 0
  %op2 = shufflevector <32 x i8> %ins, <32 x i8> undef, <32 x i32> zeroinitializer
  %res = xor <32 x i8> %op1, %op2
  store <32 x i8> %res, ptr %a
  ret void
}

define void @xor_v16i16(ptr %a) #0 {
; CHECK-LABEL: xor_v16i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldp q0, q1, [x0]
; CHECK-NEXT:    eor z0.h, z0.h, #0xf
; CHECK-NEXT:    eor z1.h, z1.h, #0xf
; CHECK-NEXT:    stp q0, q1, [x0]
; CHECK-NEXT:    ret
  %op1 = load <16 x i16>, ptr %a
  %ins = insertelement <16 x i16> undef, i16 15, i64 0
  %op2 = shufflevector <16 x i16> %ins, <16 x i16> undef, <16 x i32> zeroinitializer
  %res = xor <16 x i16> %op1, %op2
  store <16 x i16> %res, ptr %a
  ret void
}

define void @xor_v8i32(ptr %a) #0 {
; CHECK-LABEL: xor_v8i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldp q0, q1, [x0]
; CHECK-NEXT:    eor z0.s, z0.s, #0x1f
; CHECK-NEXT:    eor z1.s, z1.s, #0x1f
; CHECK-NEXT:    stp q0, q1, [x0]
; CHECK-NEXT:    ret
  %op1 = load <8 x i32>, ptr %a
  %ins = insertelement <8 x i32> undef, i32 31, i64 0
  %op2 = shufflevector <8 x i32> %ins, <8 x i32> undef, <8 x i32> zeroinitializer
  %res = xor <8 x i32> %op1, %op2
  store <8 x i32> %res, ptr %a
  ret void
}

define void @xor_v4i64(ptr %a) #0 {
; CHECK-LABEL: xor_v4i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldp q0, q1, [x0]
; CHECK-NEXT:    eor z0.d, z0.d, #0x3f
; CHECK-NEXT:    eor z1.d, z1.d, #0x3f
; CHECK-NEXT:    stp q0, q1, [x0]
; CHECK-NEXT:    ret
  %op1 = load <4 x i64>, ptr %a
  %ins = insertelement <4 x i64> undef, i64 63, i64 0
  %op2 = shufflevector <4 x i64> %ins, <4 x i64> undef, <4 x i32> zeroinitializer
  %res = xor <4 x i64> %op1, %op2
  store <4 x i64> %res, ptr %a
  ret void
}

declare <32 x i8> @llvm.smax.v32i8(<32 x i8>, <32 x i8>)
declare <16 x i16> @llvm.smax.v16i16(<16 x i16>, <16 x i16>)
declare <8 x i32> @llvm.smax.v8i32(<8 x i32>, <8 x i32>)
declare <4 x i64> @llvm.smax.v4i64(<4 x i64>, <4 x i64>)

declare <32 x i8> @llvm.smin.v32i8(<32 x i8>, <32 x i8>)
declare <16 x i16> @llvm.smin.v16i16(<16 x i16>, <16 x i16>)
declare <8 x i32> @llvm.smin.v8i32(<8 x i32>, <8 x i32>)
declare <4 x i64> @llvm.smin.v4i64(<4 x i64>, <4 x i64>)

declare <32 x i8> @llvm.umax.v32i8(<32 x i8>, <32 x i8>)
declare <16 x i16> @llvm.umax.v16i16(<16 x i16>, <16 x i16>)
declare <8 x i32> @llvm.umax.v8i32(<8 x i32>, <8 x i32>)
declare <4 x i64> @llvm.umax.v4i64(<4 x i64>, <4 x i64>)

declare <32 x i8> @llvm.umin.v32i8(<32 x i8>, <32 x i8>)
declare <16 x i16> @llvm.umin.v16i16(<16 x i16>, <16 x i16>)
declare <8 x i32> @llvm.umin.v8i32(<8 x i32>, <8 x i32>)
declare <4 x i64> @llvm.umin.v4i64(<4 x i64>, <4 x i64>)

attributes #0 = { "target-features"="+sve" }
