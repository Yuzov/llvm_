; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -march=amdgcn -mcpu=gfx1010 -verify-machineinstrs | FileCheck %s -check-prefix=GFX10

; RUN: llc < %s -global-isel -march=amdgcn -mcpu=gfx1010 -verify-machineinstrs | FileCheck %s -check-prefix=G_GFX10

declare double @llvm.amdgcn.global.atomic.fmin.f64.p1.f64(ptr addrspace(1) %ptr, double %data)
declare double @llvm.amdgcn.global.atomic.fmax.f64.p1.f64(ptr addrspace(1) %ptr, double %data)
declare float @llvm.amdgcn.global.atomic.fmin.f32.p1.f32(ptr addrspace(1) %ptr, float %data)
declare float @llvm.amdgcn.global.atomic.fmax.f32.p1.f32(ptr addrspace(1) %ptr, float %data)

define amdgpu_kernel void @global_atomic_fmin_f32_noret(ptr addrspace(1) %ptr, float %data) {
; GFX10-LABEL: global_atomic_fmin_f32_noret:
; GFX10:       ; %bb.0: ; %main_body
; GFX10-NEXT:    s_clause 0x1
; GFX10-NEXT:    s_load_dword s4, s[0:1], 0x2c
; GFX10-NEXT:    s_load_dwordx2 s[2:3], s[0:1], 0x24
; GFX10-NEXT:    v_mov_b32_e32 v0, 0
; GFX10-NEXT:    s_waitcnt lgkmcnt(0)
; GFX10-NEXT:    v_mov_b32_e32 v1, s4
; GFX10-NEXT:    global_atomic_fmin v0, v1, s[2:3]
; GFX10-NEXT:    s_endpgm
;
; G_GFX10-LABEL: global_atomic_fmin_f32_noret:
; G_GFX10:       ; %bb.0: ; %main_body
; G_GFX10-NEXT:    s_clause 0x1
; G_GFX10-NEXT:    s_load_dword s4, s[0:1], 0x2c
; G_GFX10-NEXT:    s_load_dwordx2 s[2:3], s[0:1], 0x24
; G_GFX10-NEXT:    v_mov_b32_e32 v1, 0
; G_GFX10-NEXT:    s_waitcnt lgkmcnt(0)
; G_GFX10-NEXT:    v_mov_b32_e32 v0, s4
; G_GFX10-NEXT:    global_atomic_fmin v1, v0, s[2:3]
; G_GFX10-NEXT:    s_endpgm
main_body:
  %ret = call float @llvm.amdgcn.global.atomic.fmin.f32.p1.f32(ptr addrspace(1) %ptr, float %data)
  ret void
}

define amdgpu_kernel void @global_atomic_fmax_f32_noret(ptr addrspace(1) %ptr, float %data) {
; GFX10-LABEL: global_atomic_fmax_f32_noret:
; GFX10:       ; %bb.0: ; %main_body
; GFX10-NEXT:    s_clause 0x1
; GFX10-NEXT:    s_load_dword s4, s[0:1], 0x2c
; GFX10-NEXT:    s_load_dwordx2 s[2:3], s[0:1], 0x24
; GFX10-NEXT:    v_mov_b32_e32 v0, 0
; GFX10-NEXT:    s_waitcnt lgkmcnt(0)
; GFX10-NEXT:    v_mov_b32_e32 v1, s4
; GFX10-NEXT:    global_atomic_fmax v0, v1, s[2:3]
; GFX10-NEXT:    s_endpgm
;
; G_GFX10-LABEL: global_atomic_fmax_f32_noret:
; G_GFX10:       ; %bb.0: ; %main_body
; G_GFX10-NEXT:    s_clause 0x1
; G_GFX10-NEXT:    s_load_dword s4, s[0:1], 0x2c
; G_GFX10-NEXT:    s_load_dwordx2 s[2:3], s[0:1], 0x24
; G_GFX10-NEXT:    v_mov_b32_e32 v1, 0
; G_GFX10-NEXT:    s_waitcnt lgkmcnt(0)
; G_GFX10-NEXT:    v_mov_b32_e32 v0, s4
; G_GFX10-NEXT:    global_atomic_fmax v1, v0, s[2:3]
; G_GFX10-NEXT:    s_endpgm
main_body:
  %ret = call float @llvm.amdgcn.global.atomic.fmax.f32.p1.f32(ptr addrspace(1) %ptr, float %data)
  ret void
}

define float @global_atomic_fmax_f32_rtn(ptr addrspace(1) %ptr, float %data) {
; GFX10-LABEL: global_atomic_fmax_f32_rtn:
; GFX10:       ; %bb.0: ; %main_body
; GFX10-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX10-NEXT:    s_waitcnt_vscnt null, 0x0
; GFX10-NEXT:    global_atomic_fmax v0, v[0:1], v2, off glc
; GFX10-NEXT:    s_waitcnt vmcnt(0)
; GFX10-NEXT:    s_setpc_b64 s[30:31]
;
; G_GFX10-LABEL: global_atomic_fmax_f32_rtn:
; G_GFX10:       ; %bb.0: ; %main_body
; G_GFX10-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; G_GFX10-NEXT:    s_waitcnt_vscnt null, 0x0
; G_GFX10-NEXT:    global_atomic_fmax v0, v[0:1], v2, off glc
; G_GFX10-NEXT:    s_waitcnt vmcnt(0)
; G_GFX10-NEXT:    s_setpc_b64 s[30:31]
main_body:
  %ret = call float @llvm.amdgcn.global.atomic.fmax.f32.p1.f32(ptr addrspace(1) %ptr, float %data)
  ret float %ret
}

define float @global_atomic_fmin_f32_rtn(ptr addrspace(1) %ptr, float %data) {
; GFX10-LABEL: global_atomic_fmin_f32_rtn:
; GFX10:       ; %bb.0: ; %main_body
; GFX10-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX10-NEXT:    s_waitcnt_vscnt null, 0x0
; GFX10-NEXT:    global_atomic_fmin v0, v[0:1], v2, off glc
; GFX10-NEXT:    s_waitcnt vmcnt(0)
; GFX10-NEXT:    s_setpc_b64 s[30:31]
;
; G_GFX10-LABEL: global_atomic_fmin_f32_rtn:
; G_GFX10:       ; %bb.0: ; %main_body
; G_GFX10-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; G_GFX10-NEXT:    s_waitcnt_vscnt null, 0x0
; G_GFX10-NEXT:    global_atomic_fmin v0, v[0:1], v2, off glc
; G_GFX10-NEXT:    s_waitcnt vmcnt(0)
; G_GFX10-NEXT:    s_setpc_b64 s[30:31]
main_body:
  %ret = call float @llvm.amdgcn.global.atomic.fmin.f32.p1.f32(ptr addrspace(1) %ptr, float %data)
  ret float %ret
}

define amdgpu_kernel void @global_atomic_fmin_f64_noret(ptr addrspace(1) %ptr, double %data) {
; GFX10-LABEL: global_atomic_fmin_f64_noret:
; GFX10:       ; %bb.0: ; %main_body
; GFX10-NEXT:    s_load_dwordx4 s[0:3], s[0:1], 0x24
; GFX10-NEXT:    v_mov_b32_e32 v2, 0
; GFX10-NEXT:    s_waitcnt lgkmcnt(0)
; GFX10-NEXT:    v_mov_b32_e32 v0, s2
; GFX10-NEXT:    v_mov_b32_e32 v1, s3
; GFX10-NEXT:    global_atomic_fmin_x2 v2, v[0:1], s[0:1]
; GFX10-NEXT:    s_endpgm
;
; G_GFX10-LABEL: global_atomic_fmin_f64_noret:
; G_GFX10:       ; %bb.0: ; %main_body
; G_GFX10-NEXT:    s_load_dwordx4 s[0:3], s[0:1], 0x24
; G_GFX10-NEXT:    v_mov_b32_e32 v2, 0
; G_GFX10-NEXT:    s_waitcnt lgkmcnt(0)
; G_GFX10-NEXT:    v_mov_b32_e32 v0, s2
; G_GFX10-NEXT:    v_mov_b32_e32 v1, s3
; G_GFX10-NEXT:    global_atomic_fmin_x2 v2, v[0:1], s[0:1]
; G_GFX10-NEXT:    s_endpgm
main_body:
  %ret = call double @llvm.amdgcn.global.atomic.fmin.f64.p1.f64(ptr addrspace(1) %ptr, double %data)
  ret void
}

define amdgpu_kernel void @global_atomic_fmax_f64_noret(ptr addrspace(1) %ptr, double %data) {
; GFX10-LABEL: global_atomic_fmax_f64_noret:
; GFX10:       ; %bb.0: ; %main_body
; GFX10-NEXT:    s_load_dwordx4 s[0:3], s[0:1], 0x24
; GFX10-NEXT:    v_mov_b32_e32 v2, 0
; GFX10-NEXT:    s_waitcnt lgkmcnt(0)
; GFX10-NEXT:    v_mov_b32_e32 v0, s2
; GFX10-NEXT:    v_mov_b32_e32 v1, s3
; GFX10-NEXT:    global_atomic_fmax_x2 v2, v[0:1], s[0:1]
; GFX10-NEXT:    s_endpgm
;
; G_GFX10-LABEL: global_atomic_fmax_f64_noret:
; G_GFX10:       ; %bb.0: ; %main_body
; G_GFX10-NEXT:    s_load_dwordx4 s[0:3], s[0:1], 0x24
; G_GFX10-NEXT:    v_mov_b32_e32 v2, 0
; G_GFX10-NEXT:    s_waitcnt lgkmcnt(0)
; G_GFX10-NEXT:    v_mov_b32_e32 v0, s2
; G_GFX10-NEXT:    v_mov_b32_e32 v1, s3
; G_GFX10-NEXT:    global_atomic_fmax_x2 v2, v[0:1], s[0:1]
; G_GFX10-NEXT:    s_endpgm
main_body:
  %ret = call double @llvm.amdgcn.global.atomic.fmax.f64.p1.f64(ptr addrspace(1) %ptr, double %data)
  ret void
}

define double @global_atomic_fmax_f64_rtn(ptr addrspace(1) %ptr, double %data) {
; GFX10-LABEL: global_atomic_fmax_f64_rtn:
; GFX10:       ; %bb.0: ; %main_body
; GFX10-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX10-NEXT:    s_waitcnt_vscnt null, 0x0
; GFX10-NEXT:    global_atomic_fmax_x2 v[0:1], v[0:1], v[2:3], off glc
; GFX10-NEXT:    s_waitcnt vmcnt(0)
; GFX10-NEXT:    s_setpc_b64 s[30:31]
;
; G_GFX10-LABEL: global_atomic_fmax_f64_rtn:
; G_GFX10:       ; %bb.0: ; %main_body
; G_GFX10-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; G_GFX10-NEXT:    s_waitcnt_vscnt null, 0x0
; G_GFX10-NEXT:    global_atomic_fmax_x2 v[0:1], v[0:1], v[2:3], off glc
; G_GFX10-NEXT:    s_waitcnt vmcnt(0)
; G_GFX10-NEXT:    s_setpc_b64 s[30:31]
main_body:
  %ret = call double @llvm.amdgcn.global.atomic.fmax.f64.p1.f64(ptr addrspace(1) %ptr, double %data)
  ret double %ret
}

define double @global_atomic_fmin_f64_rtn(ptr addrspace(1) %ptr, double %data) {
; GFX10-LABEL: global_atomic_fmin_f64_rtn:
; GFX10:       ; %bb.0: ; %main_body
; GFX10-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX10-NEXT:    s_waitcnt_vscnt null, 0x0
; GFX10-NEXT:    global_atomic_fmin_x2 v[0:1], v[0:1], v[2:3], off glc
; GFX10-NEXT:    s_waitcnt vmcnt(0)
; GFX10-NEXT:    s_setpc_b64 s[30:31]
;
; G_GFX10-LABEL: global_atomic_fmin_f64_rtn:
; G_GFX10:       ; %bb.0: ; %main_body
; G_GFX10-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; G_GFX10-NEXT:    s_waitcnt_vscnt null, 0x0
; G_GFX10-NEXT:    global_atomic_fmin_x2 v[0:1], v[0:1], v[2:3], off glc
; G_GFX10-NEXT:    s_waitcnt vmcnt(0)
; G_GFX10-NEXT:    s_setpc_b64 s[30:31]
main_body:
  %ret = call double @llvm.amdgcn.global.atomic.fmin.f64.p1.f64(ptr addrspace(1) %ptr, double %data)
  ret double %ret
}
