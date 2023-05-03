; NOTE: Assertions have been autogenerated by utils/update_mir_test_checks.py
; RUN: llc -march=amdgcn -mcpu=gfx90a -verify-machineinstrs -stop-after=amdgpu-isel < %s | FileCheck -check-prefix=GFX90A_GFX940 %s
; RUN: llc -march=amdgcn -mcpu=gfx940 -verify-machineinstrs -stop-after=amdgpu-isel < %s | FileCheck -check-prefix=GFX90A_GFX940 %s

define amdgpu_ps <2 x half> @buffer_atomic_fadd_v2f16_offset_rtn(<2 x half> %val, <4 x i32> inreg %rsrc, i32 inreg %soffset) {
  ; GFX90A_GFX940-LABEL: name: buffer_atomic_fadd_v2f16_offset_rtn
  ; GFX90A_GFX940: bb.0 (%ir-block.0):
  ; GFX90A_GFX940-NEXT:   liveins: $vgpr0, $sgpr0, $sgpr1, $sgpr2, $sgpr3, $sgpr4
  ; GFX90A_GFX940-NEXT: {{  $}}
  ; GFX90A_GFX940-NEXT:   [[COPY:%[0-9]+]]:sgpr_32 = COPY $sgpr4
  ; GFX90A_GFX940-NEXT:   [[COPY1:%[0-9]+]]:sgpr_32 = COPY $sgpr3
  ; GFX90A_GFX940-NEXT:   [[COPY2:%[0-9]+]]:sgpr_32 = COPY $sgpr2
  ; GFX90A_GFX940-NEXT:   [[COPY3:%[0-9]+]]:sgpr_32 = COPY $sgpr1
  ; GFX90A_GFX940-NEXT:   [[COPY4:%[0-9]+]]:sgpr_32 = COPY $sgpr0
  ; GFX90A_GFX940-NEXT:   [[COPY5:%[0-9]+]]:vgpr_32 = COPY $vgpr0
  ; GFX90A_GFX940-NEXT:   [[REG_SEQUENCE:%[0-9]+]]:sgpr_128 = REG_SEQUENCE [[COPY4]], %subreg.sub0, [[COPY3]], %subreg.sub1, [[COPY2]], %subreg.sub2, [[COPY1]], %subreg.sub3
  ; GFX90A_GFX940-NEXT:   [[BUFFER_ATOMIC_PK_ADD_F16_OFFSET_RTN:%[0-9]+]]:vgpr_32 = BUFFER_ATOMIC_PK_ADD_F16_OFFSET_RTN [[COPY5]], killed [[REG_SEQUENCE]], [[COPY]], 0, 1, implicit $exec :: (volatile dereferenceable load store (s32), align 1, addrspace 7)
  ; GFX90A_GFX940-NEXT:   $vgpr0 = COPY [[BUFFER_ATOMIC_PK_ADD_F16_OFFSET_RTN]]
  ; GFX90A_GFX940-NEXT:   SI_RETURN_TO_EPILOG $vgpr0
  %ret = call <2 x half> @llvm.amdgcn.raw.buffer.atomic.fadd.v2f16(<2 x half> %val, <4 x i32> %rsrc, i32 0, i32 %soffset, i32 0)
  ret <2 x half> %ret
}

define amdgpu_ps <2 x half> @buffer_atomic_fadd_v2f16_offen_rtn(<2 x half> %val, <4 x i32> inreg %rsrc, i32 %voffset, i32 inreg %soffset) {
  ; GFX90A_GFX940-LABEL: name: buffer_atomic_fadd_v2f16_offen_rtn
  ; GFX90A_GFX940: bb.0 (%ir-block.0):
  ; GFX90A_GFX940-NEXT:   liveins: $vgpr0, $sgpr0, $sgpr1, $sgpr2, $sgpr3, $vgpr1, $sgpr4
  ; GFX90A_GFX940-NEXT: {{  $}}
  ; GFX90A_GFX940-NEXT:   [[COPY:%[0-9]+]]:sgpr_32 = COPY $sgpr4
  ; GFX90A_GFX940-NEXT:   [[COPY1:%[0-9]+]]:vgpr_32 = COPY $vgpr1
  ; GFX90A_GFX940-NEXT:   [[COPY2:%[0-9]+]]:sgpr_32 = COPY $sgpr3
  ; GFX90A_GFX940-NEXT:   [[COPY3:%[0-9]+]]:sgpr_32 = COPY $sgpr2
  ; GFX90A_GFX940-NEXT:   [[COPY4:%[0-9]+]]:sgpr_32 = COPY $sgpr1
  ; GFX90A_GFX940-NEXT:   [[COPY5:%[0-9]+]]:sgpr_32 = COPY $sgpr0
  ; GFX90A_GFX940-NEXT:   [[COPY6:%[0-9]+]]:vgpr_32 = COPY $vgpr0
  ; GFX90A_GFX940-NEXT:   [[REG_SEQUENCE:%[0-9]+]]:sgpr_128 = REG_SEQUENCE [[COPY5]], %subreg.sub0, [[COPY4]], %subreg.sub1, [[COPY3]], %subreg.sub2, [[COPY2]], %subreg.sub3
  ; GFX90A_GFX940-NEXT:   [[BUFFER_ATOMIC_PK_ADD_F16_OFFEN_RTN:%[0-9]+]]:vgpr_32 = BUFFER_ATOMIC_PK_ADD_F16_OFFEN_RTN [[COPY6]], [[COPY1]], killed [[REG_SEQUENCE]], [[COPY]], 0, 1, implicit $exec :: (volatile dereferenceable load store (s32), align 1, addrspace 7)
  ; GFX90A_GFX940-NEXT:   $vgpr0 = COPY [[BUFFER_ATOMIC_PK_ADD_F16_OFFEN_RTN]]
  ; GFX90A_GFX940-NEXT:   SI_RETURN_TO_EPILOG $vgpr0
  %ret = call <2 x half> @llvm.amdgcn.raw.buffer.atomic.fadd.v2f16(<2 x half> %val, <4 x i32> %rsrc, i32 %voffset, i32 %soffset, i32 0)
  ret <2 x half> %ret
}

define amdgpu_ps <2 x half> @buffer_atomic_fadd_v2f16_idxen_rtn(<2 x half> %val, <4 x i32> inreg %rsrc, i32 %vindex, i32 inreg %soffset) {
  ; GFX90A_GFX940-LABEL: name: buffer_atomic_fadd_v2f16_idxen_rtn
  ; GFX90A_GFX940: bb.0 (%ir-block.0):
  ; GFX90A_GFX940-NEXT:   liveins: $vgpr0, $sgpr0, $sgpr1, $sgpr2, $sgpr3, $vgpr1, $sgpr4
  ; GFX90A_GFX940-NEXT: {{  $}}
  ; GFX90A_GFX940-NEXT:   [[COPY:%[0-9]+]]:sgpr_32 = COPY $sgpr4
  ; GFX90A_GFX940-NEXT:   [[COPY1:%[0-9]+]]:vgpr_32 = COPY $vgpr1
  ; GFX90A_GFX940-NEXT:   [[COPY2:%[0-9]+]]:sgpr_32 = COPY $sgpr3
  ; GFX90A_GFX940-NEXT:   [[COPY3:%[0-9]+]]:sgpr_32 = COPY $sgpr2
  ; GFX90A_GFX940-NEXT:   [[COPY4:%[0-9]+]]:sgpr_32 = COPY $sgpr1
  ; GFX90A_GFX940-NEXT:   [[COPY5:%[0-9]+]]:sgpr_32 = COPY $sgpr0
  ; GFX90A_GFX940-NEXT:   [[COPY6:%[0-9]+]]:vgpr_32 = COPY $vgpr0
  ; GFX90A_GFX940-NEXT:   [[REG_SEQUENCE:%[0-9]+]]:sgpr_128 = REG_SEQUENCE [[COPY5]], %subreg.sub0, [[COPY4]], %subreg.sub1, [[COPY3]], %subreg.sub2, [[COPY2]], %subreg.sub3
  ; GFX90A_GFX940-NEXT:   [[BUFFER_ATOMIC_PK_ADD_F16_IDXEN_RTN:%[0-9]+]]:vgpr_32 = BUFFER_ATOMIC_PK_ADD_F16_IDXEN_RTN [[COPY6]], [[COPY1]], killed [[REG_SEQUENCE]], [[COPY]], 0, 1, implicit $exec :: (volatile dereferenceable load store (s32), align 1, addrspace 7)
  ; GFX90A_GFX940-NEXT:   $vgpr0 = COPY [[BUFFER_ATOMIC_PK_ADD_F16_IDXEN_RTN]]
  ; GFX90A_GFX940-NEXT:   SI_RETURN_TO_EPILOG $vgpr0
  %ret = call <2 x half> @llvm.amdgcn.struct.buffer.atomic.fadd.v2f16(<2 x half> %val, <4 x i32> %rsrc, i32 %vindex, i32 0, i32 %soffset, i32 0)
  ret <2 x half> %ret
}

define amdgpu_ps <2 x half> @buffer_atomic_fadd_v2f16_bothen_rtn(<2 x half> %val, <4 x i32> inreg %rsrc, i32 %vindex, i32 %voffset, i32 inreg %soffset) {
  ; GFX90A_GFX940-LABEL: name: buffer_atomic_fadd_v2f16_bothen_rtn
  ; GFX90A_GFX940: bb.0 (%ir-block.0):
  ; GFX90A_GFX940-NEXT:   liveins: $vgpr0, $sgpr0, $sgpr1, $sgpr2, $sgpr3, $vgpr1, $vgpr2, $sgpr4
  ; GFX90A_GFX940-NEXT: {{  $}}
  ; GFX90A_GFX940-NEXT:   [[COPY:%[0-9]+]]:sgpr_32 = COPY $sgpr4
  ; GFX90A_GFX940-NEXT:   [[COPY1:%[0-9]+]]:vgpr_32 = COPY $vgpr2
  ; GFX90A_GFX940-NEXT:   [[COPY2:%[0-9]+]]:vgpr_32 = COPY $vgpr1
  ; GFX90A_GFX940-NEXT:   [[COPY3:%[0-9]+]]:sgpr_32 = COPY $sgpr3
  ; GFX90A_GFX940-NEXT:   [[COPY4:%[0-9]+]]:sgpr_32 = COPY $sgpr2
  ; GFX90A_GFX940-NEXT:   [[COPY5:%[0-9]+]]:sgpr_32 = COPY $sgpr1
  ; GFX90A_GFX940-NEXT:   [[COPY6:%[0-9]+]]:sgpr_32 = COPY $sgpr0
  ; GFX90A_GFX940-NEXT:   [[COPY7:%[0-9]+]]:vgpr_32 = COPY $vgpr0
  ; GFX90A_GFX940-NEXT:   [[REG_SEQUENCE:%[0-9]+]]:sgpr_128 = REG_SEQUENCE [[COPY6]], %subreg.sub0, [[COPY5]], %subreg.sub1, [[COPY4]], %subreg.sub2, [[COPY3]], %subreg.sub3
  ; GFX90A_GFX940-NEXT:   [[REG_SEQUENCE1:%[0-9]+]]:vreg_64_align2 = REG_SEQUENCE [[COPY2]], %subreg.sub0, [[COPY1]], %subreg.sub1
  ; GFX90A_GFX940-NEXT:   [[BUFFER_ATOMIC_PK_ADD_F16_BOTHEN_RTN:%[0-9]+]]:vgpr_32 = BUFFER_ATOMIC_PK_ADD_F16_BOTHEN_RTN [[COPY7]], killed [[REG_SEQUENCE1]], killed [[REG_SEQUENCE]], [[COPY]], 0, 3, implicit $exec :: (volatile dereferenceable load store (s32), align 1, addrspace 7)
  ; GFX90A_GFX940-NEXT:   $vgpr0 = COPY [[BUFFER_ATOMIC_PK_ADD_F16_BOTHEN_RTN]]
  ; GFX90A_GFX940-NEXT:   SI_RETURN_TO_EPILOG $vgpr0
  %ret = call <2 x half> @llvm.amdgcn.struct.buffer.atomic.fadd.v2f16(<2 x half> %val, <4 x i32> %rsrc, i32 %vindex, i32 %voffset, i32 %soffset, i32 2)
  ret <2 x half> %ret
}

declare <2 x half> @llvm.amdgcn.raw.buffer.atomic.fadd.v2f16(<2 x half>, <4 x i32>, i32, i32, i32 immarg)
declare <2 x half> @llvm.amdgcn.struct.buffer.atomic.fadd.v2f16(<2 x half>, <4 x i32>, i32, i32, i32, i32 immarg)
