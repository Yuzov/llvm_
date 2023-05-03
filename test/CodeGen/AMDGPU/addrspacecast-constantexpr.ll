; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --function-signature --check-globals
; RUN: opt -mtriple=amdgcn-unknown-amdhsa -S -amdgpu-annotate-kernel-features < %s | FileCheck -check-prefixes=HSA,AKF_HSA %s
; RUN: opt -mtriple=amdgcn-unknown-amdhsa -S -amdgpu-attributor < %s | FileCheck -check-prefixes=HSA,ATTRIBUTOR_HSA %s

declare void @llvm.memcpy.p1.p4.i32(ptr addrspace(1) nocapture, ptr addrspace(4) nocapture, i32, i1) #0

@lds.i32 = unnamed_addr addrspace(3) global i32 undef, align 4
@lds.arr = unnamed_addr addrspace(3) global [256 x i32] undef, align 4

@global.i32 = unnamed_addr addrspace(1) global i32 undef, align 4
@global.arr = unnamed_addr addrspace(1) global [256 x i32] undef, align 4

;.
; HSA: @[[LDS_I32:[a-zA-Z0-9_$"\\.-]+]] = unnamed_addr addrspace(3) global i32 undef, align 4
; HSA: @[[LDS_ARR:[a-zA-Z0-9_$"\\.-]+]] = unnamed_addr addrspace(3) global [256 x i32] undef, align 4
; HSA: @[[GLOBAL_I32:[a-zA-Z0-9_$"\\.-]+]] = unnamed_addr addrspace(1) global i32 undef, align 4
; HSA: @[[GLOBAL_ARR:[a-zA-Z0-9_$"\\.-]+]] = unnamed_addr addrspace(1) global [256 x i32] undef, align 4
;.
define amdgpu_kernel void @store_cast_0_flat_to_group_addrspacecast() #1 {
; HSA-LABEL: define {{[^@]+}}@store_cast_0_flat_to_group_addrspacecast
; HSA-SAME: () #[[ATTR1:[0-9]+]] {
; HSA-NEXT:    store i32 7, ptr addrspace(3) addrspacecast (ptr addrspace(4) null to ptr addrspace(3)), align 4
; HSA-NEXT:    ret void
;
  store i32 7, ptr addrspace(3) addrspacecast (ptr addrspace(4) null to ptr addrspace(3))
  ret void
}

define amdgpu_kernel void @store_cast_0_group_to_flat_addrspacecast() #1 {
; AKF_HSA-LABEL: define {{[^@]+}}@store_cast_0_group_to_flat_addrspacecast
; AKF_HSA-SAME: () #[[ATTR1]] {
; AKF_HSA-NEXT:    store i32 7, ptr addrspace(4) addrspacecast (ptr addrspace(3) null to ptr addrspace(4)), align 4
; AKF_HSA-NEXT:    ret void
;
; ATTRIBUTOR_HSA-LABEL: define {{[^@]+}}@store_cast_0_group_to_flat_addrspacecast
; ATTRIBUTOR_HSA-SAME: () #[[ATTR2:[0-9]+]] {
; ATTRIBUTOR_HSA-NEXT:    store i32 7, ptr addrspace(4) addrspacecast (ptr addrspace(3) null to ptr addrspace(4)), align 4
; ATTRIBUTOR_HSA-NEXT:    ret void
;
  store i32 7, ptr addrspace(4) addrspacecast (ptr addrspace(3) null to ptr addrspace(4))
  ret void
}

define amdgpu_kernel void @store_constant_cast_group_gv_to_flat() #1 {
; AKF_HSA-LABEL: define {{[^@]+}}@store_constant_cast_group_gv_to_flat
; AKF_HSA-SAME: () #[[ATTR1]] {
; AKF_HSA-NEXT:    store i32 7, ptr addrspace(4) addrspacecast (ptr addrspace(3) @lds.i32 to ptr addrspace(4)), align 4
; AKF_HSA-NEXT:    ret void
;
; ATTRIBUTOR_HSA-LABEL: define {{[^@]+}}@store_constant_cast_group_gv_to_flat
; ATTRIBUTOR_HSA-SAME: () #[[ATTR2]] {
; ATTRIBUTOR_HSA-NEXT:    store i32 7, ptr addrspace(4) addrspacecast (ptr addrspace(3) @lds.i32 to ptr addrspace(4)), align 4
; ATTRIBUTOR_HSA-NEXT:    ret void
;
  store i32 7, ptr addrspace(4) addrspacecast (ptr addrspace(3) @lds.i32 to ptr addrspace(4))
  ret void
}

define amdgpu_kernel void @store_constant_cast_group_gv_gep_to_flat() #1 {
; AKF_HSA-LABEL: define {{[^@]+}}@store_constant_cast_group_gv_gep_to_flat
; AKF_HSA-SAME: () #[[ATTR1]] {
; AKF_HSA-NEXT:    store i32 7, ptr addrspace(4) getelementptr ([256 x i32], ptr addrspace(4) addrspacecast (ptr addrspace(3) @lds.arr to ptr addrspace(4)), i64 0, i64 8), align 4
; AKF_HSA-NEXT:    ret void
;
; ATTRIBUTOR_HSA-LABEL: define {{[^@]+}}@store_constant_cast_group_gv_gep_to_flat
; ATTRIBUTOR_HSA-SAME: () #[[ATTR2]] {
; ATTRIBUTOR_HSA-NEXT:    store i32 7, ptr addrspace(4) getelementptr ([256 x i32], ptr addrspace(4) addrspacecast (ptr addrspace(3) @lds.arr to ptr addrspace(4)), i64 0, i64 8), align 4
; ATTRIBUTOR_HSA-NEXT:    ret void
;
  store i32 7, ptr addrspace(4) getelementptr ([256 x i32], ptr addrspace(4) addrspacecast (ptr addrspace(3) @lds.arr to ptr addrspace(4)), i64 0, i64 8)
  ret void
}

define amdgpu_kernel void @store_constant_cast_global_gv_to_flat() #1 {
; HSA-LABEL: define {{[^@]+}}@store_constant_cast_global_gv_to_flat
; HSA-SAME: () #[[ATTR1]] {
; HSA-NEXT:    store i32 7, ptr addrspace(4) addrspacecast (ptr addrspace(1) @global.i32 to ptr addrspace(4)), align 4
; HSA-NEXT:    ret void
;
  store i32 7, ptr addrspace(4) addrspacecast (ptr addrspace(1) @global.i32 to ptr addrspace(4))
  ret void
}

define amdgpu_kernel void @store_constant_cast_global_gv_gep_to_flat() #1 {
; HSA-LABEL: define {{[^@]+}}@store_constant_cast_global_gv_gep_to_flat
; HSA-SAME: () #[[ATTR1]] {
; HSA-NEXT:    store i32 7, ptr addrspace(4) getelementptr ([256 x i32], ptr addrspace(4) addrspacecast (ptr addrspace(1) @global.arr to ptr addrspace(4)), i64 0, i64 8), align 4
; HSA-NEXT:    ret void
;
  store i32 7, ptr addrspace(4) getelementptr ([256 x i32], ptr addrspace(4) addrspacecast (ptr addrspace(1) @global.arr to ptr addrspace(4)), i64 0, i64 8)
  ret void
}

define amdgpu_kernel void @load_constant_cast_group_gv_gep_to_flat(ptr addrspace(1) %out) #1 {
; AKF_HSA-LABEL: define {{[^@]+}}@load_constant_cast_group_gv_gep_to_flat
; AKF_HSA-SAME: (ptr addrspace(1) [[OUT:%.*]]) #[[ATTR1]] {
; AKF_HSA-NEXT:    [[VAL:%.*]] = load i32, ptr addrspace(4) getelementptr ([256 x i32], ptr addrspace(4) addrspacecast (ptr addrspace(3) @lds.arr to ptr addrspace(4)), i64 0, i64 8), align 4
; AKF_HSA-NEXT:    store i32 [[VAL]], ptr addrspace(1) [[OUT]], align 4
; AKF_HSA-NEXT:    ret void
;
; ATTRIBUTOR_HSA-LABEL: define {{[^@]+}}@load_constant_cast_group_gv_gep_to_flat
; ATTRIBUTOR_HSA-SAME: (ptr addrspace(1) [[OUT:%.*]]) #[[ATTR2]] {
; ATTRIBUTOR_HSA-NEXT:    [[VAL:%.*]] = load i32, ptr addrspace(4) getelementptr ([256 x i32], ptr addrspace(4) addrspacecast (ptr addrspace(3) @lds.arr to ptr addrspace(4)), i64 0, i64 8), align 4
; ATTRIBUTOR_HSA-NEXT:    store i32 [[VAL]], ptr addrspace(1) [[OUT]], align 4
; ATTRIBUTOR_HSA-NEXT:    ret void
;
  %val = load i32, ptr addrspace(4) getelementptr ([256 x i32], ptr addrspace(4) addrspacecast (ptr addrspace(3) @lds.arr to ptr addrspace(4)), i64 0, i64 8)
  store i32 %val, ptr addrspace(1) %out
  ret void
}

define amdgpu_kernel void @atomicrmw_constant_cast_group_gv_gep_to_flat(ptr addrspace(1) %out) #1 {
; AKF_HSA-LABEL: define {{[^@]+}}@atomicrmw_constant_cast_group_gv_gep_to_flat
; AKF_HSA-SAME: (ptr addrspace(1) [[OUT:%.*]]) #[[ATTR1]] {
; AKF_HSA-NEXT:    [[VAL:%.*]] = atomicrmw add ptr addrspace(4) getelementptr ([256 x i32], ptr addrspace(4) addrspacecast (ptr addrspace(3) @lds.arr to ptr addrspace(4)), i64 0, i64 8), i32 1 seq_cst, align 4
; AKF_HSA-NEXT:    store i32 [[VAL]], ptr addrspace(1) [[OUT]], align 4
; AKF_HSA-NEXT:    ret void
;
; ATTRIBUTOR_HSA-LABEL: define {{[^@]+}}@atomicrmw_constant_cast_group_gv_gep_to_flat
; ATTRIBUTOR_HSA-SAME: (ptr addrspace(1) [[OUT:%.*]]) #[[ATTR2]] {
; ATTRIBUTOR_HSA-NEXT:    [[VAL:%.*]] = atomicrmw add ptr addrspace(4) getelementptr ([256 x i32], ptr addrspace(4) addrspacecast (ptr addrspace(3) @lds.arr to ptr addrspace(4)), i64 0, i64 8), i32 1 seq_cst, align 4
; ATTRIBUTOR_HSA-NEXT:    store i32 [[VAL]], ptr addrspace(1) [[OUT]], align 4
; ATTRIBUTOR_HSA-NEXT:    ret void
;
  %val = atomicrmw add ptr addrspace(4) getelementptr ([256 x i32], ptr addrspace(4) addrspacecast (ptr addrspace(3) @lds.arr to ptr addrspace(4)), i64 0, i64 8), i32 1 seq_cst
  store i32 %val, ptr addrspace(1) %out
  ret void
}

define amdgpu_kernel void @cmpxchg_constant_cast_group_gv_gep_to_flat(ptr addrspace(1) %out) #1 {
; AKF_HSA-LABEL: define {{[^@]+}}@cmpxchg_constant_cast_group_gv_gep_to_flat
; AKF_HSA-SAME: (ptr addrspace(1) [[OUT:%.*]]) #[[ATTR1]] {
; AKF_HSA-NEXT:    [[VAL:%.*]] = cmpxchg ptr addrspace(4) getelementptr ([256 x i32], ptr addrspace(4) addrspacecast (ptr addrspace(3) @lds.arr to ptr addrspace(4)), i64 0, i64 8), i32 0, i32 1 seq_cst seq_cst, align 4
; AKF_HSA-NEXT:    [[VAL0:%.*]] = extractvalue { i32, i1 } [[VAL]], 0
; AKF_HSA-NEXT:    store i32 [[VAL0]], ptr addrspace(1) [[OUT]], align 4
; AKF_HSA-NEXT:    ret void
;
; ATTRIBUTOR_HSA-LABEL: define {{[^@]+}}@cmpxchg_constant_cast_group_gv_gep_to_flat
; ATTRIBUTOR_HSA-SAME: (ptr addrspace(1) [[OUT:%.*]]) #[[ATTR2]] {
; ATTRIBUTOR_HSA-NEXT:    [[VAL:%.*]] = cmpxchg ptr addrspace(4) getelementptr ([256 x i32], ptr addrspace(4) addrspacecast (ptr addrspace(3) @lds.arr to ptr addrspace(4)), i64 0, i64 8), i32 0, i32 1 seq_cst seq_cst, align 4
; ATTRIBUTOR_HSA-NEXT:    [[VAL0:%.*]] = extractvalue { i32, i1 } [[VAL]], 0
; ATTRIBUTOR_HSA-NEXT:    store i32 [[VAL0]], ptr addrspace(1) [[OUT]], align 4
; ATTRIBUTOR_HSA-NEXT:    ret void
;
  %val = cmpxchg ptr addrspace(4) getelementptr ([256 x i32], ptr addrspace(4) addrspacecast (ptr addrspace(3) @lds.arr to ptr addrspace(4)), i64 0, i64 8), i32 0, i32 1 seq_cst seq_cst
  %val0 = extractvalue { i32, i1 } %val, 0
  store i32 %val0, ptr addrspace(1) %out
  ret void
}

define amdgpu_kernel void @memcpy_constant_cast_group_gv_gep_to_flat(ptr addrspace(1) %out) #1 {
; AKF_HSA-LABEL: define {{[^@]+}}@memcpy_constant_cast_group_gv_gep_to_flat
; AKF_HSA-SAME: (ptr addrspace(1) [[OUT:%.*]]) #[[ATTR1]] {
; AKF_HSA-NEXT:    call void @llvm.memcpy.p1.p4.i32(ptr addrspace(1) align 4 [[OUT]], ptr addrspace(4) align 4 getelementptr ([256 x i32], ptr addrspace(4) addrspacecast (ptr addrspace(3) @lds.arr to ptr addrspace(4)), i64 0, i64 8), i32 32, i1 false)
; AKF_HSA-NEXT:    ret void
;
; ATTRIBUTOR_HSA-LABEL: define {{[^@]+}}@memcpy_constant_cast_group_gv_gep_to_flat
; ATTRIBUTOR_HSA-SAME: (ptr addrspace(1) [[OUT:%.*]]) #[[ATTR2]] {
; ATTRIBUTOR_HSA-NEXT:    call void @llvm.memcpy.p1.p4.i32(ptr addrspace(1) align 4 [[OUT]], ptr addrspace(4) align 4 getelementptr ([256 x i32], ptr addrspace(4) addrspacecast (ptr addrspace(3) @lds.arr to ptr addrspace(4)), i64 0, i64 8), i32 32, i1 false)
; ATTRIBUTOR_HSA-NEXT:    ret void
;
  call void @llvm.memcpy.p1.p4.i32(ptr addrspace(1) align 4 %out, ptr addrspace(4) align 4 getelementptr ([256 x i32], ptr addrspace(4) addrspacecast (ptr addrspace(3) @lds.arr to ptr addrspace(4)), i64 0, i64 8), i32 32, i1 false)
  ret void
}

; Can't just search the pointer value
define amdgpu_kernel void @store_value_constant_cast_lds_gv_gep_to_flat(ptr addrspace(1) %out) #1 {
; AKF_HSA-LABEL: define {{[^@]+}}@store_value_constant_cast_lds_gv_gep_to_flat
; AKF_HSA-SAME: (ptr addrspace(1) [[OUT:%.*]]) #[[ATTR1]] {
; AKF_HSA-NEXT:    store ptr addrspace(4) getelementptr ([256 x i32], ptr addrspace(4) addrspacecast (ptr addrspace(3) @lds.arr to ptr addrspace(4)), i64 0, i64 8), ptr addrspace(1) [[OUT]], align 8
; AKF_HSA-NEXT:    ret void
;
; ATTRIBUTOR_HSA-LABEL: define {{[^@]+}}@store_value_constant_cast_lds_gv_gep_to_flat
; ATTRIBUTOR_HSA-SAME: (ptr addrspace(1) [[OUT:%.*]]) #[[ATTR2]] {
; ATTRIBUTOR_HSA-NEXT:    store ptr addrspace(4) getelementptr ([256 x i32], ptr addrspace(4) addrspacecast (ptr addrspace(3) @lds.arr to ptr addrspace(4)), i64 0, i64 8), ptr addrspace(1) [[OUT]], align 8
; ATTRIBUTOR_HSA-NEXT:    ret void
;
  store ptr addrspace(4) getelementptr ([256 x i32], ptr addrspace(4) addrspacecast (ptr addrspace(3) @lds.arr to ptr addrspace(4)), i64 0, i64 8), ptr addrspace(1) %out
  ret void
}

; Can't just search pointer types
define amdgpu_kernel void @store_ptrtoint_value_constant_cast_lds_gv_gep_to_flat(ptr addrspace(1) %out) #1 {
; AKF_HSA-LABEL: define {{[^@]+}}@store_ptrtoint_value_constant_cast_lds_gv_gep_to_flat
; AKF_HSA-SAME: (ptr addrspace(1) [[OUT:%.*]]) #[[ATTR1]] {
; AKF_HSA-NEXT:    store i64 ptrtoint (ptr addrspace(4) getelementptr ([256 x i32], ptr addrspace(4) addrspacecast (ptr addrspace(3) @lds.arr to ptr addrspace(4)), i64 0, i64 8) to i64), ptr addrspace(1) [[OUT]], align 4
; AKF_HSA-NEXT:    ret void
;
; ATTRIBUTOR_HSA-LABEL: define {{[^@]+}}@store_ptrtoint_value_constant_cast_lds_gv_gep_to_flat
; ATTRIBUTOR_HSA-SAME: (ptr addrspace(1) [[OUT:%.*]]) #[[ATTR2]] {
; ATTRIBUTOR_HSA-NEXT:    store i64 ptrtoint (ptr addrspace(4) getelementptr ([256 x i32], ptr addrspace(4) addrspacecast (ptr addrspace(3) @lds.arr to ptr addrspace(4)), i64 0, i64 8) to i64), ptr addrspace(1) [[OUT]], align 4
; ATTRIBUTOR_HSA-NEXT:    ret void
;
  store i64 ptrtoint (ptr addrspace(4) getelementptr ([256 x i32], ptr addrspace(4) addrspacecast (ptr addrspace(3) @lds.arr to ptr addrspace(4)), i64 0, i64 8) to i64), ptr addrspace(1) %out
  ret void
}

; Cast group to flat, do GEP, cast back to group
define amdgpu_kernel void @store_constant_cast_group_gv_gep_to_flat_to_group() #1 {
; AKF_HSA-LABEL: define {{[^@]+}}@store_constant_cast_group_gv_gep_to_flat_to_group
; AKF_HSA-SAME: () #[[ATTR1]] {
; AKF_HSA-NEXT:    store i32 7, ptr addrspace(3) addrspacecast (ptr addrspace(4) getelementptr ([256 x i32], ptr addrspace(4) addrspacecast (ptr addrspace(3) @lds.arr to ptr addrspace(4)), i64 0, i64 8) to ptr addrspace(3)), align 4
; AKF_HSA-NEXT:    ret void
;
; ATTRIBUTOR_HSA-LABEL: define {{[^@]+}}@store_constant_cast_group_gv_gep_to_flat_to_group
; ATTRIBUTOR_HSA-SAME: () #[[ATTR2]] {
; ATTRIBUTOR_HSA-NEXT:    store i32 7, ptr addrspace(3) addrspacecast (ptr addrspace(4) getelementptr ([256 x i32], ptr addrspace(4) addrspacecast (ptr addrspace(3) @lds.arr to ptr addrspace(4)), i64 0, i64 8) to ptr addrspace(3)), align 4
; ATTRIBUTOR_HSA-NEXT:    ret void
;
  store i32 7, ptr addrspace(3) addrspacecast (ptr addrspace(4) getelementptr ([256 x i32], ptr addrspace(4) addrspacecast (ptr addrspace(3) @lds.arr to ptr addrspace(4)), i64 0, i64 8) to ptr addrspace(3))
  ret void
}

define ptr addrspace(3) @ret_constant_cast_group_gv_gep_to_flat_to_group() #1 {
; AKF_HSA-LABEL: define {{[^@]+}}@ret_constant_cast_group_gv_gep_to_flat_to_group
; AKF_HSA-SAME: () #[[ATTR1]] {
; AKF_HSA-NEXT:    ret ptr addrspace(3) addrspacecast (ptr addrspace(4) getelementptr ([256 x i32], ptr addrspace(4) addrspacecast (ptr addrspace(3) @lds.arr to ptr addrspace(4)), i64 0, i64 8) to ptr addrspace(3))
;
; ATTRIBUTOR_HSA-LABEL: define {{[^@]+}}@ret_constant_cast_group_gv_gep_to_flat_to_group
; ATTRIBUTOR_HSA-SAME: () #[[ATTR2]] {
; ATTRIBUTOR_HSA-NEXT:    ret ptr addrspace(3) addrspacecast (ptr addrspace(4) getelementptr ([256 x i32], ptr addrspace(4) addrspacecast (ptr addrspace(3) @lds.arr to ptr addrspace(4)), i64 0, i64 8) to ptr addrspace(3))
;
  ret ptr addrspace(3) addrspacecast (ptr addrspace(4) getelementptr ([256 x i32], ptr addrspace(4) addrspacecast (ptr addrspace(3) @lds.arr to ptr addrspace(4)), i64 0, i64 8) to ptr addrspace(3))
}

attributes #0 = { argmemonly nounwind }
attributes #1 = { nounwind }
;.
; AKF_HSA: attributes #[[ATTR0:[0-9]+]] = { nocallback nofree nounwind willreturn memory(argmem: readwrite) }
; AKF_HSA: attributes #[[ATTR1]] = { nounwind }
;.
; ATTRIBUTOR_HSA: attributes #[[ATTR0:[0-9]+]] = { nocallback nofree nounwind willreturn memory(argmem: readwrite) }
; ATTRIBUTOR_HSA: attributes #[[ATTR1]] = { nounwind "amdgpu-no-completion-action" "amdgpu-no-default-queue" "amdgpu-no-dispatch-id" "amdgpu-no-dispatch-ptr" "amdgpu-no-heap-ptr" "amdgpu-no-hostcall-ptr" "amdgpu-no-implicitarg-ptr" "amdgpu-no-lds-kernel-id" "amdgpu-no-multigrid-sync-arg" "amdgpu-no-queue-ptr" "amdgpu-no-workgroup-id-x" "amdgpu-no-workgroup-id-y" "amdgpu-no-workgroup-id-z" "amdgpu-no-workitem-id-x" "amdgpu-no-workitem-id-y" "amdgpu-no-workitem-id-z" "uniform-work-group-size"="false" }
; ATTRIBUTOR_HSA: attributes #[[ATTR2]] = { nounwind "amdgpu-no-completion-action" "amdgpu-no-default-queue" "amdgpu-no-dispatch-id" "amdgpu-no-dispatch-ptr" "amdgpu-no-heap-ptr" "amdgpu-no-hostcall-ptr" "amdgpu-no-implicitarg-ptr" "amdgpu-no-lds-kernel-id" "amdgpu-no-multigrid-sync-arg" "amdgpu-no-workgroup-id-x" "amdgpu-no-workgroup-id-y" "amdgpu-no-workgroup-id-z" "amdgpu-no-workitem-id-x" "amdgpu-no-workitem-id-y" "amdgpu-no-workitem-id-z" "uniform-work-group-size"="false" }
;.
