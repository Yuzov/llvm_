; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=x86_64-linux-gnu -mattr=+sse2 | FileCheck %s --check-prefix=SSE2
; RUN: llc < %s -mtriple=x86_64-linux-gnu -mattr=+sse4.1 | FileCheck %s --check-prefixes=SSE41
; RUN: llc < %s -mtriple=x86_64-unknown-freebsd -mattr=+avx | FileCheck %s --check-prefixes=AVX1
; RUN: llc < %s -mtriple=x86_64-linux-gnu -mattr=+avx512f,+avx512vl | FileCheck %s --check-prefixes=AVX512F
; RUN: llc < %s -mtriple=x86_64-apple-darwin -mattr=+avx512fp16,+avx512vl | FileCheck %s --check-prefixes=AVX512FP16

define half @round_f16(half %h) {
; SSE2-LABEL: round_f16:
; SSE2:       # %bb.0: # %entry
; SSE2-NEXT:    pushq %rax
; SSE2-NEXT:    .cfi_def_cfa_offset 16
; SSE2-NEXT:    callq __extendhfsf2@PLT
; SSE2-NEXT:    callq roundf@PLT
; SSE2-NEXT:    callq __truncsfhf2@PLT
; SSE2-NEXT:    popq %rax
; SSE2-NEXT:    .cfi_def_cfa_offset 8
; SSE2-NEXT:    retq
;
; SSE41-LABEL: round_f16:
; SSE41:       # %bb.0: # %entry
; SSE41-NEXT:    pushq %rax
; SSE41-NEXT:    .cfi_def_cfa_offset 16
; SSE41-NEXT:    callq __extendhfsf2@PLT
; SSE41-NEXT:    movaps {{.*#+}} xmm1 = [-0.0E+0,-0.0E+0,-0.0E+0,-0.0E+0]
; SSE41-NEXT:    andps %xmm0, %xmm1
; SSE41-NEXT:    orps {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm1
; SSE41-NEXT:    addss %xmm0, %xmm1
; SSE41-NEXT:    xorps %xmm0, %xmm0
; SSE41-NEXT:    roundss $11, %xmm1, %xmm0
; SSE41-NEXT:    callq __truncsfhf2@PLT
; SSE41-NEXT:    popq %rax
; SSE41-NEXT:    .cfi_def_cfa_offset 8
; SSE41-NEXT:    retq
;
; AVX1-LABEL: round_f16:
; AVX1:       # %bb.0: # %entry
; AVX1-NEXT:    pushq %rax
; AVX1-NEXT:    .cfi_def_cfa_offset 16
; AVX1-NEXT:    callq __extendhfsf2@PLT
; AVX1-NEXT:    vandps {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0, %xmm1
; AVX1-NEXT:    vbroadcastss {{.*#+}} xmm2 = [4.9999997E-1,4.9999997E-1,4.9999997E-1,4.9999997E-1]
; AVX1-NEXT:    vorps %xmm2, %xmm1, %xmm1
; AVX1-NEXT:    vaddss %xmm1, %xmm0, %xmm0
; AVX1-NEXT:    vroundss $11, %xmm0, %xmm0, %xmm0
; AVX1-NEXT:    callq __truncsfhf2@PLT
; AVX1-NEXT:    popq %rax
; AVX1-NEXT:    .cfi_def_cfa_offset 8
; AVX1-NEXT:    retq
;
; AVX512F-LABEL: round_f16:
; AVX512F:       # %bb.0: # %entry
; AVX512F-NEXT:    vpextrw $0, %xmm0, %eax
; AVX512F-NEXT:    movzwl %ax, %eax
; AVX512F-NEXT:    vmovd %eax, %xmm0
; AVX512F-NEXT:    vcvtph2ps %xmm0, %xmm0
; AVX512F-NEXT:    vpbroadcastd {{.*#+}} xmm1 = [4.9999997E-1,4.9999997E-1,4.9999997E-1,4.9999997E-1]
; AVX512F-NEXT:    vpternlogd $248, {{\.?LCPI[0-9]+_[0-9]+}}(%rip){1to4}, %xmm0, %xmm1
; AVX512F-NEXT:    vaddss %xmm1, %xmm0, %xmm0
; AVX512F-NEXT:    vroundss $11, %xmm0, %xmm0, %xmm0
; AVX512F-NEXT:    vcvtps2ph $4, %xmm0, %xmm0
; AVX512F-NEXT:    vmovd %xmm0, %eax
; AVX512F-NEXT:    vpinsrw $0, %eax, %xmm0, %xmm0
; AVX512F-NEXT:    retq
;
; AVX512FP16-LABEL: round_f16:
; AVX512FP16:       ## %bb.0: ## %entry
; AVX512FP16-NEXT:    vpbroadcastw {{.*#+}} xmm1 = [-0.0E+0,-0.0E+0,-0.0E+0,-0.0E+0,-0.0E+0,-0.0E+0,-0.0E+0,-0.0E+0]
; AVX512FP16-NEXT:    vpbroadcastw {{.*#+}} xmm2 = [4.9976E-1,4.9976E-1,4.9976E-1,4.9976E-1,4.9976E-1,4.9976E-1,4.9976E-1,4.9976E-1]
; AVX512FP16-NEXT:    vpternlogq $248, %xmm1, %xmm0, %xmm2
; AVX512FP16-NEXT:    vaddsh %xmm2, %xmm0, %xmm0
; AVX512FP16-NEXT:    vrndscalesh $11, %xmm0, %xmm0, %xmm0
; AVX512FP16-NEXT:    retq
entry:
  %a = call half @llvm.round.f16(half %h)
  ret half %a
}

define float @round_f32(float %x) {
; SSE2-LABEL: round_f32:
; SSE2:       # %bb.0:
; SSE2-NEXT:    jmp roundf@PLT # TAILCALL
;
; SSE41-LABEL: round_f32:
; SSE41:       # %bb.0:
; SSE41-NEXT:    movaps {{.*#+}} xmm1 = [-0.0E+0,-0.0E+0,-0.0E+0,-0.0E+0]
; SSE41-NEXT:    andps %xmm0, %xmm1
; SSE41-NEXT:    orps {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm1
; SSE41-NEXT:    addss %xmm0, %xmm1
; SSE41-NEXT:    xorps %xmm0, %xmm0
; SSE41-NEXT:    roundss $11, %xmm1, %xmm0
; SSE41-NEXT:    retq
;
; AVX1-LABEL: round_f32:
; AVX1:       # %bb.0:
; AVX1-NEXT:    vandps {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0, %xmm1
; AVX1-NEXT:    vbroadcastss {{.*#+}} xmm2 = [4.9999997E-1,4.9999997E-1,4.9999997E-1,4.9999997E-1]
; AVX1-NEXT:    vorps %xmm2, %xmm1, %xmm1
; AVX1-NEXT:    vaddss %xmm1, %xmm0, %xmm0
; AVX1-NEXT:    vroundss $11, %xmm0, %xmm0, %xmm0
; AVX1-NEXT:    retq
;
; AVX512F-LABEL: round_f32:
; AVX512F:       # %bb.0:
; AVX512F-NEXT:    vpbroadcastd {{.*#+}} xmm1 = [4.9999997E-1,4.9999997E-1,4.9999997E-1,4.9999997E-1]
; AVX512F-NEXT:    vpternlogd $248, {{\.?LCPI[0-9]+_[0-9]+}}(%rip){1to4}, %xmm0, %xmm1
; AVX512F-NEXT:    vaddss %xmm1, %xmm0, %xmm0
; AVX512F-NEXT:    vroundss $11, %xmm0, %xmm0, %xmm0
; AVX512F-NEXT:    retq
;
; AVX512FP16-LABEL: round_f32:
; AVX512FP16:       ## %bb.0:
; AVX512FP16-NEXT:    vpbroadcastd {{.*#+}} xmm1 = [4.9999997E-1,4.9999997E-1,4.9999997E-1,4.9999997E-1]
; AVX512FP16-NEXT:    vpternlogd $248, {{\.?LCPI[0-9]+_[0-9]+}}(%rip){1to4}, %xmm0, %xmm1
; AVX512FP16-NEXT:    vaddss %xmm1, %xmm0, %xmm0
; AVX512FP16-NEXT:    vroundss $11, %xmm0, %xmm0, %xmm0
; AVX512FP16-NEXT:    retq
  %a = call float @llvm.round.f32(float %x)
  ret float %a
}

define double @round_f64(double %x) {
; SSE2-LABEL: round_f64:
; SSE2:       # %bb.0:
; SSE2-NEXT:    jmp round@PLT # TAILCALL
;
; SSE41-LABEL: round_f64:
; SSE41:       # %bb.0:
; SSE41-NEXT:    movapd {{.*#+}} xmm1 = [-0.0E+0,-0.0E+0]
; SSE41-NEXT:    andpd %xmm0, %xmm1
; SSE41-NEXT:    orpd {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm1
; SSE41-NEXT:    addsd %xmm0, %xmm1
; SSE41-NEXT:    xorps %xmm0, %xmm0
; SSE41-NEXT:    roundsd $11, %xmm1, %xmm0
; SSE41-NEXT:    retq
;
; AVX1-LABEL: round_f64:
; AVX1:       # %bb.0:
; AVX1-NEXT:    vandpd {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0, %xmm1
; AVX1-NEXT:    vmovddup {{.*#+}} xmm2 = [4.9999999999999994E-1,4.9999999999999994E-1]
; AVX1-NEXT:    # xmm2 = mem[0,0]
; AVX1-NEXT:    vorpd %xmm2, %xmm1, %xmm1
; AVX1-NEXT:    vaddsd %xmm1, %xmm0, %xmm0
; AVX1-NEXT:    vroundsd $11, %xmm0, %xmm0, %xmm0
; AVX1-NEXT:    retq
;
; AVX512F-LABEL: round_f64:
; AVX512F:       # %bb.0:
; AVX512F-NEXT:    vpbroadcastq {{.*#+}} xmm1 = [4.9999999999999994E-1,4.9999999999999994E-1]
; AVX512F-NEXT:    vpternlogq $248, {{\.?LCPI[0-9]+_[0-9]+}}(%rip){1to2}, %xmm0, %xmm1
; AVX512F-NEXT:    vaddsd %xmm1, %xmm0, %xmm0
; AVX512F-NEXT:    vroundsd $11, %xmm0, %xmm0, %xmm0
; AVX512F-NEXT:    retq
;
; AVX512FP16-LABEL: round_f64:
; AVX512FP16:       ## %bb.0:
; AVX512FP16-NEXT:    vpbroadcastq {{.*#+}} xmm1 = [4.9999999999999994E-1,4.9999999999999994E-1]
; AVX512FP16-NEXT:    vpternlogq $248, {{\.?LCPI[0-9]+_[0-9]+}}(%rip){1to2}, %xmm0, %xmm1
; AVX512FP16-NEXT:    vaddsd %xmm1, %xmm0, %xmm0
; AVX512FP16-NEXT:    vroundsd $11, %xmm0, %xmm0, %xmm0
; AVX512FP16-NEXT:    retq
  %a = call double @llvm.round.f64(double %x)
  ret double %a
}

define <4 x float> @round_v4f32(<4 x float> %x) {
; SSE2-LABEL: round_v4f32:
; SSE2:       # %bb.0:
; SSE2-NEXT:    subq $56, %rsp
; SSE2-NEXT:    .cfi_def_cfa_offset 64
; SSE2-NEXT:    movaps %xmm0, {{[-0-9]+}}(%r{{[sb]}}p) # 16-byte Spill
; SSE2-NEXT:    shufps {{.*#+}} xmm0 = xmm0[3,3,3,3]
; SSE2-NEXT:    callq roundf@PLT
; SSE2-NEXT:    movaps %xmm0, (%rsp) # 16-byte Spill
; SSE2-NEXT:    movaps {{[-0-9]+}}(%r{{[sb]}}p), %xmm0 # 16-byte Reload
; SSE2-NEXT:    movhlps {{.*#+}} xmm0 = xmm0[1,1]
; SSE2-NEXT:    callq roundf@PLT
; SSE2-NEXT:    unpcklps (%rsp), %xmm0 # 16-byte Folded Reload
; SSE2-NEXT:    # xmm0 = xmm0[0],mem[0],xmm0[1],mem[1]
; SSE2-NEXT:    movaps %xmm0, (%rsp) # 16-byte Spill
; SSE2-NEXT:    movaps {{[-0-9]+}}(%r{{[sb]}}p), %xmm0 # 16-byte Reload
; SSE2-NEXT:    callq roundf@PLT
; SSE2-NEXT:    movaps %xmm0, {{[-0-9]+}}(%r{{[sb]}}p) # 16-byte Spill
; SSE2-NEXT:    movaps {{[-0-9]+}}(%r{{[sb]}}p), %xmm0 # 16-byte Reload
; SSE2-NEXT:    shufps {{.*#+}} xmm0 = xmm0[1,1,1,1]
; SSE2-NEXT:    callq roundf@PLT
; SSE2-NEXT:    movaps {{[-0-9]+}}(%r{{[sb]}}p), %xmm1 # 16-byte Reload
; SSE2-NEXT:    unpcklps {{.*#+}} xmm1 = xmm1[0],xmm0[0],xmm1[1],xmm0[1]
; SSE2-NEXT:    unpcklpd (%rsp), %xmm1 # 16-byte Folded Reload
; SSE2-NEXT:    # xmm1 = xmm1[0],mem[0]
; SSE2-NEXT:    movaps %xmm1, %xmm0
; SSE2-NEXT:    addq $56, %rsp
; SSE2-NEXT:    .cfi_def_cfa_offset 8
; SSE2-NEXT:    retq
;
; SSE41-LABEL: round_v4f32:
; SSE41:       # %bb.0:
; SSE41-NEXT:    movaps {{.*#+}} xmm1 = [-0.0E+0,-0.0E+0,-0.0E+0,-0.0E+0]
; SSE41-NEXT:    andps %xmm0, %xmm1
; SSE41-NEXT:    orps {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm1
; SSE41-NEXT:    addps %xmm0, %xmm1
; SSE41-NEXT:    roundps $11, %xmm1, %xmm0
; SSE41-NEXT:    retq
;
; AVX1-LABEL: round_v4f32:
; AVX1:       # %bb.0:
; AVX1-NEXT:    vandps {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0, %xmm1
; AVX1-NEXT:    vorps {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm1, %xmm1
; AVX1-NEXT:    vaddps %xmm1, %xmm0, %xmm0
; AVX1-NEXT:    vroundps $11, %xmm0, %xmm0
; AVX1-NEXT:    retq
;
; AVX512F-LABEL: round_v4f32:
; AVX512F:       # %bb.0:
; AVX512F-NEXT:    vpbroadcastd {{.*#+}} xmm1 = [4.9999997E-1,4.9999997E-1,4.9999997E-1,4.9999997E-1]
; AVX512F-NEXT:    vpternlogd $248, {{\.?LCPI[0-9]+_[0-9]+}}(%rip){1to4}, %xmm0, %xmm1
; AVX512F-NEXT:    vaddps %xmm1, %xmm0, %xmm0
; AVX512F-NEXT:    vroundps $11, %xmm0, %xmm0
; AVX512F-NEXT:    retq
;
; AVX512FP16-LABEL: round_v4f32:
; AVX512FP16:       ## %bb.0:
; AVX512FP16-NEXT:    vpbroadcastd {{.*#+}} xmm1 = [4.9999997E-1,4.9999997E-1,4.9999997E-1,4.9999997E-1]
; AVX512FP16-NEXT:    vpternlogd $248, {{\.?LCPI[0-9]+_[0-9]+}}(%rip){1to4}, %xmm0, %xmm1
; AVX512FP16-NEXT:    vaddps %xmm1, %xmm0, %xmm0
; AVX512FP16-NEXT:    vroundps $11, %xmm0, %xmm0
; AVX512FP16-NEXT:    retq
  %a = call <4 x float> @llvm.round.v4f32(<4 x float> %x)
  ret <4 x float> %a
}

define <2 x double> @round_v2f64(<2 x double> %x) {
; SSE2-LABEL: round_v2f64:
; SSE2:       # %bb.0:
; SSE2-NEXT:    subq $40, %rsp
; SSE2-NEXT:    .cfi_def_cfa_offset 48
; SSE2-NEXT:    movaps %xmm0, (%rsp) # 16-byte Spill
; SSE2-NEXT:    callq round@PLT
; SSE2-NEXT:    movaps %xmm0, {{[-0-9]+}}(%r{{[sb]}}p) # 16-byte Spill
; SSE2-NEXT:    movaps (%rsp), %xmm0 # 16-byte Reload
; SSE2-NEXT:    movhlps {{.*#+}} xmm0 = xmm0[1,1]
; SSE2-NEXT:    callq round@PLT
; SSE2-NEXT:    movaps {{[-0-9]+}}(%r{{[sb]}}p), %xmm1 # 16-byte Reload
; SSE2-NEXT:    movlhps {{.*#+}} xmm1 = xmm1[0],xmm0[0]
; SSE2-NEXT:    movaps %xmm1, %xmm0
; SSE2-NEXT:    addq $40, %rsp
; SSE2-NEXT:    .cfi_def_cfa_offset 8
; SSE2-NEXT:    retq
;
; SSE41-LABEL: round_v2f64:
; SSE41:       # %bb.0:
; SSE41-NEXT:    movapd {{.*#+}} xmm1 = [-0.0E+0,-0.0E+0]
; SSE41-NEXT:    andpd %xmm0, %xmm1
; SSE41-NEXT:    orpd {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm1
; SSE41-NEXT:    addpd %xmm0, %xmm1
; SSE41-NEXT:    roundpd $11, %xmm1, %xmm0
; SSE41-NEXT:    retq
;
; AVX1-LABEL: round_v2f64:
; AVX1:       # %bb.0:
; AVX1-NEXT:    vandpd {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0, %xmm1
; AVX1-NEXT:    vorpd {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm1, %xmm1
; AVX1-NEXT:    vaddpd %xmm1, %xmm0, %xmm0
; AVX1-NEXT:    vroundpd $11, %xmm0, %xmm0
; AVX1-NEXT:    retq
;
; AVX512F-LABEL: round_v2f64:
; AVX512F:       # %bb.0:
; AVX512F-NEXT:    vpbroadcastq {{.*#+}} xmm1 = [4.9999999999999994E-1,4.9999999999999994E-1]
; AVX512F-NEXT:    vpternlogq $248, {{\.?LCPI[0-9]+_[0-9]+}}(%rip){1to2}, %xmm0, %xmm1
; AVX512F-NEXT:    vaddpd %xmm1, %xmm0, %xmm0
; AVX512F-NEXT:    vroundpd $11, %xmm0, %xmm0
; AVX512F-NEXT:    retq
;
; AVX512FP16-LABEL: round_v2f64:
; AVX512FP16:       ## %bb.0:
; AVX512FP16-NEXT:    vpbroadcastq {{.*#+}} xmm1 = [4.9999999999999994E-1,4.9999999999999994E-1]
; AVX512FP16-NEXT:    vpternlogq $248, {{\.?LCPI[0-9]+_[0-9]+}}(%rip){1to2}, %xmm0, %xmm1
; AVX512FP16-NEXT:    vaddpd %xmm1, %xmm0, %xmm0
; AVX512FP16-NEXT:    vroundpd $11, %xmm0, %xmm0
; AVX512FP16-NEXT:    retq
  %a = call <2 x double> @llvm.round.v2f64(<2 x double> %x)
  ret <2 x double> %a
}

define <8 x float> @round_v8f32(<8 x float> %x) {
; SSE2-LABEL: round_v8f32:
; SSE2:       # %bb.0:
; SSE2-NEXT:    subq $72, %rsp
; SSE2-NEXT:    .cfi_def_cfa_offset 80
; SSE2-NEXT:    movaps %xmm1, {{[-0-9]+}}(%r{{[sb]}}p) # 16-byte Spill
; SSE2-NEXT:    movaps %xmm0, (%rsp) # 16-byte Spill
; SSE2-NEXT:    shufps {{.*#+}} xmm0 = xmm0[3,3,3,3]
; SSE2-NEXT:    callq roundf@PLT
; SSE2-NEXT:    movaps %xmm0, {{[-0-9]+}}(%r{{[sb]}}p) # 16-byte Spill
; SSE2-NEXT:    movaps (%rsp), %xmm0 # 16-byte Reload
; SSE2-NEXT:    movhlps {{.*#+}} xmm0 = xmm0[1,1]
; SSE2-NEXT:    callq roundf@PLT
; SSE2-NEXT:    unpcklps {{[-0-9]+}}(%r{{[sb]}}p), %xmm0 # 16-byte Folded Reload
; SSE2-NEXT:    # xmm0 = xmm0[0],mem[0],xmm0[1],mem[1]
; SSE2-NEXT:    movaps %xmm0, {{[-0-9]+}}(%r{{[sb]}}p) # 16-byte Spill
; SSE2-NEXT:    movaps (%rsp), %xmm0 # 16-byte Reload
; SSE2-NEXT:    callq roundf@PLT
; SSE2-NEXT:    movaps %xmm0, {{[-0-9]+}}(%r{{[sb]}}p) # 16-byte Spill
; SSE2-NEXT:    movaps (%rsp), %xmm0 # 16-byte Reload
; SSE2-NEXT:    shufps {{.*#+}} xmm0 = xmm0[1,1,1,1]
; SSE2-NEXT:    callq roundf@PLT
; SSE2-NEXT:    movaps {{[-0-9]+}}(%r{{[sb]}}p), %xmm1 # 16-byte Reload
; SSE2-NEXT:    unpcklps {{.*#+}} xmm1 = xmm1[0],xmm0[0],xmm1[1],xmm0[1]
; SSE2-NEXT:    unpcklpd {{[-0-9]+}}(%r{{[sb]}}p), %xmm1 # 16-byte Folded Reload
; SSE2-NEXT:    # xmm1 = xmm1[0],mem[0]
; SSE2-NEXT:    movaps %xmm1, {{[-0-9]+}}(%r{{[sb]}}p) # 16-byte Spill
; SSE2-NEXT:    movaps {{[-0-9]+}}(%r{{[sb]}}p), %xmm0 # 16-byte Reload
; SSE2-NEXT:    shufps {{.*#+}} xmm0 = xmm0[3,3,3,3]
; SSE2-NEXT:    callq roundf@PLT
; SSE2-NEXT:    movaps %xmm0, (%rsp) # 16-byte Spill
; SSE2-NEXT:    movaps {{[-0-9]+}}(%r{{[sb]}}p), %xmm0 # 16-byte Reload
; SSE2-NEXT:    movhlps {{.*#+}} xmm0 = xmm0[1,1]
; SSE2-NEXT:    callq roundf@PLT
; SSE2-NEXT:    unpcklps (%rsp), %xmm0 # 16-byte Folded Reload
; SSE2-NEXT:    # xmm0 = xmm0[0],mem[0],xmm0[1],mem[1]
; SSE2-NEXT:    movaps %xmm0, (%rsp) # 16-byte Spill
; SSE2-NEXT:    movaps {{[-0-9]+}}(%r{{[sb]}}p), %xmm0 # 16-byte Reload
; SSE2-NEXT:    callq roundf@PLT
; SSE2-NEXT:    movaps %xmm0, {{[-0-9]+}}(%r{{[sb]}}p) # 16-byte Spill
; SSE2-NEXT:    movaps {{[-0-9]+}}(%r{{[sb]}}p), %xmm0 # 16-byte Reload
; SSE2-NEXT:    shufps {{.*#+}} xmm0 = xmm0[1,1,1,1]
; SSE2-NEXT:    callq roundf@PLT
; SSE2-NEXT:    movaps {{[-0-9]+}}(%r{{[sb]}}p), %xmm1 # 16-byte Reload
; SSE2-NEXT:    unpcklps {{.*#+}} xmm1 = xmm1[0],xmm0[0],xmm1[1],xmm0[1]
; SSE2-NEXT:    unpcklpd (%rsp), %xmm1 # 16-byte Folded Reload
; SSE2-NEXT:    # xmm1 = xmm1[0],mem[0]
; SSE2-NEXT:    movaps {{[-0-9]+}}(%r{{[sb]}}p), %xmm0 # 16-byte Reload
; SSE2-NEXT:    addq $72, %rsp
; SSE2-NEXT:    .cfi_def_cfa_offset 8
; SSE2-NEXT:    retq
;
; SSE41-LABEL: round_v8f32:
; SSE41:       # %bb.0:
; SSE41-NEXT:    movaps {{.*#+}} xmm2 = [-0.0E+0,-0.0E+0,-0.0E+0,-0.0E+0]
; SSE41-NEXT:    movaps %xmm0, %xmm3
; SSE41-NEXT:    andps %xmm2, %xmm3
; SSE41-NEXT:    movaps {{.*#+}} xmm4 = [4.9999997E-1,4.9999997E-1,4.9999997E-1,4.9999997E-1]
; SSE41-NEXT:    orps %xmm4, %xmm3
; SSE41-NEXT:    addps %xmm0, %xmm3
; SSE41-NEXT:    roundps $11, %xmm3, %xmm0
; SSE41-NEXT:    andps %xmm1, %xmm2
; SSE41-NEXT:    orps %xmm4, %xmm2
; SSE41-NEXT:    addps %xmm1, %xmm2
; SSE41-NEXT:    roundps $11, %xmm2, %xmm1
; SSE41-NEXT:    retq
;
; AVX1-LABEL: round_v8f32:
; AVX1:       # %bb.0:
; AVX1-NEXT:    vandps {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %ymm0, %ymm1
; AVX1-NEXT:    vorps {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %ymm1, %ymm1
; AVX1-NEXT:    vaddps %ymm1, %ymm0, %ymm0
; AVX1-NEXT:    vroundps $11, %ymm0, %ymm0
; AVX1-NEXT:    retq
;
; AVX512F-LABEL: round_v8f32:
; AVX512F:       # %bb.0:
; AVX512F-NEXT:    vpbroadcastd {{.*#+}} ymm1 = [4.9999997E-1,4.9999997E-1,4.9999997E-1,4.9999997E-1,4.9999997E-1,4.9999997E-1,4.9999997E-1,4.9999997E-1]
; AVX512F-NEXT:    vpternlogd $248, {{\.?LCPI[0-9]+_[0-9]+}}(%rip){1to8}, %ymm0, %ymm1
; AVX512F-NEXT:    vaddps %ymm1, %ymm0, %ymm0
; AVX512F-NEXT:    vroundps $11, %ymm0, %ymm0
; AVX512F-NEXT:    retq
;
; AVX512FP16-LABEL: round_v8f32:
; AVX512FP16:       ## %bb.0:
; AVX512FP16-NEXT:    vpbroadcastd {{.*#+}} ymm1 = [4.9999997E-1,4.9999997E-1,4.9999997E-1,4.9999997E-1,4.9999997E-1,4.9999997E-1,4.9999997E-1,4.9999997E-1]
; AVX512FP16-NEXT:    vpternlogd $248, {{\.?LCPI[0-9]+_[0-9]+}}(%rip){1to8}, %ymm0, %ymm1
; AVX512FP16-NEXT:    vaddps %ymm1, %ymm0, %ymm0
; AVX512FP16-NEXT:    vroundps $11, %ymm0, %ymm0
; AVX512FP16-NEXT:    retq
  %a = call <8 x float> @llvm.round.v8f32(<8 x float> %x)
  ret <8 x float> %a
}

define <4 x double> @round_v4f64(<4 x double> %x) {
; SSE2-LABEL: round_v4f64:
; SSE2:       # %bb.0:
; SSE2-NEXT:    subq $56, %rsp
; SSE2-NEXT:    .cfi_def_cfa_offset 64
; SSE2-NEXT:    movaps %xmm1, {{[-0-9]+}}(%r{{[sb]}}p) # 16-byte Spill
; SSE2-NEXT:    movaps %xmm0, (%rsp) # 16-byte Spill
; SSE2-NEXT:    callq round@PLT
; SSE2-NEXT:    movaps %xmm0, {{[-0-9]+}}(%r{{[sb]}}p) # 16-byte Spill
; SSE2-NEXT:    movaps (%rsp), %xmm0 # 16-byte Reload
; SSE2-NEXT:    movhlps {{.*#+}} xmm0 = xmm0[1,1]
; SSE2-NEXT:    callq round@PLT
; SSE2-NEXT:    movaps {{[-0-9]+}}(%r{{[sb]}}p), %xmm1 # 16-byte Reload
; SSE2-NEXT:    movlhps {{.*#+}} xmm1 = xmm1[0],xmm0[0]
; SSE2-NEXT:    movaps %xmm1, {{[-0-9]+}}(%r{{[sb]}}p) # 16-byte Spill
; SSE2-NEXT:    movaps {{[-0-9]+}}(%r{{[sb]}}p), %xmm0 # 16-byte Reload
; SSE2-NEXT:    callq round@PLT
; SSE2-NEXT:    movaps %xmm0, (%rsp) # 16-byte Spill
; SSE2-NEXT:    movaps {{[-0-9]+}}(%r{{[sb]}}p), %xmm0 # 16-byte Reload
; SSE2-NEXT:    movhlps {{.*#+}} xmm0 = xmm0[1,1]
; SSE2-NEXT:    callq round@PLT
; SSE2-NEXT:    movaps (%rsp), %xmm1 # 16-byte Reload
; SSE2-NEXT:    movlhps {{.*#+}} xmm1 = xmm1[0],xmm0[0]
; SSE2-NEXT:    movaps {{[-0-9]+}}(%r{{[sb]}}p), %xmm0 # 16-byte Reload
; SSE2-NEXT:    addq $56, %rsp
; SSE2-NEXT:    .cfi_def_cfa_offset 8
; SSE2-NEXT:    retq
;
; SSE41-LABEL: round_v4f64:
; SSE41:       # %bb.0:
; SSE41-NEXT:    movapd {{.*#+}} xmm2 = [-0.0E+0,-0.0E+0]
; SSE41-NEXT:    movapd %xmm0, %xmm3
; SSE41-NEXT:    andpd %xmm2, %xmm3
; SSE41-NEXT:    movapd {{.*#+}} xmm4 = [4.9999999999999994E-1,4.9999999999999994E-1]
; SSE41-NEXT:    orpd %xmm4, %xmm3
; SSE41-NEXT:    addpd %xmm0, %xmm3
; SSE41-NEXT:    roundpd $11, %xmm3, %xmm0
; SSE41-NEXT:    andpd %xmm1, %xmm2
; SSE41-NEXT:    orpd %xmm4, %xmm2
; SSE41-NEXT:    addpd %xmm1, %xmm2
; SSE41-NEXT:    roundpd $11, %xmm2, %xmm1
; SSE41-NEXT:    retq
;
; AVX1-LABEL: round_v4f64:
; AVX1:       # %bb.0:
; AVX1-NEXT:    vandpd {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %ymm0, %ymm1
; AVX1-NEXT:    vorpd {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %ymm1, %ymm1
; AVX1-NEXT:    vaddpd %ymm1, %ymm0, %ymm0
; AVX1-NEXT:    vroundpd $11, %ymm0, %ymm0
; AVX1-NEXT:    retq
;
; AVX512F-LABEL: round_v4f64:
; AVX512F:       # %bb.0:
; AVX512F-NEXT:    vpbroadcastq {{.*#+}} ymm1 = [4.9999999999999994E-1,4.9999999999999994E-1,4.9999999999999994E-1,4.9999999999999994E-1]
; AVX512F-NEXT:    vpternlogq $248, {{\.?LCPI[0-9]+_[0-9]+}}(%rip){1to4}, %ymm0, %ymm1
; AVX512F-NEXT:    vaddpd %ymm1, %ymm0, %ymm0
; AVX512F-NEXT:    vroundpd $11, %ymm0, %ymm0
; AVX512F-NEXT:    retq
;
; AVX512FP16-LABEL: round_v4f64:
; AVX512FP16:       ## %bb.0:
; AVX512FP16-NEXT:    vpbroadcastq {{.*#+}} ymm1 = [4.9999999999999994E-1,4.9999999999999994E-1,4.9999999999999994E-1,4.9999999999999994E-1]
; AVX512FP16-NEXT:    vpternlogq $248, {{\.?LCPI[0-9]+_[0-9]+}}(%rip){1to4}, %ymm0, %ymm1
; AVX512FP16-NEXT:    vaddpd %ymm1, %ymm0, %ymm0
; AVX512FP16-NEXT:    vroundpd $11, %ymm0, %ymm0
; AVX512FP16-NEXT:    retq
  %a = call <4 x double> @llvm.round.v4f64(<4 x double> %x)
  ret <4 x double> %a
}

define <16 x float> @round_v16f32(<16 x float> %x) {
; SSE2-LABEL: round_v16f32:
; SSE2:       # %bb.0:
; SSE2-NEXT:    subq $104, %rsp
; SSE2-NEXT:    .cfi_def_cfa_offset 112
; SSE2-NEXT:    movaps %xmm3, {{[-0-9]+}}(%r{{[sb]}}p) # 16-byte Spill
; SSE2-NEXT:    movaps %xmm2, {{[-0-9]+}}(%r{{[sb]}}p) # 16-byte Spill
; SSE2-NEXT:    movaps %xmm1, (%rsp) # 16-byte Spill
; SSE2-NEXT:    movaps %xmm0, {{[-0-9]+}}(%r{{[sb]}}p) # 16-byte Spill
; SSE2-NEXT:    shufps {{.*#+}} xmm0 = xmm0[3,3,3,3]
; SSE2-NEXT:    callq roundf@PLT
; SSE2-NEXT:    movaps %xmm0, {{[-0-9]+}}(%r{{[sb]}}p) # 16-byte Spill
; SSE2-NEXT:    movaps {{[-0-9]+}}(%r{{[sb]}}p), %xmm0 # 16-byte Reload
; SSE2-NEXT:    movhlps {{.*#+}} xmm0 = xmm0[1,1]
; SSE2-NEXT:    callq roundf@PLT
; SSE2-NEXT:    unpcklps {{[-0-9]+}}(%r{{[sb]}}p), %xmm0 # 16-byte Folded Reload
; SSE2-NEXT:    # xmm0 = xmm0[0],mem[0],xmm0[1],mem[1]
; SSE2-NEXT:    movaps %xmm0, {{[-0-9]+}}(%r{{[sb]}}p) # 16-byte Spill
; SSE2-NEXT:    movaps {{[-0-9]+}}(%r{{[sb]}}p), %xmm0 # 16-byte Reload
; SSE2-NEXT:    callq roundf@PLT
; SSE2-NEXT:    movaps %xmm0, {{[-0-9]+}}(%r{{[sb]}}p) # 16-byte Spill
; SSE2-NEXT:    movaps {{[-0-9]+}}(%r{{[sb]}}p), %xmm0 # 16-byte Reload
; SSE2-NEXT:    shufps {{.*#+}} xmm0 = xmm0[1,1,1,1]
; SSE2-NEXT:    callq roundf@PLT
; SSE2-NEXT:    movaps {{[-0-9]+}}(%r{{[sb]}}p), %xmm1 # 16-byte Reload
; SSE2-NEXT:    unpcklps {{.*#+}} xmm1 = xmm1[0],xmm0[0],xmm1[1],xmm0[1]
; SSE2-NEXT:    unpcklpd {{[-0-9]+}}(%r{{[sb]}}p), %xmm1 # 16-byte Folded Reload
; SSE2-NEXT:    # xmm1 = xmm1[0],mem[0]
; SSE2-NEXT:    movaps %xmm1, {{[-0-9]+}}(%r{{[sb]}}p) # 16-byte Spill
; SSE2-NEXT:    movaps (%rsp), %xmm0 # 16-byte Reload
; SSE2-NEXT:    shufps {{.*#+}} xmm0 = xmm0[3,3,3,3]
; SSE2-NEXT:    callq roundf@PLT
; SSE2-NEXT:    movaps %xmm0, {{[-0-9]+}}(%r{{[sb]}}p) # 16-byte Spill
; SSE2-NEXT:    movaps (%rsp), %xmm0 # 16-byte Reload
; SSE2-NEXT:    movhlps {{.*#+}} xmm0 = xmm0[1,1]
; SSE2-NEXT:    callq roundf@PLT
; SSE2-NEXT:    unpcklps {{[-0-9]+}}(%r{{[sb]}}p), %xmm0 # 16-byte Folded Reload
; SSE2-NEXT:    # xmm0 = xmm0[0],mem[0],xmm0[1],mem[1]
; SSE2-NEXT:    movaps %xmm0, {{[-0-9]+}}(%r{{[sb]}}p) # 16-byte Spill
; SSE2-NEXT:    movaps (%rsp), %xmm0 # 16-byte Reload
; SSE2-NEXT:    callq roundf@PLT
; SSE2-NEXT:    movaps %xmm0, {{[-0-9]+}}(%r{{[sb]}}p) # 16-byte Spill
; SSE2-NEXT:    movaps (%rsp), %xmm0 # 16-byte Reload
; SSE2-NEXT:    shufps {{.*#+}} xmm0 = xmm0[1,1,1,1]
; SSE2-NEXT:    callq roundf@PLT
; SSE2-NEXT:    movaps {{[-0-9]+}}(%r{{[sb]}}p), %xmm1 # 16-byte Reload
; SSE2-NEXT:    unpcklps {{.*#+}} xmm1 = xmm1[0],xmm0[0],xmm1[1],xmm0[1]
; SSE2-NEXT:    unpcklpd {{[-0-9]+}}(%r{{[sb]}}p), %xmm1 # 16-byte Folded Reload
; SSE2-NEXT:    # xmm1 = xmm1[0],mem[0]
; SSE2-NEXT:    movaps %xmm1, {{[-0-9]+}}(%r{{[sb]}}p) # 16-byte Spill
; SSE2-NEXT:    movaps {{[-0-9]+}}(%r{{[sb]}}p), %xmm0 # 16-byte Reload
; SSE2-NEXT:    shufps {{.*#+}} xmm0 = xmm0[3,3,3,3]
; SSE2-NEXT:    callq roundf@PLT
; SSE2-NEXT:    movaps %xmm0, (%rsp) # 16-byte Spill
; SSE2-NEXT:    movaps {{[-0-9]+}}(%r{{[sb]}}p), %xmm0 # 16-byte Reload
; SSE2-NEXT:    movhlps {{.*#+}} xmm0 = xmm0[1,1]
; SSE2-NEXT:    callq roundf@PLT
; SSE2-NEXT:    unpcklps (%rsp), %xmm0 # 16-byte Folded Reload
; SSE2-NEXT:    # xmm0 = xmm0[0],mem[0],xmm0[1],mem[1]
; SSE2-NEXT:    movaps %xmm0, {{[-0-9]+}}(%r{{[sb]}}p) # 16-byte Spill
; SSE2-NEXT:    movaps {{[-0-9]+}}(%r{{[sb]}}p), %xmm0 # 16-byte Reload
; SSE2-NEXT:    callq roundf@PLT
; SSE2-NEXT:    movaps %xmm0, (%rsp) # 16-byte Spill
; SSE2-NEXT:    movaps {{[-0-9]+}}(%r{{[sb]}}p), %xmm0 # 16-byte Reload
; SSE2-NEXT:    shufps {{.*#+}} xmm0 = xmm0[1,1,1,1]
; SSE2-NEXT:    callq roundf@PLT
; SSE2-NEXT:    movaps (%rsp), %xmm1 # 16-byte Reload
; SSE2-NEXT:    unpcklps {{.*#+}} xmm1 = xmm1[0],xmm0[0],xmm1[1],xmm0[1]
; SSE2-NEXT:    unpcklpd {{[-0-9]+}}(%r{{[sb]}}p), %xmm1 # 16-byte Folded Reload
; SSE2-NEXT:    # xmm1 = xmm1[0],mem[0]
; SSE2-NEXT:    movaps %xmm1, (%rsp) # 16-byte Spill
; SSE2-NEXT:    movaps {{[-0-9]+}}(%r{{[sb]}}p), %xmm0 # 16-byte Reload
; SSE2-NEXT:    shufps {{.*#+}} xmm0 = xmm0[3,3,3,3]
; SSE2-NEXT:    callq roundf@PLT
; SSE2-NEXT:    movaps %xmm0, {{[-0-9]+}}(%r{{[sb]}}p) # 16-byte Spill
; SSE2-NEXT:    movaps {{[-0-9]+}}(%r{{[sb]}}p), %xmm0 # 16-byte Reload
; SSE2-NEXT:    movhlps {{.*#+}} xmm0 = xmm0[1,1]
; SSE2-NEXT:    callq roundf@PLT
; SSE2-NEXT:    unpcklps {{[-0-9]+}}(%r{{[sb]}}p), %xmm0 # 16-byte Folded Reload
; SSE2-NEXT:    # xmm0 = xmm0[0],mem[0],xmm0[1],mem[1]
; SSE2-NEXT:    movaps %xmm0, {{[-0-9]+}}(%r{{[sb]}}p) # 16-byte Spill
; SSE2-NEXT:    movaps {{[-0-9]+}}(%r{{[sb]}}p), %xmm0 # 16-byte Reload
; SSE2-NEXT:    callq roundf@PLT
; SSE2-NEXT:    movaps %xmm0, {{[-0-9]+}}(%r{{[sb]}}p) # 16-byte Spill
; SSE2-NEXT:    movaps {{[-0-9]+}}(%r{{[sb]}}p), %xmm0 # 16-byte Reload
; SSE2-NEXT:    shufps {{.*#+}} xmm0 = xmm0[1,1,1,1]
; SSE2-NEXT:    callq roundf@PLT
; SSE2-NEXT:    movaps {{[-0-9]+}}(%r{{[sb]}}p), %xmm3 # 16-byte Reload
; SSE2-NEXT:    unpcklps {{.*#+}} xmm3 = xmm3[0],xmm0[0],xmm3[1],xmm0[1]
; SSE2-NEXT:    unpcklpd {{[-0-9]+}}(%r{{[sb]}}p), %xmm3 # 16-byte Folded Reload
; SSE2-NEXT:    # xmm3 = xmm3[0],mem[0]
; SSE2-NEXT:    movaps {{[-0-9]+}}(%r{{[sb]}}p), %xmm0 # 16-byte Reload
; SSE2-NEXT:    movaps {{[-0-9]+}}(%r{{[sb]}}p), %xmm1 # 16-byte Reload
; SSE2-NEXT:    movaps (%rsp), %xmm2 # 16-byte Reload
; SSE2-NEXT:    addq $104, %rsp
; SSE2-NEXT:    .cfi_def_cfa_offset 8
; SSE2-NEXT:    retq
;
; SSE41-LABEL: round_v16f32:
; SSE41:       # %bb.0:
; SSE41-NEXT:    movaps {{.*#+}} xmm4 = [-0.0E+0,-0.0E+0,-0.0E+0,-0.0E+0]
; SSE41-NEXT:    movaps %xmm0, %xmm5
; SSE41-NEXT:    andps %xmm4, %xmm5
; SSE41-NEXT:    movaps {{.*#+}} xmm6 = [4.9999997E-1,4.9999997E-1,4.9999997E-1,4.9999997E-1]
; SSE41-NEXT:    orps %xmm6, %xmm5
; SSE41-NEXT:    addps %xmm0, %xmm5
; SSE41-NEXT:    roundps $11, %xmm5, %xmm0
; SSE41-NEXT:    movaps %xmm1, %xmm5
; SSE41-NEXT:    andps %xmm4, %xmm5
; SSE41-NEXT:    orps %xmm6, %xmm5
; SSE41-NEXT:    addps %xmm1, %xmm5
; SSE41-NEXT:    roundps $11, %xmm5, %xmm1
; SSE41-NEXT:    movaps %xmm2, %xmm5
; SSE41-NEXT:    andps %xmm4, %xmm5
; SSE41-NEXT:    orps %xmm6, %xmm5
; SSE41-NEXT:    addps %xmm2, %xmm5
; SSE41-NEXT:    roundps $11, %xmm5, %xmm2
; SSE41-NEXT:    andps %xmm3, %xmm4
; SSE41-NEXT:    orps %xmm6, %xmm4
; SSE41-NEXT:    addps %xmm3, %xmm4
; SSE41-NEXT:    roundps $11, %xmm4, %xmm3
; SSE41-NEXT:    retq
;
; AVX1-LABEL: round_v16f32:
; AVX1:       # %bb.0:
; AVX1-NEXT:    vmovaps {{.*#+}} ymm2 = [-0.0E+0,-0.0E+0,-0.0E+0,-0.0E+0,-0.0E+0,-0.0E+0,-0.0E+0,-0.0E+0]
; AVX1-NEXT:    vandps %ymm2, %ymm0, %ymm3
; AVX1-NEXT:    vmovaps {{.*#+}} ymm4 = [4.9999997E-1,4.9999997E-1,4.9999997E-1,4.9999997E-1,4.9999997E-1,4.9999997E-1,4.9999997E-1,4.9999997E-1]
; AVX1-NEXT:    vorps %ymm4, %ymm3, %ymm3
; AVX1-NEXT:    vaddps %ymm3, %ymm0, %ymm0
; AVX1-NEXT:    vroundps $11, %ymm0, %ymm0
; AVX1-NEXT:    vandps %ymm2, %ymm1, %ymm2
; AVX1-NEXT:    vorps %ymm4, %ymm2, %ymm2
; AVX1-NEXT:    vaddps %ymm2, %ymm1, %ymm1
; AVX1-NEXT:    vroundps $11, %ymm1, %ymm1
; AVX1-NEXT:    retq
;
; AVX512F-LABEL: round_v16f32:
; AVX512F:       # %bb.0:
; AVX512F-NEXT:    vpbroadcastd {{.*#+}} zmm1 = [4.9999997E-1,4.9999997E-1,4.9999997E-1,4.9999997E-1,4.9999997E-1,4.9999997E-1,4.9999997E-1,4.9999997E-1,4.9999997E-1,4.9999997E-1,4.9999997E-1,4.9999997E-1,4.9999997E-1,4.9999997E-1,4.9999997E-1,4.9999997E-1]
; AVX512F-NEXT:    vpternlogd $248, {{\.?LCPI[0-9]+_[0-9]+}}(%rip){1to16}, %zmm0, %zmm1
; AVX512F-NEXT:    vaddps %zmm1, %zmm0, %zmm0
; AVX512F-NEXT:    vrndscaleps $11, %zmm0, %zmm0
; AVX512F-NEXT:    retq
;
; AVX512FP16-LABEL: round_v16f32:
; AVX512FP16:       ## %bb.0:
; AVX512FP16-NEXT:    vpbroadcastd {{.*#+}} zmm1 = [4.9999997E-1,4.9999997E-1,4.9999997E-1,4.9999997E-1,4.9999997E-1,4.9999997E-1,4.9999997E-1,4.9999997E-1,4.9999997E-1,4.9999997E-1,4.9999997E-1,4.9999997E-1,4.9999997E-1,4.9999997E-1,4.9999997E-1,4.9999997E-1]
; AVX512FP16-NEXT:    vpternlogd $248, {{\.?LCPI[0-9]+_[0-9]+}}(%rip){1to16}, %zmm0, %zmm1
; AVX512FP16-NEXT:    vaddps %zmm1, %zmm0, %zmm0
; AVX512FP16-NEXT:    vrndscaleps $11, %zmm0, %zmm0
; AVX512FP16-NEXT:    retq
  %a = call <16 x float> @llvm.round.v16f32(<16 x float> %x)
  ret <16 x float> %a
}

define <8 x double> @round_v8f64(<8 x double> %x) {
; SSE2-LABEL: round_v8f64:
; SSE2:       # %bb.0:
; SSE2-NEXT:    subq $88, %rsp
; SSE2-NEXT:    .cfi_def_cfa_offset 96
; SSE2-NEXT:    movaps %xmm3, {{[-0-9]+}}(%r{{[sb]}}p) # 16-byte Spill
; SSE2-NEXT:    movaps %xmm2, {{[-0-9]+}}(%r{{[sb]}}p) # 16-byte Spill
; SSE2-NEXT:    movaps %xmm1, (%rsp) # 16-byte Spill
; SSE2-NEXT:    movaps %xmm0, {{[-0-9]+}}(%r{{[sb]}}p) # 16-byte Spill
; SSE2-NEXT:    callq round@PLT
; SSE2-NEXT:    movaps %xmm0, {{[-0-9]+}}(%r{{[sb]}}p) # 16-byte Spill
; SSE2-NEXT:    movaps {{[-0-9]+}}(%r{{[sb]}}p), %xmm0 # 16-byte Reload
; SSE2-NEXT:    movhlps {{.*#+}} xmm0 = xmm0[1,1]
; SSE2-NEXT:    callq round@PLT
; SSE2-NEXT:    movaps {{[-0-9]+}}(%r{{[sb]}}p), %xmm1 # 16-byte Reload
; SSE2-NEXT:    movlhps {{.*#+}} xmm1 = xmm1[0],xmm0[0]
; SSE2-NEXT:    movaps %xmm1, {{[-0-9]+}}(%r{{[sb]}}p) # 16-byte Spill
; SSE2-NEXT:    movaps (%rsp), %xmm0 # 16-byte Reload
; SSE2-NEXT:    callq round@PLT
; SSE2-NEXT:    movaps %xmm0, {{[-0-9]+}}(%r{{[sb]}}p) # 16-byte Spill
; SSE2-NEXT:    movaps (%rsp), %xmm0 # 16-byte Reload
; SSE2-NEXT:    movhlps {{.*#+}} xmm0 = xmm0[1,1]
; SSE2-NEXT:    callq round@PLT
; SSE2-NEXT:    movaps {{[-0-9]+}}(%r{{[sb]}}p), %xmm1 # 16-byte Reload
; SSE2-NEXT:    movlhps {{.*#+}} xmm1 = xmm1[0],xmm0[0]
; SSE2-NEXT:    movaps %xmm1, {{[-0-9]+}}(%r{{[sb]}}p) # 16-byte Spill
; SSE2-NEXT:    movaps {{[-0-9]+}}(%r{{[sb]}}p), %xmm0 # 16-byte Reload
; SSE2-NEXT:    callq round@PLT
; SSE2-NEXT:    movaps %xmm0, (%rsp) # 16-byte Spill
; SSE2-NEXT:    movaps {{[-0-9]+}}(%r{{[sb]}}p), %xmm0 # 16-byte Reload
; SSE2-NEXT:    movhlps {{.*#+}} xmm0 = xmm0[1,1]
; SSE2-NEXT:    callq round@PLT
; SSE2-NEXT:    movaps (%rsp), %xmm1 # 16-byte Reload
; SSE2-NEXT:    movlhps {{.*#+}} xmm1 = xmm1[0],xmm0[0]
; SSE2-NEXT:    movaps %xmm1, (%rsp) # 16-byte Spill
; SSE2-NEXT:    movaps {{[-0-9]+}}(%r{{[sb]}}p), %xmm0 # 16-byte Reload
; SSE2-NEXT:    callq round@PLT
; SSE2-NEXT:    movaps %xmm0, {{[-0-9]+}}(%r{{[sb]}}p) # 16-byte Spill
; SSE2-NEXT:    movaps {{[-0-9]+}}(%r{{[sb]}}p), %xmm0 # 16-byte Reload
; SSE2-NEXT:    movhlps {{.*#+}} xmm0 = xmm0[1,1]
; SSE2-NEXT:    callq round@PLT
; SSE2-NEXT:    movaps {{[-0-9]+}}(%r{{[sb]}}p), %xmm3 # 16-byte Reload
; SSE2-NEXT:    movlhps {{.*#+}} xmm3 = xmm3[0],xmm0[0]
; SSE2-NEXT:    movaps {{[-0-9]+}}(%r{{[sb]}}p), %xmm0 # 16-byte Reload
; SSE2-NEXT:    movaps {{[-0-9]+}}(%r{{[sb]}}p), %xmm1 # 16-byte Reload
; SSE2-NEXT:    movaps (%rsp), %xmm2 # 16-byte Reload
; SSE2-NEXT:    addq $88, %rsp
; SSE2-NEXT:    .cfi_def_cfa_offset 8
; SSE2-NEXT:    retq
;
; SSE41-LABEL: round_v8f64:
; SSE41:       # %bb.0:
; SSE41-NEXT:    movapd {{.*#+}} xmm4 = [-0.0E+0,-0.0E+0]
; SSE41-NEXT:    movapd %xmm0, %xmm5
; SSE41-NEXT:    andpd %xmm4, %xmm5
; SSE41-NEXT:    movapd {{.*#+}} xmm6 = [4.9999999999999994E-1,4.9999999999999994E-1]
; SSE41-NEXT:    orpd %xmm6, %xmm5
; SSE41-NEXT:    addpd %xmm0, %xmm5
; SSE41-NEXT:    roundpd $11, %xmm5, %xmm0
; SSE41-NEXT:    movapd %xmm1, %xmm5
; SSE41-NEXT:    andpd %xmm4, %xmm5
; SSE41-NEXT:    orpd %xmm6, %xmm5
; SSE41-NEXT:    addpd %xmm1, %xmm5
; SSE41-NEXT:    roundpd $11, %xmm5, %xmm1
; SSE41-NEXT:    movapd %xmm2, %xmm5
; SSE41-NEXT:    andpd %xmm4, %xmm5
; SSE41-NEXT:    orpd %xmm6, %xmm5
; SSE41-NEXT:    addpd %xmm2, %xmm5
; SSE41-NEXT:    roundpd $11, %xmm5, %xmm2
; SSE41-NEXT:    andpd %xmm3, %xmm4
; SSE41-NEXT:    orpd %xmm6, %xmm4
; SSE41-NEXT:    addpd %xmm3, %xmm4
; SSE41-NEXT:    roundpd $11, %xmm4, %xmm3
; SSE41-NEXT:    retq
;
; AVX1-LABEL: round_v8f64:
; AVX1:       # %bb.0:
; AVX1-NEXT:    vmovapd {{.*#+}} ymm2 = [-0.0E+0,-0.0E+0,-0.0E+0,-0.0E+0]
; AVX1-NEXT:    vandpd %ymm2, %ymm0, %ymm3
; AVX1-NEXT:    vmovapd {{.*#+}} ymm4 = [4.9999999999999994E-1,4.9999999999999994E-1,4.9999999999999994E-1,4.9999999999999994E-1]
; AVX1-NEXT:    vorpd %ymm4, %ymm3, %ymm3
; AVX1-NEXT:    vaddpd %ymm3, %ymm0, %ymm0
; AVX1-NEXT:    vroundpd $11, %ymm0, %ymm0
; AVX1-NEXT:    vandpd %ymm2, %ymm1, %ymm2
; AVX1-NEXT:    vorpd %ymm4, %ymm2, %ymm2
; AVX1-NEXT:    vaddpd %ymm2, %ymm1, %ymm1
; AVX1-NEXT:    vroundpd $11, %ymm1, %ymm1
; AVX1-NEXT:    retq
;
; AVX512F-LABEL: round_v8f64:
; AVX512F:       # %bb.0:
; AVX512F-NEXT:    vpbroadcastq {{.*#+}} zmm1 = [4.9999999999999994E-1,4.9999999999999994E-1,4.9999999999999994E-1,4.9999999999999994E-1,4.9999999999999994E-1,4.9999999999999994E-1,4.9999999999999994E-1,4.9999999999999994E-1]
; AVX512F-NEXT:    vpternlogq $248, {{\.?LCPI[0-9]+_[0-9]+}}(%rip){1to8}, %zmm0, %zmm1
; AVX512F-NEXT:    vaddpd %zmm1, %zmm0, %zmm0
; AVX512F-NEXT:    vrndscalepd $11, %zmm0, %zmm0
; AVX512F-NEXT:    retq
;
; AVX512FP16-LABEL: round_v8f64:
; AVX512FP16:       ## %bb.0:
; AVX512FP16-NEXT:    vpbroadcastq {{.*#+}} zmm1 = [4.9999999999999994E-1,4.9999999999999994E-1,4.9999999999999994E-1,4.9999999999999994E-1,4.9999999999999994E-1,4.9999999999999994E-1,4.9999999999999994E-1,4.9999999999999994E-1]
; AVX512FP16-NEXT:    vpternlogq $248, {{\.?LCPI[0-9]+_[0-9]+}}(%rip){1to8}, %zmm0, %zmm1
; AVX512FP16-NEXT:    vaddpd %zmm1, %zmm0, %zmm0
; AVX512FP16-NEXT:    vrndscalepd $11, %zmm0, %zmm0
; AVX512FP16-NEXT:    retq
  %a = call <8 x double> @llvm.round.v8f64(<8 x double> %x)
  ret <8 x double> %a
}

declare half @llvm.round.f16(half)
declare float @llvm.round.f32(float)
declare double @llvm.round.f64(double)
declare <4 x float> @llvm.round.v4f32(<4 x float>)
declare <2 x double> @llvm.round.v2f64(<2 x double>)
declare <8 x float> @llvm.round.v8f32(<8 x float>)
declare <4 x double> @llvm.round.v4f64(<4 x double>)
declare <16 x float> @llvm.round.v16f32(<16 x float>)
declare <8 x double> @llvm.round.v8f64(<8 x double>)
