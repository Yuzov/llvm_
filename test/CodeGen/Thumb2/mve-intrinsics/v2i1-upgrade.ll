; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -opaque-pointers=0 -S -o - %s | FileCheck %s

declare <4 x i1> @llvm.arm.mve.vctp64(i32)
declare <4 x i1> @llvm.arm.mve.pred.i2v.v4i1(i32)
declare i32 @llvm.arm.mve.pred.v2i.v4i1(<4 x i1>)
declare <2 x i64> @llvm.arm.mve.mull.int.predicated.v2i64.v4i32.v4i1(<4 x i32>, <4 x i32>, i32, i32, <4 x i1>, <2 x i64>)
declare <2 x i64> @llvm.arm.mve.vqdmull.predicated.v2i64.v4i32.v4i1(<4 x i32>, <4 x i32>, i32, <4 x i1>, <2 x i64>)

declare <2 x i64> @llvm.arm.mve.vldr.gather.base.predicated.v2i64.v2i64.v4i1(<2 x i64>, i32, <4 x i1>)
declare { <2 x i64>, <2 x i64> } @llvm.arm.mve.vldr.gather.base.wb.predicated.v2i64.v2i64.v4i1(<2 x i64>, i32, <4 x i1>)
declare <2 x i64> @llvm.arm.mve.vldr.gather.offset.predicated.v2i64.p0i64.v2i64.v4i1(i64*, <2 x i64>, i32, i32, i32, <4 x i1>)
declare void @llvm.arm.mve.vstr.scatter.base.predicated.v2i64.v2i64.v4i1(<2 x i64>, i32, <2 x i64>, <4 x i1>)
declare <2 x i64> @llvm.arm.mve.vstr.scatter.base.wb.predicated.v2i64.v2i64.v4i1(<2 x i64>, i32, <2 x i64>, <4 x i1>)
declare void @llvm.arm.mve.vstr.scatter.offset.predicated.p0i64.v2i64.v2i64.v4i1(i64*, <2 x i64>, <2 x i64>, i32, i32, <4 x i1>)

declare <2 x i64> @llvm.arm.cde.vcx1q.predicated.v2i64.v4i1(i32 immarg, <2 x i64>, i32 immarg, <4 x i1>)
declare <2 x i64> @llvm.arm.cde.vcx1qa.predicated.v2i64.v4i1(i32 immarg, <2 x i64>, i32 immarg, <4 x i1>)
declare <2 x i64> @llvm.arm.cde.vcx2q.predicated.v2i64.v4i1(i32 immarg, <2 x i64>, <16 x i8>, i32 immarg, <4 x i1>)
declare <2 x i64> @llvm.arm.cde.vcx2qa.predicated.v2i64.v4i1(i32 immarg, <2 x i64>, <16 x i8>, i32 immarg, <4 x i1>)
declare <2 x i64> @llvm.arm.cde.vcx3q.predicated.v2i64.v4i1(i32 immarg, <2 x i64>, <16 x i8>, <16 x i8>, i32 immarg, <4 x i1>)
declare <2 x i64> @llvm.arm.cde.vcx3qa.predicated.v2i64.v4i1(i32 immarg, <2 x i64>, <16 x i8>, <16 x i8>, i32 immarg, <4 x i1>)

define arm_aapcs_vfpcc zeroext i16 @test_vctp64q(i32 %a) {
; CHECK-LABEL: @test_vctp64q(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = call <2 x i1> @llvm.arm.mve.vctp64(i32 [[A:%.*]])
; CHECK-NEXT:    [[TMP1:%.*]] = call i32 @llvm.arm.mve.pred.v2i.v2i1(<2 x i1> [[TMP0]])
; CHECK-NEXT:    [[TMP2:%.*]] = call <4 x i1> @llvm.arm.mve.pred.i2v.v4i1(i32 [[TMP1]])
; CHECK-NEXT:    [[TMP3:%.*]] = call i32 @llvm.arm.mve.pred.v2i.v4i1(<4 x i1> [[TMP2]])
; CHECK-NEXT:    [[TMP4:%.*]] = trunc i32 [[TMP3]] to i16
; CHECK-NEXT:    ret i16 [[TMP4]]
;
entry:
  %0 = call <4 x i1> @llvm.arm.mve.vctp64(i32 %a)
  %1 = call i32 @llvm.arm.mve.pred.v2i.v4i1(<4 x i1> %0)
  %2 = trunc i32 %1 to i16
  ret i16 %2
}

define arm_aapcs_vfpcc zeroext i16 @test_vctp64q_m(i32 %a, i16 zeroext %p) {
; CHECK-LABEL: @test_vctp64q_m(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = zext i16 [[P:%.*]] to i32
; CHECK-NEXT:    [[TMP1:%.*]] = call <4 x i1> @llvm.arm.mve.pred.i2v.v4i1(i32 [[TMP0]])
; CHECK-NEXT:    [[TMP2:%.*]] = call <2 x i1> @llvm.arm.mve.vctp64(i32 [[A:%.*]])
; CHECK-NEXT:    [[TMP3:%.*]] = call i32 @llvm.arm.mve.pred.v2i.v2i1(<2 x i1> [[TMP2]])
; CHECK-NEXT:    [[TMP4:%.*]] = call <4 x i1> @llvm.arm.mve.pred.i2v.v4i1(i32 [[TMP3]])
; CHECK-NEXT:    [[TMP5:%.*]] = and <4 x i1> [[TMP1]], [[TMP4]]
; CHECK-NEXT:    [[TMP6:%.*]] = call i32 @llvm.arm.mve.pred.v2i.v4i1(<4 x i1> [[TMP5]])
; CHECK-NEXT:    [[TMP7:%.*]] = trunc i32 [[TMP6]] to i16
; CHECK-NEXT:    ret i16 [[TMP7]]
;
entry:
  %0 = zext i16 %p to i32
  %1 = call <4 x i1> @llvm.arm.mve.pred.i2v.v4i1(i32 %0)
  %2 = call <4 x i1> @llvm.arm.mve.vctp64(i32 %a)
  %3 = and <4 x i1> %1, %2
  %4 = call i32 @llvm.arm.mve.pred.v2i.v4i1(<4 x i1> %3)
  %5 = trunc i32 %4 to i16
  ret i16 %5
}

define arm_aapcs_vfpcc <2 x i64> @test_vmullbq_int_m_s32(<2 x i64> %inactive, <4 x i32> %a, <4 x i32> %b, i16 zeroext %p) {
; CHECK-LABEL: @test_vmullbq_int_m_s32(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = zext i16 [[P:%.*]] to i32
; CHECK-NEXT:    [[TMP1:%.*]] = tail call <4 x i1> @llvm.arm.mve.pred.i2v.v4i1(i32 [[TMP0]])
; CHECK-NEXT:    [[TMP2:%.*]] = call i32 @llvm.arm.mve.pred.v2i.v4i1(<4 x i1> [[TMP1]])
; CHECK-NEXT:    [[TMP3:%.*]] = call <2 x i1> @llvm.arm.mve.pred.i2v.v2i1(i32 [[TMP2]])
; CHECK-NEXT:    [[TMP4:%.*]] = call <2 x i64> @llvm.arm.mve.mull.int.predicated.v2i64.v4i32.v2i1(<4 x i32> [[A:%.*]], <4 x i32> [[B:%.*]], i32 0, i32 0, <2 x i1> [[TMP3]], <2 x i64> [[INACTIVE:%.*]])
; CHECK-NEXT:    ret <2 x i64> [[TMP4]]
;
entry:
  %0 = zext i16 %p to i32
  %1 = tail call <4 x i1> @llvm.arm.mve.pred.i2v.v4i1(i32 %0)
  %2 = tail call <2 x i64> @llvm.arm.mve.mull.int.predicated.v2i64.v4i32.v4i1(<4 x i32> %a, <4 x i32> %b, i32 0, i32 0, <4 x i1> %1, <2 x i64> %inactive)
  ret <2 x i64> %2
}

define arm_aapcs_vfpcc <2 x i64> @test_vqdmullbq_m_s32(<2 x i64> %inactive, <4 x i32> %a, <4 x i32> %b, i16 zeroext %p) {
; CHECK-LABEL: @test_vqdmullbq_m_s32(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = zext i16 [[P:%.*]] to i32
; CHECK-NEXT:    [[TMP1:%.*]] = call <4 x i1> @llvm.arm.mve.pred.i2v.v4i1(i32 [[TMP0]])
; CHECK-NEXT:    [[TMP2:%.*]] = call i32 @llvm.arm.mve.pred.v2i.v4i1(<4 x i1> [[TMP1]])
; CHECK-NEXT:    [[TMP3:%.*]] = call <2 x i1> @llvm.arm.mve.pred.i2v.v2i1(i32 [[TMP2]])
; CHECK-NEXT:    [[TMP4:%.*]] = call <2 x i64> @llvm.arm.mve.vqdmull.predicated.v2i64.v4i32.v2i1(<4 x i32> [[A:%.*]], <4 x i32> [[B:%.*]], i32 0, <2 x i1> [[TMP3]], <2 x i64> [[INACTIVE:%.*]])
; CHECK-NEXT:    ret <2 x i64> [[TMP4]]
;
entry:
  %0 = zext i16 %p to i32
  %1 = call <4 x i1> @llvm.arm.mve.pred.i2v.v4i1(i32 %0)
  %2 = call <2 x i64> @llvm.arm.mve.vqdmull.predicated.v2i64.v4i32.v4i1(<4 x i32> %a, <4 x i32> %b, i32 0, <4 x i1> %1, <2 x i64> %inactive)
  ret <2 x i64> %2
}

define arm_aapcs_vfpcc <2 x i64> @test_vldrdq_gather_base_z_s64(<2 x i64> %addr, i16 zeroext %p) {
; CHECK-LABEL: @test_vldrdq_gather_base_z_s64(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = zext i16 [[P:%.*]] to i32
; CHECK-NEXT:    [[TMP1:%.*]] = call <4 x i1> @llvm.arm.mve.pred.i2v.v4i1(i32 [[TMP0]])
; CHECK-NEXT:    [[TMP2:%.*]] = call i32 @llvm.arm.mve.pred.v2i.v4i1(<4 x i1> [[TMP1]])
; CHECK-NEXT:    [[TMP3:%.*]] = call <2 x i1> @llvm.arm.mve.pred.i2v.v2i1(i32 [[TMP2]])
; CHECK-NEXT:    [[TMP4:%.*]] = call <2 x i64> @llvm.arm.mve.vldr.gather.base.predicated.v2i64.v2i64.v2i1(<2 x i64> [[ADDR:%.*]], i32 888, <2 x i1> [[TMP3]])
; CHECK-NEXT:    ret <2 x i64> [[TMP4]]
;
entry:
  %0 = zext i16 %p to i32
  %1 = call <4 x i1> @llvm.arm.mve.pred.i2v.v4i1(i32 %0)
  %2 = call <2 x i64> @llvm.arm.mve.vldr.gather.base.predicated.v2i64.v2i64.v4i1(<2 x i64> %addr, i32 888, <4 x i1> %1)
  ret <2 x i64> %2
}

define arm_aapcs_vfpcc <2 x i64> @test_vldrdq_gather_base_wb_z_s64(<2 x i64>* %addr, i16 zeroext %p) {
; CHECK-LABEL: @test_vldrdq_gather_base_wb_z_s64(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = load <2 x i64>, <2 x i64>* [[ADDR:%.*]], align 8
; CHECK-NEXT:    [[TMP1:%.*]] = zext i16 [[P:%.*]] to i32
; CHECK-NEXT:    [[TMP2:%.*]] = call <4 x i1> @llvm.arm.mve.pred.i2v.v4i1(i32 [[TMP1]])
; CHECK-NEXT:    [[TMP3:%.*]] = call i32 @llvm.arm.mve.pred.v2i.v4i1(<4 x i1> [[TMP2]])
; CHECK-NEXT:    [[TMP4:%.*]] = call <2 x i1> @llvm.arm.mve.pred.i2v.v2i1(i32 [[TMP3]])
; CHECK-NEXT:    [[TMP5:%.*]] = call { <2 x i64>, <2 x i64> } @llvm.arm.mve.vldr.gather.base.wb.predicated.v2i64.v2i64.v2i1(<2 x i64> [[TMP0]], i32 664, <2 x i1> [[TMP4]])
; CHECK-NEXT:    [[TMP6:%.*]] = extractvalue { <2 x i64>, <2 x i64> } [[TMP5]], 1
; CHECK-NEXT:    store <2 x i64> [[TMP6]], <2 x i64>* [[ADDR]], align 8
; CHECK-NEXT:    [[TMP7:%.*]] = extractvalue { <2 x i64>, <2 x i64> } [[TMP5]], 0
; CHECK-NEXT:    ret <2 x i64> [[TMP7]]
;
entry:
  %0 = load <2 x i64>, <2 x i64>* %addr, align 8
  %1 = zext i16 %p to i32
  %2 = call <4 x i1> @llvm.arm.mve.pred.i2v.v4i1(i32 %1)
  %3 = call { <2 x i64>, <2 x i64> } @llvm.arm.mve.vldr.gather.base.wb.predicated.v2i64.v2i64.v4i1(<2 x i64> %0, i32 664, <4 x i1> %2)
  %4 = extractvalue { <2 x i64>, <2 x i64> } %3, 1
  store <2 x i64> %4, <2 x i64>* %addr, align 8
  %5 = extractvalue { <2 x i64>, <2 x i64> } %3, 0
  ret <2 x i64> %5
}

define arm_aapcs_vfpcc <2 x i64> @test_vldrdq_gather_offset_z_s64(i64* %base, <2 x i64> %offset, i16 zeroext %p) {
; CHECK-LABEL: @test_vldrdq_gather_offset_z_s64(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = zext i16 [[P:%.*]] to i32
; CHECK-NEXT:    [[TMP1:%.*]] = call <4 x i1> @llvm.arm.mve.pred.i2v.v4i1(i32 [[TMP0]])
; CHECK-NEXT:    [[TMP2:%.*]] = call i32 @llvm.arm.mve.pred.v2i.v4i1(<4 x i1> [[TMP1]])
; CHECK-NEXT:    [[TMP3:%.*]] = call <2 x i1> @llvm.arm.mve.pred.i2v.v2i1(i32 [[TMP2]])
; CHECK-NEXT:    [[TMP4:%.*]] = call <2 x i64> @llvm.arm.mve.vldr.gather.offset.predicated.v2i64.p0i64.v2i64.v2i1(i64* [[BASE:%.*]], <2 x i64> [[OFFSET:%.*]], i32 64, i32 0, i32 0, <2 x i1> [[TMP3]])
; CHECK-NEXT:    ret <2 x i64> [[TMP4]]
;
entry:
  %0 = zext i16 %p to i32
  %1 = call <4 x i1> @llvm.arm.mve.pred.i2v.v4i1(i32 %0)
  %2 = call <2 x i64> @llvm.arm.mve.vldr.gather.offset.predicated.v2i64.p0i64.v2i64.v4i1(i64* %base, <2 x i64> %offset, i32 64, i32 0, i32 0, <4 x i1> %1)
  ret <2 x i64> %2
}

define arm_aapcs_vfpcc void @test_vstrdq_scatter_base_p_s64(<2 x i64> %addr, <2 x i64> %value, i16 zeroext %p) {
; CHECK-LABEL: @test_vstrdq_scatter_base_p_s64(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = zext i16 [[P:%.*]] to i32
; CHECK-NEXT:    [[TMP1:%.*]] = call <4 x i1> @llvm.arm.mve.pred.i2v.v4i1(i32 [[TMP0]])
; CHECK-NEXT:    [[TMP2:%.*]] = call i32 @llvm.arm.mve.pred.v2i.v4i1(<4 x i1> [[TMP1]])
; CHECK-NEXT:    [[TMP3:%.*]] = call <2 x i1> @llvm.arm.mve.pred.i2v.v2i1(i32 [[TMP2]])
; CHECK-NEXT:    call void @llvm.arm.mve.vstr.scatter.base.predicated.v2i64.v2i64.v2i1(<2 x i64> [[ADDR:%.*]], i32 888, <2 x i64> [[VALUE:%.*]], <2 x i1> [[TMP3]])
; CHECK-NEXT:    ret void
;
entry:
  %0 = zext i16 %p to i32
  %1 = call <4 x i1> @llvm.arm.mve.pred.i2v.v4i1(i32 %0)
  call void @llvm.arm.mve.vstr.scatter.base.predicated.v2i64.v2i64.v4i1(<2 x i64> %addr, i32 888, <2 x i64> %value, <4 x i1> %1)
  ret void
}

define arm_aapcs_vfpcc void @test_vstrdq_scatter_base_wb_p_s64(<2 x i64>* %addr, <2 x i64> %value, i16 zeroext %p) {
; CHECK-LABEL: @test_vstrdq_scatter_base_wb_p_s64(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = load <2 x i64>, <2 x i64>* [[ADDR:%.*]], align 8
; CHECK-NEXT:    [[TMP1:%.*]] = zext i16 [[P:%.*]] to i32
; CHECK-NEXT:    [[TMP2:%.*]] = call <4 x i1> @llvm.arm.mve.pred.i2v.v4i1(i32 [[TMP1]])
; CHECK-NEXT:    [[TMP3:%.*]] = call i32 @llvm.arm.mve.pred.v2i.v4i1(<4 x i1> [[TMP2]])
; CHECK-NEXT:    [[TMP4:%.*]] = call <2 x i1> @llvm.arm.mve.pred.i2v.v2i1(i32 [[TMP3]])
; CHECK-NEXT:    [[TMP5:%.*]] = call <2 x i64> @llvm.arm.mve.vstr.scatter.base.wb.predicated.v2i64.v2i64.v2i1(<2 x i64> [[TMP0]], i32 248, <2 x i64> [[VALUE:%.*]], <2 x i1> [[TMP4]])
; CHECK-NEXT:    store <2 x i64> [[TMP5]], <2 x i64>* [[ADDR]], align 8
; CHECK-NEXT:    ret void
;
entry:
  %0 = load <2 x i64>, <2 x i64>* %addr, align 8
  %1 = zext i16 %p to i32
  %2 = call <4 x i1> @llvm.arm.mve.pred.i2v.v4i1(i32 %1)
  %3 = call <2 x i64> @llvm.arm.mve.vstr.scatter.base.wb.predicated.v2i64.v2i64.v4i1(<2 x i64> %0, i32 248, <2 x i64> %value, <4 x i1> %2)
  store <2 x i64> %3, <2 x i64>* %addr, align 8
  ret void
}

define arm_aapcs_vfpcc void @test_vstrdq_scatter_offset_p_s64(i64* %base, <2 x i64> %offset, <2 x i64> %value, i16 zeroext %p) {
; CHECK-LABEL: @test_vstrdq_scatter_offset_p_s64(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = zext i16 [[P:%.*]] to i32
; CHECK-NEXT:    [[TMP1:%.*]] = call <4 x i1> @llvm.arm.mve.pred.i2v.v4i1(i32 [[TMP0]])
; CHECK-NEXT:    [[TMP2:%.*]] = call i32 @llvm.arm.mve.pred.v2i.v4i1(<4 x i1> [[TMP1]])
; CHECK-NEXT:    [[TMP3:%.*]] = call <2 x i1> @llvm.arm.mve.pred.i2v.v2i1(i32 [[TMP2]])
; CHECK-NEXT:    call void @llvm.arm.mve.vstr.scatter.offset.predicated.p0i64.v2i64.v2i64.v2i1(i64* [[BASE:%.*]], <2 x i64> [[OFFSET:%.*]], <2 x i64> [[VALUE:%.*]], i32 64, i32 0, <2 x i1> [[TMP3]])
; CHECK-NEXT:    ret void
;
entry:
  %0 = zext i16 %p to i32
  %1 = call <4 x i1> @llvm.arm.mve.pred.i2v.v4i1(i32 %0)
  call void @llvm.arm.mve.vstr.scatter.offset.predicated.p0i64.v2i64.v2i64.v4i1(i64* %base, <2 x i64> %offset, <2 x i64> %value, i32 64, i32 0, <4 x i1> %1)
  ret void
}

define <8 x i16> @test_vcx1q_m(<2 x i64> %inactive, i16 zeroext %p) {
; CHECK-LABEL: @test_vcx1q_m(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = zext i16 [[P:%.*]] to i32
; CHECK-NEXT:    [[TMP1:%.*]] = tail call <4 x i1> @llvm.arm.mve.pred.i2v.v4i1(i32 [[TMP0]])
; CHECK-NEXT:    [[TMP2:%.*]] = call i32 @llvm.arm.mve.pred.v2i.v4i1(<4 x i1> [[TMP1]])
; CHECK-NEXT:    [[TMP3:%.*]] = call <2 x i1> @llvm.arm.mve.pred.i2v.v2i1(i32 [[TMP2]])
; CHECK-NEXT:    [[TMP4:%.*]] = call <2 x i64> @llvm.arm.cde.vcx1q.predicated.v2i64.v2i1(i32 0, <2 x i64> [[INACTIVE:%.*]], i32 1111, <2 x i1> [[TMP3]])
; CHECK-NEXT:    [[TMP5:%.*]] = bitcast <2 x i64> [[TMP4]] to <8 x i16>
; CHECK-NEXT:    ret <8 x i16> [[TMP5]]
;
entry:
  %0 = zext i16 %p to i32
  %1 = tail call <4 x i1> @llvm.arm.mve.pred.i2v.v4i1(i32 %0)
  %2 = tail call <2 x i64> @llvm.arm.cde.vcx1q.predicated.v2i64.v4i1(i32 0, <2 x i64> %inactive, i32 1111, <4 x i1> %1)
  %3 = bitcast <2 x i64> %2 to <8 x i16>
  ret <8 x i16> %3
}

define <16 x i8> @test_vcx1qa_m(<2 x i64> %acc, i16 zeroext %p) {
; CHECK-LABEL: @test_vcx1qa_m(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = zext i16 [[P:%.*]] to i32
; CHECK-NEXT:    [[TMP1:%.*]] = tail call <4 x i1> @llvm.arm.mve.pred.i2v.v4i1(i32 [[TMP0]])
; CHECK-NEXT:    [[TMP2:%.*]] = call i32 @llvm.arm.mve.pred.v2i.v4i1(<4 x i1> [[TMP1]])
; CHECK-NEXT:    [[TMP3:%.*]] = call <2 x i1> @llvm.arm.mve.pred.i2v.v2i1(i32 [[TMP2]])
; CHECK-NEXT:    [[TMP4:%.*]] = call <2 x i64> @llvm.arm.cde.vcx1qa.predicated.v2i64.v2i1(i32 0, <2 x i64> [[ACC:%.*]], i32 1112, <2 x i1> [[TMP3]])
; CHECK-NEXT:    [[TMP5:%.*]] = bitcast <2 x i64> [[TMP4]] to <16 x i8>
; CHECK-NEXT:    ret <16 x i8> [[TMP5]]
;
entry:
  %0 = zext i16 %p to i32
  %1 = tail call <4 x i1> @llvm.arm.mve.pred.i2v.v4i1(i32 %0)
  %2 = tail call <2 x i64> @llvm.arm.cde.vcx1qa.predicated.v2i64.v4i1(i32 0, <2 x i64> %acc, i32 1112, <4 x i1> %1)
  %3 = bitcast <2 x i64> %2 to <16 x i8>
  ret <16 x i8> %3
}

define <4 x i32> @test_vcx2q_m(<2 x i64> %inactive, <4 x float> %n, i16 zeroext %p) {
; CHECK-LABEL: @test_vcx2q_m(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = bitcast <4 x float> [[N:%.*]] to <16 x i8>
; CHECK-NEXT:    [[TMP1:%.*]] = zext i16 [[P:%.*]] to i32
; CHECK-NEXT:    [[TMP2:%.*]] = tail call <4 x i1> @llvm.arm.mve.pred.i2v.v4i1(i32 [[TMP1]])
; CHECK-NEXT:    [[TMP3:%.*]] = call i32 @llvm.arm.mve.pred.v2i.v4i1(<4 x i1> [[TMP2]])
; CHECK-NEXT:    [[TMP4:%.*]] = call <2 x i1> @llvm.arm.mve.pred.i2v.v2i1(i32 [[TMP3]])
; CHECK-NEXT:    [[TMP5:%.*]] = call <2 x i64> @llvm.arm.cde.vcx2q.predicated.v2i64.v2i1(i32 0, <2 x i64> [[INACTIVE:%.*]], <16 x i8> [[TMP0]], i32 111, <2 x i1> [[TMP4]])
; CHECK-NEXT:    [[TMP6:%.*]] = bitcast <2 x i64> [[TMP5]] to <4 x i32>
; CHECK-NEXT:    ret <4 x i32> [[TMP6]]
;
entry:
  %0 = bitcast <4 x float> %n to <16 x i8>
  %1 = zext i16 %p to i32
  %2 = tail call <4 x i1> @llvm.arm.mve.pred.i2v.v4i1(i32 %1)
  %3 = tail call <2 x i64> @llvm.arm.cde.vcx2q.predicated.v2i64.v4i1(i32 0, <2 x i64> %inactive, <16 x i8> %0, i32 111, <4 x i1> %2)
  %4 = bitcast <2 x i64> %3 to <4 x i32>
  ret <4 x i32> %4
}

define <4 x float> @test_vcx2qa_m(<2 x i64> %acc, <8 x half> %n, i16 zeroext %p) {
; CHECK-LABEL: @test_vcx2qa_m(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = bitcast <8 x half> [[N:%.*]] to <16 x i8>
; CHECK-NEXT:    [[TMP1:%.*]] = zext i16 [[P:%.*]] to i32
; CHECK-NEXT:    [[TMP2:%.*]] = tail call <4 x i1> @llvm.arm.mve.pred.i2v.v4i1(i32 [[TMP1]])
; CHECK-NEXT:    [[TMP3:%.*]] = call i32 @llvm.arm.mve.pred.v2i.v4i1(<4 x i1> [[TMP2]])
; CHECK-NEXT:    [[TMP4:%.*]] = call <2 x i1> @llvm.arm.mve.pred.i2v.v2i1(i32 [[TMP3]])
; CHECK-NEXT:    [[TMP5:%.*]] = call <2 x i64> @llvm.arm.cde.vcx2qa.predicated.v2i64.v2i1(i32 0, <2 x i64> [[ACC:%.*]], <16 x i8> [[TMP0]], i32 112, <2 x i1> [[TMP4]])
; CHECK-NEXT:    [[TMP6:%.*]] = bitcast <2 x i64> [[TMP5]] to <4 x float>
; CHECK-NEXT:    ret <4 x float> [[TMP6]]
;
entry:
  %0 = bitcast <8 x half> %n to <16 x i8>
  %1 = zext i16 %p to i32
  %2 = tail call <4 x i1> @llvm.arm.mve.pred.i2v.v4i1(i32 %1)
  %3 = tail call <2 x i64> @llvm.arm.cde.vcx2qa.predicated.v2i64.v4i1(i32 0, <2 x i64> %acc, <16 x i8> %0, i32 112, <4 x i1> %2)
  %4 = bitcast <2 x i64> %3 to <4 x float>
  ret <4 x float> %4
}

define <2 x i64> @test_vcx3q_m(<2 x i64> %inactive, <4 x float> %n, <16 x i8> %m, i16 zeroext %p) {
; CHECK-LABEL: @test_vcx3q_m(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = bitcast <4 x float> [[N:%.*]] to <16 x i8>
; CHECK-NEXT:    [[TMP1:%.*]] = zext i16 [[P:%.*]] to i32
; CHECK-NEXT:    [[TMP2:%.*]] = tail call <4 x i1> @llvm.arm.mve.pred.i2v.v4i1(i32 [[TMP1]])
; CHECK-NEXT:    [[TMP3:%.*]] = call i32 @llvm.arm.mve.pred.v2i.v4i1(<4 x i1> [[TMP2]])
; CHECK-NEXT:    [[TMP4:%.*]] = call <2 x i1> @llvm.arm.mve.pred.i2v.v2i1(i32 [[TMP3]])
; CHECK-NEXT:    [[TMP5:%.*]] = call <2 x i64> @llvm.arm.cde.vcx3q.predicated.v2i64.v2i1(i32 0, <2 x i64> [[INACTIVE:%.*]], <16 x i8> [[TMP0]], <16 x i8> [[M:%.*]], i32 11, <2 x i1> [[TMP4]])
; CHECK-NEXT:    ret <2 x i64> [[TMP5]]
;
entry:
  %0 = bitcast <4 x float> %n to <16 x i8>
  %1 = zext i16 %p to i32
  %2 = tail call <4 x i1> @llvm.arm.mve.pred.i2v.v4i1(i32 %1)
  %3 = tail call <2 x i64> @llvm.arm.cde.vcx3q.predicated.v2i64.v4i1(i32 0, <2 x i64> %inactive, <16 x i8> %0, <16 x i8> %m, i32 11, <4 x i1> %2)
  ret <2 x i64> %3
}

define <8 x half> @test_vcx3qa_m(<2 x i64> %inactive, <8 x half> %n, <4 x i32> %m, i16 zeroext %p) {
; CHECK-LABEL: @test_vcx3qa_m(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = bitcast <8 x half> [[N:%.*]] to <16 x i8>
; CHECK-NEXT:    [[TMP1:%.*]] = bitcast <4 x i32> [[M:%.*]] to <16 x i8>
; CHECK-NEXT:    [[TMP2:%.*]] = zext i16 [[P:%.*]] to i32
; CHECK-NEXT:    [[TMP3:%.*]] = tail call <4 x i1> @llvm.arm.mve.pred.i2v.v4i1(i32 [[TMP2]])
; CHECK-NEXT:    [[TMP4:%.*]] = call i32 @llvm.arm.mve.pred.v2i.v4i1(<4 x i1> [[TMP3]])
; CHECK-NEXT:    [[TMP5:%.*]] = call <2 x i1> @llvm.arm.mve.pred.i2v.v2i1(i32 [[TMP4]])
; CHECK-NEXT:    [[TMP6:%.*]] = call <2 x i64> @llvm.arm.cde.vcx3qa.predicated.v2i64.v2i1(i32 0, <2 x i64> [[INACTIVE:%.*]], <16 x i8> [[TMP0]], <16 x i8> [[TMP1]], i32 12, <2 x i1> [[TMP5]])
; CHECK-NEXT:    [[TMP7:%.*]] = bitcast <2 x i64> [[TMP6]] to <8 x half>
; CHECK-NEXT:    ret <8 x half> [[TMP7]]
;
entry:
  %0 = bitcast <8 x half> %n to <16 x i8>
  %1 = bitcast <4 x i32> %m to <16 x i8>
  %2 = zext i16 %p to i32
  %3 = tail call <4 x i1> @llvm.arm.mve.pred.i2v.v4i1(i32 %2)
  %4 = tail call <2 x i64> @llvm.arm.cde.vcx3qa.predicated.v2i64.v4i1(i32 0, <2 x i64> %inactive, <16 x i8> %0, <16 x i8> %1, i32 12, <4 x i1> %3)
  %5 = bitcast <2 x i64> %4 to <8 x half>
  ret <8 x half> %5
}
