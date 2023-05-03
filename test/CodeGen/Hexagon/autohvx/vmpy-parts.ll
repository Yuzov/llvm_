; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -march=hexagon -mattr=+hvxv60,+hvx-length128b,-packets < %s | FileCheck --check-prefix=V60 %s
; RUN: llc -march=hexagon -mattr=+hvxv62,+hvx-length128b,-packets < %s | FileCheck --check-prefix=V62 %s

define <32 x i32> @f0(<32 x i32> %a0, <32 x i32> %a1) #0 {
; V60-LABEL: f0:
; V60:       // %bb.0:
; V60-NEXT:    {
; V60-NEXT:     r0 = #16
; V60-NEXT:    }
; V60-NEXT:    {
; V60-NEXT:     v2.w = vmpye(v1.w,v0.uh)
; V60-NEXT:    }
; V60-NEXT:    {
; V60-NEXT:     v0.w = vasr(v0.w,r0)
; V60-NEXT:    }
; V60-NEXT:    {
; V60-NEXT:     v3.w = vasr(v1.w,r0)
; V60-NEXT:    }
; V60-NEXT:    {
; V60-NEXT:     v5:4.w = vmpy(v0.h,v1.uh)
; V60-NEXT:    }
; V60-NEXT:    {
; V60-NEXT:     v31:30.w = vmpy(v0.h,v3.h)
; V60-NEXT:    }
; V60-NEXT:    {
; V60-NEXT:     v7:6.w = vadd(v2.uh,v4.uh)
; V60-NEXT:    }
; V60-NEXT:    {
; V60-NEXT:     v29:28.w = vadd(v2.h,v4.h)
; V60-NEXT:    }
; V60-NEXT:    {
; V60-NEXT:     v29.w += vasr(v6.w,r0)
; V60-NEXT:    }
; V60-NEXT:    {
; V60-NEXT:     v0.w = vadd(v29.w,v30.w)
; V60-NEXT:    }
; V60-NEXT:    {
; V60-NEXT:     jumpr r31
; V60-NEXT:    }
;
; V62-LABEL: f0:
; V62:       // %bb.0:
; V62-NEXT:    {
; V62-NEXT:     v3:2 = vmpye(v0.w,v1.uh)
; V62-NEXT:    }
; V62-NEXT:    {
; V62-NEXT:     v3:2 += vmpyo(v0.w,v1.h)
; V62-NEXT:    }
; V62-NEXT:    {
; V62-NEXT:     v0 = v3
; V62-NEXT:    }
; V62-NEXT:    {
; V62-NEXT:     jumpr r31
; V62-NEXT:    }
  %v0 = call {<32 x i32>, <32 x i32>} @llvm.hexagon.V6.vmpyss.parts.128B(<32 x i32> %a0, <32 x i32> %a1)
  %v1 = extractvalue {<32 x i32>, <32 x i32>} %v0, 0
  ret <32 x i32> %v1
}

define <32 x i32> @f1(<32 x i32> %a0, <32 x i32> %a1) #0 {
; V60-LABEL: f1:
; V60:       // %bb.0:
; V60-NEXT:    {
; V60-NEXT:     v2.w = vmpyieo(v0.h,v1.h)
; V60-NEXT:    }
; V60-NEXT:    {
; V60-NEXT:     v2.w += vmpyie(v0.w,v1.uh)
; V60-NEXT:    }
; V60-NEXT:    {
; V60-NEXT:     v0 = v2
; V60-NEXT:    }
; V60-NEXT:    {
; V60-NEXT:     jumpr r31
; V60-NEXT:    }
;
; V62-LABEL: f1:
; V62:       // %bb.0:
; V62-NEXT:    {
; V62-NEXT:     v2.w = vmpyieo(v0.h,v1.h)
; V62-NEXT:    }
; V62-NEXT:    {
; V62-NEXT:     v2.w += vmpyie(v0.w,v1.uh)
; V62-NEXT:    }
; V62-NEXT:    {
; V62-NEXT:     v0 = v2
; V62-NEXT:    }
; V62-NEXT:    {
; V62-NEXT:     jumpr r31
; V62-NEXT:    }
  %v0 = call {<32 x i32>, <32 x i32>} @llvm.hexagon.V6.vmpyss.parts.128B(<32 x i32> %a0, <32 x i32> %a1)
  %v1 = extractvalue {<32 x i32>, <32 x i32>} %v0, 1
  ret <32 x i32> %v1
}

define <32 x i32> @f2(<32 x i32> %a0, <32 x i32> %a1) #0 {
; V60-LABEL: f2:
; V60:       // %bb.0:
; V60-NEXT:    {
; V60-NEXT:     r1:0 = combine(#16,##33686018)
; V60-NEXT:    }
; V60-NEXT:    {
; V60-NEXT:     v3:2.uw = vmpy(v0.uh,v1.uh)
; V60-NEXT:    }
; V60-NEXT:    {
; V60-NEXT:     v30 = vxor(v30,v30)
; V60-NEXT:    }
; V60-NEXT:    {
; V60-NEXT:     v4 = vsplat(r0)
; V60-NEXT:    }
; V60-NEXT:    {
; V60-NEXT:     q0 = vcmp.gt(v30.w,v1.w)
; V60-NEXT:    }
; V60-NEXT:    {
; V60-NEXT:     v2.uw = vlsr(v2.uw,r1)
; V60-NEXT:    }
; V60-NEXT:    {
; V60-NEXT:     v4 = vdelta(v1,v4)
; V60-NEXT:    }
; V60-NEXT:    {
; V60-NEXT:     v5:4.uw = vmpy(v0.uh,v4.uh)
; V60-NEXT:    }
; V60-NEXT:    {
; V60-NEXT:     v5:4.w = vadd(v5.uh,v4.uh)
; V60-NEXT:    }
; V60-NEXT:    {
; V60-NEXT:     v2.w = vadd(v4.w,v2.w)
; V60-NEXT:    }
; V60-NEXT:    {
; V60-NEXT:     v5.w += vasr(v2.w,r1)
; V60-NEXT:    }
; V60-NEXT:    {
; V60-NEXT:     v31.w = vadd(v3.w,v5.w)
; V60-NEXT:    }
; V60-NEXT:    {
; V60-NEXT:     if (q0) v31.w -= v0.w
; V60-NEXT:    }
; V60-NEXT:    {
; V60-NEXT:     v0 = v31
; V60-NEXT:    }
; V60-NEXT:    {
; V60-NEXT:     jumpr r31
; V60-NEXT:    }
;
; V62-LABEL: f2:
; V62:       // %bb.0:
; V62-NEXT:    {
; V62-NEXT:     v3:2 = vmpye(v0.w,v1.uh)
; V62-NEXT:    }
; V62-NEXT:    {
; V62-NEXT:     v4 = vxor(v4,v4)
; V62-NEXT:    }
; V62-NEXT:    {
; V62-NEXT:     q0 = vcmp.gt(v4.w,v0.w)
; V62-NEXT:    }
; V62-NEXT:    {
; V62-NEXT:     v3:2 += vmpyo(v0.w,v1.h)
; V62-NEXT:    }
; V62-NEXT:    {
; V62-NEXT:     if (q0) v3.w += v1.w
; V62-NEXT:    }
; V62-NEXT:    {
; V62-NEXT:     v0 = v3
; V62-NEXT:    }
; V62-NEXT:    {
; V62-NEXT:     jumpr r31
; V62-NEXT:    }
  %v0 = call {<32 x i32>, <32 x i32>} @llvm.hexagon.V6.vmpyus.parts.128B(<32 x i32> %a0, <32 x i32> %a1)
  %v1 = extractvalue {<32 x i32>, <32 x i32>} %v0, 0
  ret <32 x i32> %v1
}

define <32 x i32> @f3(<32 x i32> %a0, <32 x i32> %a1) #0 {
; V60-LABEL: f3:
; V60:       // %bb.0:
; V60-NEXT:    {
; V60-NEXT:     v2.w = vmpyieo(v0.h,v1.h)
; V60-NEXT:    }
; V60-NEXT:    {
; V60-NEXT:     v2.w += vmpyie(v0.w,v1.uh)
; V60-NEXT:    }
; V60-NEXT:    {
; V60-NEXT:     v0 = v2
; V60-NEXT:    }
; V60-NEXT:    {
; V60-NEXT:     jumpr r31
; V60-NEXT:    }
;
; V62-LABEL: f3:
; V62:       // %bb.0:
; V62-NEXT:    {
; V62-NEXT:     v2.w = vmpyieo(v0.h,v1.h)
; V62-NEXT:    }
; V62-NEXT:    {
; V62-NEXT:     v2.w += vmpyie(v0.w,v1.uh)
; V62-NEXT:    }
; V62-NEXT:    {
; V62-NEXT:     v0 = v2
; V62-NEXT:    }
; V62-NEXT:    {
; V62-NEXT:     jumpr r31
; V62-NEXT:    }
  %v0 = call {<32 x i32>, <32 x i32>} @llvm.hexagon.V6.vmpyus.parts.128B(<32 x i32> %a0, <32 x i32> %a1)
  %v1 = extractvalue {<32 x i32>, <32 x i32>} %v0, 1
  ret <32 x i32> %v1
}

define <32 x i32> @f4(<32 x i32> %a0, <32 x i32> %a1) #0 {
; V60-LABEL: f4:
; V60:       // %bb.0:
; V60-NEXT:    {
; V60-NEXT:     r0 = ##33686018
; V60-NEXT:    }
; V60-NEXT:    {
; V60-NEXT:     v3:2.uw = vmpy(v0.uh,v1.uh)
; V60-NEXT:    }
; V60-NEXT:    {
; V60-NEXT:     r2 = #16
; V60-NEXT:    }
; V60-NEXT:    {
; V60-NEXT:     v4 = vsplat(r0)
; V60-NEXT:    }
; V60-NEXT:    {
; V60-NEXT:     v2.uw = vlsr(v2.uw,r2)
; V60-NEXT:    }
; V60-NEXT:    {
; V60-NEXT:     v1 = vdelta(v1,v4)
; V60-NEXT:    }
; V60-NEXT:    {
; V60-NEXT:     v1:0.uw = vmpy(v0.uh,v1.uh)
; V60-NEXT:    }
; V60-NEXT:    {
; V60-NEXT:     v1:0.w = vadd(v1.uh,v0.uh)
; V60-NEXT:    }
; V60-NEXT:    {
; V60-NEXT:     v0.w = vadd(v0.w,v2.w)
; V60-NEXT:    }
; V60-NEXT:    {
; V60-NEXT:     v1.w += vasr(v0.w,r2)
; V60-NEXT:    }
; V60-NEXT:    {
; V60-NEXT:     v0.w = vadd(v3.w,v1.w)
; V60-NEXT:    }
; V60-NEXT:    {
; V60-NEXT:     jumpr r31
; V60-NEXT:    }
;
; V62-LABEL: f4:
; V62:       // %bb.0:
; V62-NEXT:    {
; V62-NEXT:     v2 = vxor(v2,v2)
; V62-NEXT:    }
; V62-NEXT:    {
; V62-NEXT:     v5:4 = vmpye(v0.w,v1.uh)
; V62-NEXT:    }
; V62-NEXT:    {
; V62-NEXT:     q0 = vcmp.gt(v2.w,v0.w)
; V62-NEXT:    }
; V62-NEXT:    {
; V62-NEXT:     q1 = vcmp.gt(v2.w,v1.w)
; V62-NEXT:    }
; V62-NEXT:    {
; V62-NEXT:     v5:4 += vmpyo(v0.w,v1.h)
; V62-NEXT:    }
; V62-NEXT:    {
; V62-NEXT:     v31 = vand(q0,v1)
; V62-NEXT:    }
; V62-NEXT:    {
; V62-NEXT:     if (q1) v31.w += v0.w
; V62-NEXT:    }
; V62-NEXT:    {
; V62-NEXT:     v0.w = vadd(v5.w,v31.w)
; V62-NEXT:    }
; V62-NEXT:    {
; V62-NEXT:     jumpr r31
; V62-NEXT:    }
  %v0 = call {<32 x i32>, <32 x i32>} @llvm.hexagon.V6.vmpyuu.parts.128B(<32 x i32> %a0, <32 x i32> %a1)
  %v1 = extractvalue {<32 x i32>, <32 x i32>} %v0, 0
  ret <32 x i32> %v1
}

define <32 x i32> @f5(<32 x i32> %a0, <32 x i32> %a1) #0 {
; V60-LABEL: f5:
; V60:       // %bb.0:
; V60-NEXT:    {
; V60-NEXT:     v2.w = vmpyieo(v0.h,v1.h)
; V60-NEXT:    }
; V60-NEXT:    {
; V60-NEXT:     v2.w += vmpyie(v0.w,v1.uh)
; V60-NEXT:    }
; V60-NEXT:    {
; V60-NEXT:     v0 = v2
; V60-NEXT:    }
; V60-NEXT:    {
; V60-NEXT:     jumpr r31
; V60-NEXT:    }
;
; V62-LABEL: f5:
; V62:       // %bb.0:
; V62-NEXT:    {
; V62-NEXT:     v2.w = vmpyieo(v0.h,v1.h)
; V62-NEXT:    }
; V62-NEXT:    {
; V62-NEXT:     v2.w += vmpyie(v0.w,v1.uh)
; V62-NEXT:    }
; V62-NEXT:    {
; V62-NEXT:     v0 = v2
; V62-NEXT:    }
; V62-NEXT:    {
; V62-NEXT:     jumpr r31
; V62-NEXT:    }
  %v0 = call {<32 x i32>, <32 x i32>} @llvm.hexagon.V6.vmpyuu.parts.128B(<32 x i32> %a0, <32 x i32> %a1)
  %v1 = extractvalue {<32 x i32>, <32 x i32>} %v0, 1
  ret <32 x i32> %v1
}

define <64 x i32> @f10(<32 x i32> %a0, <32 x i32> %a1) #0 {
; V60-LABEL: f10:
; V60:       // %bb.0:
; V60-NEXT:    {
; V60-NEXT:     r0 = ##33686018
; V60-NEXT:    }
; V60-NEXT:    {
; V60-NEXT:     v3:2.uw = vmpy(v0.uh,v1.uh)
; V60-NEXT:    }
; V60-NEXT:    {
; V60-NEXT:     r2 = #16
; V60-NEXT:    }
; V60-NEXT:    {
; V60-NEXT:     v4 = vxor(v4,v4)
; V60-NEXT:    }
; V60-NEXT:    {
; V60-NEXT:     v5 = vsplat(r0)
; V60-NEXT:    }
; V60-NEXT:    {
; V60-NEXT:     q1 = vcmp.gt(v4.w,v0.w)
; V60-NEXT:    }
; V60-NEXT:    {
; V60-NEXT:     q0 = vcmp.gt(v4.w,v1.w)
; V60-NEXT:    }
; V60-NEXT:    {
; V60-NEXT:     v6.uw = vlsr(v2.uw,r2)
; V60-NEXT:    }
; V60-NEXT:    {
; V60-NEXT:     v5 = vdelta(v1,v5)
; V60-NEXT:    }
; V60-NEXT:    {
; V60-NEXT:     v1 = vmux(q1,v1,v4)
; V60-NEXT:    }
; V60-NEXT:    {
; V60-NEXT:     if (q0) v1.w += v0.w
; V60-NEXT:    }
; V60-NEXT:    {
; V60-NEXT:     v9:8.uw = vmpy(v0.uh,v5.uh)
; V60-NEXT:    }
; V60-NEXT:    {
; V60-NEXT:     v9:8.w = vadd(v9.uh,v8.uh)
; V60-NEXT:    }
; V60-NEXT:    {
; V60-NEXT:     v31.w = vadd(v8.w,v6.w)
; V60-NEXT:    }
; V60-NEXT:    {
; V60-NEXT:     v2.w += vasl(v8.w,r2)
; V60-NEXT:    }
; V60-NEXT:    {
; V60-NEXT:     v9.w += vasr(v31.w,r2)
; V60-NEXT:    }
; V60-NEXT:    {
; V60-NEXT:     v0.w = vadd(v3.w,v9.w)
; V60-NEXT:    }
; V60-NEXT:    {
; V60-NEXT:     v3.w = vsub(v0.w,v1.w)
; V60-NEXT:    }
; V60-NEXT:    {
; V60-NEXT:     v1:0 = vcombine(v3,v2)
; V60-NEXT:    }
; V60-NEXT:    {
; V60-NEXT:     jumpr r31
; V60-NEXT:    }
;
; V62-LABEL: f10:
; V62:       // %bb.0:
; V62-NEXT:    {
; V62-NEXT:     v3:2 = vmpye(v0.w,v1.uh)
; V62-NEXT:    }
; V62-NEXT:    {
; V62-NEXT:     v3:2 += vmpyo(v0.w,v1.h)
; V62-NEXT:    }
; V62-NEXT:    {
; V62-NEXT:     v1:0 = vcombine(v3,v2)
; V62-NEXT:    }
; V62-NEXT:    {
; V62-NEXT:     jumpr r31
; V62-NEXT:    }
  %v0 = call {<32 x i32>, <32 x i32>} @llvm.hexagon.V6.vmpyss.parts.128B(<32 x i32> %a0, <32 x i32> %a1)
  %v1 = extractvalue {<32 x i32>, <32 x i32>} %v0, 0
  %v2 = extractvalue {<32 x i32>, <32 x i32>} %v0, 1
  %v3 = shufflevector <32 x i32> %v2, <32 x i32> %v1, <64 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i32 15, i32 16, i32 17, i32 18, i32 19, i32 20, i32 21, i32 22, i32 23, i32 24, i32 25, i32 26, i32 27, i32 28, i32 29, i32 30, i32 31, i32 32, i32 33, i32 34, i32 35, i32 36, i32 37, i32 38, i32 39, i32 40, i32 41, i32 42, i32 43, i32 44, i32 45, i32 46, i32 47, i32 48, i32 49, i32 50, i32 51, i32 52, i32 53, i32 54, i32 55, i32 56, i32 57, i32 58, i32 59, i32 60, i32 61, i32 62, i32 63>
  ret <64 x i32> %v3
}

define <64 x i32> @f11(<32 x i32> %a0, <32 x i32> %a1) #0 {
; V60-LABEL: f11:
; V60:       // %bb.0:
; V60-NEXT:    {
; V60-NEXT:     r1:0 = combine(#16,##33686018)
; V60-NEXT:    }
; V60-NEXT:    {
; V60-NEXT:     v3:2.uw = vmpy(v0.uh,v1.uh)
; V60-NEXT:    }
; V60-NEXT:    {
; V60-NEXT:     v31 = vxor(v31,v31)
; V60-NEXT:    }
; V60-NEXT:    {
; V60-NEXT:     v4 = vsplat(r0)
; V60-NEXT:    }
; V60-NEXT:    {
; V60-NEXT:     q0 = vcmp.gt(v31.w,v1.w)
; V60-NEXT:    }
; V60-NEXT:    {
; V60-NEXT:     v5.uw = vlsr(v2.uw,r1)
; V60-NEXT:    }
; V60-NEXT:    {
; V60-NEXT:     v4 = vdelta(v1,v4)
; V60-NEXT:    }
; V60-NEXT:    {
; V60-NEXT:     v7:6.uw = vmpy(v0.uh,v4.uh)
; V60-NEXT:    }
; V60-NEXT:    {
; V60-NEXT:     v7:6.w = vadd(v7.uh,v6.uh)
; V60-NEXT:    }
; V60-NEXT:    {
; V60-NEXT:     v30.w = vadd(v6.w,v5.w)
; V60-NEXT:    }
; V60-NEXT:    {
; V60-NEXT:     v2.w += vasl(v6.w,r1)
; V60-NEXT:    }
; V60-NEXT:    {
; V60-NEXT:     v7.w += vasr(v30.w,r1)
; V60-NEXT:    }
; V60-NEXT:    {
; V60-NEXT:     v3.w = vadd(v3.w,v7.w)
; V60-NEXT:    }
; V60-NEXT:    {
; V60-NEXT:     if (q0) v3.w -= v0.w
; V60-NEXT:    }
; V60-NEXT:    {
; V60-NEXT:     v1:0 = vcombine(v3,v2)
; V60-NEXT:    }
; V60-NEXT:    {
; V60-NEXT:     jumpr r31
; V60-NEXT:    }
;
; V62-LABEL: f11:
; V62:       // %bb.0:
; V62-NEXT:    {
; V62-NEXT:     v3:2 = vmpye(v0.w,v1.uh)
; V62-NEXT:    }
; V62-NEXT:    {
; V62-NEXT:     v4 = vxor(v4,v4)
; V62-NEXT:    }
; V62-NEXT:    {
; V62-NEXT:     q0 = vcmp.gt(v4.w,v0.w)
; V62-NEXT:    }
; V62-NEXT:    {
; V62-NEXT:     v3:2 += vmpyo(v0.w,v1.h)
; V62-NEXT:    }
; V62-NEXT:    {
; V62-NEXT:     if (q0) v3.w += v1.w
; V62-NEXT:    }
; V62-NEXT:    {
; V62-NEXT:     v1:0 = vcombine(v3,v2)
; V62-NEXT:    }
; V62-NEXT:    {
; V62-NEXT:     jumpr r31
; V62-NEXT:    }
  %v0 = call {<32 x i32>, <32 x i32>} @llvm.hexagon.V6.vmpyus.parts.128B(<32 x i32> %a0, <32 x i32> %a1)
  %v1 = extractvalue {<32 x i32>, <32 x i32>} %v0, 0
  %v2 = extractvalue {<32 x i32>, <32 x i32>} %v0, 1
  %v3 = shufflevector <32 x i32> %v2, <32 x i32> %v1, <64 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i32 15, i32 16, i32 17, i32 18, i32 19, i32 20, i32 21, i32 22, i32 23, i32 24, i32 25, i32 26, i32 27, i32 28, i32 29, i32 30, i32 31, i32 32, i32 33, i32 34, i32 35, i32 36, i32 37, i32 38, i32 39, i32 40, i32 41, i32 42, i32 43, i32 44, i32 45, i32 46, i32 47, i32 48, i32 49, i32 50, i32 51, i32 52, i32 53, i32 54, i32 55, i32 56, i32 57, i32 58, i32 59, i32 60, i32 61, i32 62, i32 63>
  ret <64 x i32> %v3
}

define <64 x i32> @f12(<32 x i32> %a0, <32 x i32> %a1) #0 {
; V60-LABEL: f12:
; V60:       // %bb.0:
; V60-NEXT:    {
; V60-NEXT:     r1:0 = combine(#16,##33686018)
; V60-NEXT:    }
; V60-NEXT:    {
; V60-NEXT:     v3:2.uw = vmpy(v0.uh,v1.uh)
; V60-NEXT:    }
; V60-NEXT:    {
; V60-NEXT:     v4 = vsplat(r0)
; V60-NEXT:    }
; V60-NEXT:    {
; V60-NEXT:     v5.uw = vlsr(v2.uw,r1)
; V60-NEXT:    }
; V60-NEXT:    {
; V60-NEXT:     v1 = vdelta(v1,v4)
; V60-NEXT:    }
; V60-NEXT:    {
; V60-NEXT:     v1:0.uw = vmpy(v0.uh,v1.uh)
; V60-NEXT:    }
; V60-NEXT:    {
; V60-NEXT:     v1:0.w = vadd(v1.uh,v0.uh)
; V60-NEXT:    }
; V60-NEXT:    {
; V60-NEXT:     v31.w = vadd(v0.w,v5.w)
; V60-NEXT:    }
; V60-NEXT:    {
; V60-NEXT:     v2.w += vasl(v0.w,r1)
; V60-NEXT:    }
; V60-NEXT:    {
; V60-NEXT:     v1.w += vasr(v31.w,r1)
; V60-NEXT:    }
; V60-NEXT:    {
; V60-NEXT:     v3.w = vadd(v3.w,v1.w)
; V60-NEXT:    }
; V60-NEXT:    {
; V60-NEXT:     v1:0 = vcombine(v3,v2)
; V60-NEXT:    }
; V60-NEXT:    {
; V60-NEXT:     jumpr r31
; V60-NEXT:    }
;
; V62-LABEL: f12:
; V62:       // %bb.0:
; V62-NEXT:    {
; V62-NEXT:     v4 = vxor(v4,v4)
; V62-NEXT:    }
; V62-NEXT:    {
; V62-NEXT:     v3:2 = vmpye(v0.w,v1.uh)
; V62-NEXT:    }
; V62-NEXT:    {
; V62-NEXT:     q0 = vcmp.gt(v4.w,v0.w)
; V62-NEXT:    }
; V62-NEXT:    {
; V62-NEXT:     q1 = vcmp.gt(v4.w,v1.w)
; V62-NEXT:    }
; V62-NEXT:    {
; V62-NEXT:     v3:2 += vmpyo(v0.w,v1.h)
; V62-NEXT:    }
; V62-NEXT:    {
; V62-NEXT:     v31 = vand(q0,v1)
; V62-NEXT:    }
; V62-NEXT:    {
; V62-NEXT:     if (q1) v31.w += v0.w
; V62-NEXT:    }
; V62-NEXT:    {
; V62-NEXT:     v3.w = vadd(v3.w,v31.w)
; V62-NEXT:    }
; V62-NEXT:    {
; V62-NEXT:     v1:0 = vcombine(v3,v2)
; V62-NEXT:    }
; V62-NEXT:    {
; V62-NEXT:     jumpr r31
; V62-NEXT:    }
  %v0 = call {<32 x i32>, <32 x i32>} @llvm.hexagon.V6.vmpyuu.parts.128B(<32 x i32> %a0, <32 x i32> %a1)
  %v1 = extractvalue {<32 x i32>, <32 x i32>} %v0, 0
  %v2 = extractvalue {<32 x i32>, <32 x i32>} %v0, 1
  %v3 = shufflevector <32 x i32> %v2, <32 x i32> %v1, <64 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i32 15, i32 16, i32 17, i32 18, i32 19, i32 20, i32 21, i32 22, i32 23, i32 24, i32 25, i32 26, i32 27, i32 28, i32 29, i32 30, i32 31, i32 32, i32 33, i32 34, i32 35, i32 36, i32 37, i32 38, i32 39, i32 40, i32 41, i32 42, i32 43, i32 44, i32 45, i32 46, i32 47, i32 48, i32 49, i32 50, i32 51, i32 52, i32 53, i32 54, i32 55, i32 56, i32 57, i32 58, i32 59, i32 60, i32 61, i32 62, i32 63>
  ret <64 x i32> %v3
}

declare {<32 x i32>, <32 x i32>} @llvm.hexagon.V6.vmpyss.parts.128B(<32 x i32>, <32 x i32>)
declare {<32 x i32>, <32 x i32>} @llvm.hexagon.V6.vmpyus.parts.128B(<32 x i32>, <32 x i32>)
declare {<32 x i32>, <32 x i32>} @llvm.hexagon.V6.vmpyuu.parts.128B(<32 x i32>, <32 x i32>)

attributes #0 = { nounwind }
