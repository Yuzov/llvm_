; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -march=r600 -mcpu=cayman < %s | FileCheck -check-prefixes=CM %s
; RUN: llc -march=r600 -mcpu=redwood < %s | FileCheck -check-prefixes=EG %s

define amdgpu_kernel void @test_umul24_i32(ptr addrspace(1) %out, i32 %a, i32 %b) {
; CM-LABEL: test_umul24_i32:
; CM:       ; %bb.0: ; %entry
; CM-NEXT:    ALU 7, @4, KC0[CB0:0-32], KC1[]
; CM-NEXT:    MEM_RAT_CACHELESS STORE_DWORD T1.X, T0.X
; CM-NEXT:    CF_END
; CM-NEXT:    PAD
; CM-NEXT:    ALU clause starting at 4:
; CM-NEXT:     LSHR T0.X, KC0[2].Y, literal.x,
; CM-NEXT:     AND_INT T0.Z, KC0[2].W, literal.y,
; CM-NEXT:     AND_INT * T0.W, KC0[2].Z, literal.y,
; CM-NEXT:    2(2.802597e-45), 16777215(2.350989e-38)
; CM-NEXT:     MULLO_INT T1.X, T0.W, T0.Z,
; CM-NEXT:     MULLO_INT T1.Y (MASKED), T0.W, T0.Z,
; CM-NEXT:     MULLO_INT T1.Z (MASKED), T0.W, T0.Z,
; CM-NEXT:     MULLO_INT * T1.W (MASKED), T0.W, T0.Z,
;
; EG-LABEL: test_umul24_i32:
; EG:       ; %bb.0: ; %entry
; EG-NEXT:    ALU 5, @4, KC0[CB0:0-32], KC1[]
; EG-NEXT:    MEM_RAT_CACHELESS STORE_RAW T1.X, T0.X, 1
; EG-NEXT:    CF_END
; EG-NEXT:    PAD
; EG-NEXT:    ALU clause starting at 4:
; EG-NEXT:     AND_INT T0.W, KC0[2].W, literal.x,
; EG-NEXT:     AND_INT * T1.W, KC0[2].Z, literal.x,
; EG-NEXT:    16777215(2.350989e-38), 0(0.000000e+00)
; EG-NEXT:     LSHR T0.X, KC0[2].Y, literal.x,
; EG-NEXT:     MULLO_INT * T1.X, PS, PV.W,
; EG-NEXT:    2(2.802597e-45), 0(0.000000e+00)
entry:
  %0 = shl i32 %a, 8
  %a_24 = lshr i32 %0, 8
  %1 = shl i32 %b, 8
  %b_24 = lshr i32 %1, 8
  %2 = mul i32 %a_24, %b_24
  store i32 %2, ptr addrspace(1) %out
  ret void
}

; The result must be sign-extended.
define amdgpu_kernel void @test_umul24_i16_sext(ptr addrspace(1) %out, i16 %a, i16 %b) {
; CM-LABEL: test_umul24_i16_sext:
; CM:       ; %bb.0: ; %entry
; CM-NEXT:    ALU 0, @10, KC0[], KC1[]
; CM-NEXT:    TEX 1 @6
; CM-NEXT:    ALU 7, @11, KC0[CB0:0-32], KC1[]
; CM-NEXT:    MEM_RAT_CACHELESS STORE_DWORD T0.X, T1.X
; CM-NEXT:    CF_END
; CM-NEXT:    PAD
; CM-NEXT:    Fetch clause starting at 6:
; CM-NEXT:     VTX_READ_16 T1.X, T0.X, 40, #3
; CM-NEXT:     VTX_READ_16 T0.X, T0.X, 42, #3
; CM-NEXT:    ALU clause starting at 10:
; CM-NEXT:     MOV * T0.X, 0.0,
; CM-NEXT:    ALU clause starting at 11:
; CM-NEXT:     MULLO_INT T0.X, T1.X, T0.X,
; CM-NEXT:     MULLO_INT T0.Y (MASKED), T1.X, T0.X,
; CM-NEXT:     MULLO_INT T0.Z (MASKED), T1.X, T0.X,
; CM-NEXT:     MULLO_INT * T0.W (MASKED), T1.X, T0.X,
; CM-NEXT:     BFE_INT * T0.X, PV.X, 0.0, literal.x,
; CM-NEXT:    16(2.242078e-44), 0(0.000000e+00)
; CM-NEXT:     LSHR * T1.X, KC0[2].Y, literal.x,
; CM-NEXT:    2(2.802597e-45), 0(0.000000e+00)
;
; EG-LABEL: test_umul24_i16_sext:
; EG:       ; %bb.0: ; %entry
; EG-NEXT:    ALU 0, @10, KC0[], KC1[]
; EG-NEXT:    TEX 1 @6
; EG-NEXT:    ALU 3, @11, KC0[CB0:0-32], KC1[]
; EG-NEXT:    MEM_RAT_CACHELESS STORE_RAW T0.X, T1.X, 1
; EG-NEXT:    CF_END
; EG-NEXT:    PAD
; EG-NEXT:    Fetch clause starting at 6:
; EG-NEXT:     VTX_READ_16 T1.X, T0.X, 40, #3
; EG-NEXT:     VTX_READ_16 T0.X, T0.X, 42, #3
; EG-NEXT:    ALU clause starting at 10:
; EG-NEXT:     MOV * T0.X, 0.0,
; EG-NEXT:    ALU clause starting at 11:
; EG-NEXT:     MULLO_INT * T0.X, T1.X, T0.X,
; EG-NEXT:     BFE_INT T0.X, PS, 0.0, literal.x,
; EG-NEXT:     LSHR * T1.X, KC0[2].Y, literal.y,
; EG-NEXT:    16(2.242078e-44), 2(2.802597e-45)
entry:
  %mul = mul i16 %a, %b
  %ext = sext i16 %mul to i32
  store i32 %ext, ptr addrspace(1) %out
  ret void
}

; The result must be sign-extended.
define amdgpu_kernel void @test_umul24_i8(ptr addrspace(1) %out, i8 %a, i8 %b) {
; CM-LABEL: test_umul24_i8:
; CM:       ; %bb.0: ; %entry
; CM-NEXT:    ALU 0, @10, KC0[], KC1[]
; CM-NEXT:    TEX 1 @6
; CM-NEXT:    ALU 7, @11, KC0[CB0:0-32], KC1[]
; CM-NEXT:    MEM_RAT_CACHELESS STORE_DWORD T0.X, T1.X
; CM-NEXT:    CF_END
; CM-NEXT:    PAD
; CM-NEXT:    Fetch clause starting at 6:
; CM-NEXT:     VTX_READ_8 T1.X, T0.X, 40, #3
; CM-NEXT:     VTX_READ_8 T0.X, T0.X, 41, #3
; CM-NEXT:    ALU clause starting at 10:
; CM-NEXT:     MOV * T0.X, 0.0,
; CM-NEXT:    ALU clause starting at 11:
; CM-NEXT:     MULLO_INT T0.X, T1.X, T0.X,
; CM-NEXT:     MULLO_INT T0.Y (MASKED), T1.X, T0.X,
; CM-NEXT:     MULLO_INT T0.Z (MASKED), T1.X, T0.X,
; CM-NEXT:     MULLO_INT * T0.W (MASKED), T1.X, T0.X,
; CM-NEXT:     BFE_INT * T0.X, PV.X, 0.0, literal.x,
; CM-NEXT:    8(1.121039e-44), 0(0.000000e+00)
; CM-NEXT:     LSHR * T1.X, KC0[2].Y, literal.x,
; CM-NEXT:    2(2.802597e-45), 0(0.000000e+00)
;
; EG-LABEL: test_umul24_i8:
; EG:       ; %bb.0: ; %entry
; EG-NEXT:    ALU 0, @10, KC0[], KC1[]
; EG-NEXT:    TEX 1 @6
; EG-NEXT:    ALU 3, @11, KC0[CB0:0-32], KC1[]
; EG-NEXT:    MEM_RAT_CACHELESS STORE_RAW T0.X, T1.X, 1
; EG-NEXT:    CF_END
; EG-NEXT:    PAD
; EG-NEXT:    Fetch clause starting at 6:
; EG-NEXT:     VTX_READ_8 T1.X, T0.X, 40, #3
; EG-NEXT:     VTX_READ_8 T0.X, T0.X, 41, #3
; EG-NEXT:    ALU clause starting at 10:
; EG-NEXT:     MOV * T0.X, 0.0,
; EG-NEXT:    ALU clause starting at 11:
; EG-NEXT:     MULLO_INT * T0.X, T1.X, T0.X,
; EG-NEXT:     BFE_INT T0.X, PS, 0.0, literal.x,
; EG-NEXT:     LSHR * T1.X, KC0[2].Y, literal.y,
; EG-NEXT:    8(1.121039e-44), 2(2.802597e-45)
entry:
  %mul = mul i8 %a, %b
  %ext = sext i8 %mul to i32
  store i32 %ext, ptr addrspace(1) %out
  ret void
}

define amdgpu_kernel void @test_umulhi24_i32_i64(ptr addrspace(1) %out, i32 %a, i32 %b) {
; CM-LABEL: test_umulhi24_i32_i64:
; CM:       ; %bb.0: ; %entry
; CM-NEXT:    ALU 5, @4, KC0[CB0:0-32], KC1[]
; CM-NEXT:    MEM_RAT_CACHELESS STORE_DWORD T1.X, T0.X
; CM-NEXT:    CF_END
; CM-NEXT:    PAD
; CM-NEXT:    ALU clause starting at 4:
; CM-NEXT:     LSHR * T0.X, KC0[2].Y, literal.x,
; CM-NEXT:    2(2.802597e-45), 0(0.000000e+00)
; CM-NEXT:     MULHI_UINT24 T1.X, KC0[2].Z, KC0[2].W,
; CM-NEXT:     MULHI_UINT24 T1.Y (MASKED), KC0[2].Z, KC0[2].W,
; CM-NEXT:     MULHI_UINT24 T1.Z (MASKED), KC0[2].Z, KC0[2].W,
; CM-NEXT:     MULHI_UINT24 * T1.W (MASKED), KC0[2].Z, KC0[2].W,
;
; EG-LABEL: test_umulhi24_i32_i64:
; EG:       ; %bb.0: ; %entry
; EG-NEXT:    ALU 2, @4, KC0[CB0:0-32], KC1[]
; EG-NEXT:    MEM_RAT_CACHELESS STORE_RAW T1.X, T0.X, 1
; EG-NEXT:    CF_END
; EG-NEXT:    PAD
; EG-NEXT:    ALU clause starting at 4:
; EG-NEXT:     LSHR * T0.X, KC0[2].Y, literal.x,
; EG-NEXT:    2(2.802597e-45), 0(0.000000e+00)
; EG-NEXT:     MULHI_UINT24 * T1.X, KC0[2].Z, KC0[2].W,
entry:
  %a.24 = and i32 %a, 16777215
  %b.24 = and i32 %b, 16777215
  %a.24.i64 = zext i32 %a.24 to i64
  %b.24.i64 = zext i32 %b.24 to i64
  %mul48 = mul i64 %a.24.i64, %b.24.i64
  %mul48.hi = lshr i64 %mul48, 32
  %mul24hi = trunc i64 %mul48.hi to i32
  store i32 %mul24hi, ptr addrspace(1) %out
  ret void
}

define amdgpu_kernel void @test_umulhi24(ptr addrspace(1) %out, i64 %a, i64 %b) {
; CM-LABEL: test_umulhi24:
; CM:       ; %bb.0: ; %entry
; CM-NEXT:    ALU 5, @4, KC0[CB0:0-32], KC1[]
; CM-NEXT:    MEM_RAT_CACHELESS STORE_DWORD T1.X, T0.X
; CM-NEXT:    CF_END
; CM-NEXT:    PAD
; CM-NEXT:    ALU clause starting at 4:
; CM-NEXT:     LSHR * T0.X, KC0[2].Y, literal.x,
; CM-NEXT:    2(2.802597e-45), 0(0.000000e+00)
; CM-NEXT:     MULHI_UINT24 T1.X, KC0[2].W, KC0[3].Y,
; CM-NEXT:     MULHI_UINT24 T1.Y (MASKED), KC0[2].W, KC0[3].Y,
; CM-NEXT:     MULHI_UINT24 T1.Z (MASKED), KC0[2].W, KC0[3].Y,
; CM-NEXT:     MULHI_UINT24 * T1.W (MASKED), KC0[2].W, KC0[3].Y,
;
; EG-LABEL: test_umulhi24:
; EG:       ; %bb.0: ; %entry
; EG-NEXT:    ALU 2, @4, KC0[CB0:0-32], KC1[]
; EG-NEXT:    MEM_RAT_CACHELESS STORE_RAW T1.X, T0.X, 1
; EG-NEXT:    CF_END
; EG-NEXT:    PAD
; EG-NEXT:    ALU clause starting at 4:
; EG-NEXT:     LSHR * T0.X, KC0[2].Y, literal.x,
; EG-NEXT:    2(2.802597e-45), 0(0.000000e+00)
; EG-NEXT:     MULHI_UINT24 * T1.X, KC0[2].W, KC0[3].Y,
entry:
  %a.24 = and i64 %a, 16777215
  %b.24 = and i64 %b, 16777215
  %mul48 = mul i64 %a.24, %b.24
  %mul48.hi = lshr i64 %mul48, 32
  %mul24.hi = trunc i64 %mul48.hi to i32
  store i32 %mul24.hi, ptr addrspace(1) %out
  ret void
}

; Multiply with 24-bit inputs and 64-bit output.
define amdgpu_kernel void @test_umul24_i64(ptr addrspace(1) %out, i64 %a, i64 %b) {
; CM-LABEL: test_umul24_i64:
; CM:       ; %bb.0: ; %entry
; CM-NEXT:    ALU 12, @4, KC0[CB0:0-32], KC1[]
; CM-NEXT:    MEM_RAT_CACHELESS STORE_DWORD T1, T0.X
; CM-NEXT:    CF_END
; CM-NEXT:    PAD
; CM-NEXT:    ALU clause starting at 4:
; CM-NEXT:     LSHR T0.X, KC0[2].Y, literal.x,
; CM-NEXT:     AND_INT * T0.Z, KC0[3].Y, literal.y,
; CM-NEXT:    2(2.802597e-45), 16777215(2.350989e-38)
; CM-NEXT:     AND_INT * T0.W, KC0[2].W, literal.x,
; CM-NEXT:    16777215(2.350989e-38), 0(0.000000e+00)
; CM-NEXT:     MULLO_INT T1.X, T0.W, T0.Z,
; CM-NEXT:     MULLO_INT T1.Y (MASKED), T0.W, T0.Z,
; CM-NEXT:     MULLO_INT T1.Z (MASKED), T0.W, T0.Z,
; CM-NEXT:     MULLO_INT * T1.W (MASKED), T0.W, T0.Z,
; CM-NEXT:     MULHI_UINT24 T1.X (MASKED), KC0[2].W, KC0[3].Y,
; CM-NEXT:     MULHI_UINT24 T1.Y, KC0[2].W, KC0[3].Y,
; CM-NEXT:     MULHI_UINT24 T1.Z (MASKED), KC0[2].W, KC0[3].Y,
; CM-NEXT:     MULHI_UINT24 * T1.W (MASKED), KC0[2].W, KC0[3].Y,
;
; EG-LABEL: test_umul24_i64:
; EG:       ; %bb.0: ; %entry
; EG-NEXT:    ALU 6, @4, KC0[CB0:0-32], KC1[]
; EG-NEXT:    MEM_RAT_CACHELESS STORE_RAW T1.XY, T0.X, 1
; EG-NEXT:    CF_END
; EG-NEXT:    PAD
; EG-NEXT:    ALU clause starting at 4:
; EG-NEXT:     AND_INT T0.W, KC0[3].Y, literal.x,
; EG-NEXT:     AND_INT * T1.W, KC0[2].W, literal.x,
; EG-NEXT:    16777215(2.350989e-38), 0(0.000000e+00)
; EG-NEXT:     LSHR T0.X, KC0[2].Y, literal.x,
; EG-NEXT:     MULLO_INT * T1.X, PS, PV.W,
; EG-NEXT:    2(2.802597e-45), 0(0.000000e+00)
; EG-NEXT:     MULHI_UINT24 * T1.Y, KC0[2].W, KC0[3].Y,
entry:
  %tmp0 = shl i64 %a, 40
  %a_24 = lshr i64 %tmp0, 40
  %tmp1 = shl i64 %b, 40
  %b_24 = lshr i64 %tmp1, 40
  %tmp2 = mul i64 %a_24, %b_24
  store i64 %tmp2, ptr addrspace(1) %out
  ret void
}
