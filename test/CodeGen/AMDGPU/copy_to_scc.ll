; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -march=amdgcn -mcpu=gfx900 -verify-machineinstrs < %s | FileCheck -check-prefix=GCN %s

define amdgpu_kernel void @copy_to_scc(ptr addrspace(1) %out, ptr addrspace(1) %in, ptr addrspace(4) %addrSrc) {
; GCN-LABEL: copy_to_scc:
; GCN:       ; %bb.0: ; %entry
; GCN-NEXT:    s_load_dwordx2 s[2:3], s[0:1], 0x34
; GCN-NEXT:    v_mov_b32_e32 v1, 0
; GCN-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-NEXT:    s_load_dwordx4 s[4:7], s[2:3], 0x0
; GCN-NEXT:    s_nop 0
; GCN-NEXT:    s_load_dwordx4 s[0:3], s[0:1], 0x24
; GCN-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-NEXT:    buffer_load_dword v0, off, s[4:7], 0 offset:252
; GCN-NEXT:    s_load_dword s2, s[2:3], 0x0
; GCN-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-NEXT:    s_cmp_lg_u32 s2, 0
; GCN-NEXT:    s_cselect_b64 s[2:3], -1, 0
; GCN-NEXT:    s_waitcnt vmcnt(0)
; GCN-NEXT:    v_cmp_ne_u32_e32 vcc, 0, v0
; GCN-NEXT:    s_xor_b64 s[2:3], s[2:3], vcc
; GCN-NEXT:    s_and_b64 s[2:3], s[2:3], exec
; GCN-NEXT:    s_cselect_b32 s2, 2, 3
; GCN-NEXT:    v_mov_b32_e32 v0, s2
; GCN-NEXT:    global_store_dword v1, v0, s[0:1]
; GCN-NEXT:    s_endpgm
entry:                                             ; preds = %1009
  %0 = load i32, ptr addrspace(1) %in, align 4
  %1 = load <4 x i32>, ptr addrspace(4) %addrSrc, align 16
  %2 = icmp ne i32 %0, 0
  %3 = call i32 @llvm.amdgcn.raw.buffer.load.i32(<4 x i32> %1, i32 252, i32 0, i32 0)
  %4 = icmp ne i32 %3, 0
  %5 = xor i1 %2, %4
  %result = select i1 %5, i32 2, i32 3
  store i32 %result, ptr addrspace(1) %out
  ret void
}

declare i32 @llvm.amdgcn.raw.buffer.load.i32(<4 x i32>, i32, i32, i32 immarg)
