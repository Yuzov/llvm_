; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv32 -mattr=+zknh -verify-machineinstrs < %s \
; RUN:   | FileCheck %s -check-prefix=RV32ZKNH


declare i32 @llvm.riscv.sha256sig0.i32(i32);

define i32 @sha256sig0_i32(i32 %a) nounwind {
; RV32ZKNH-LABEL: sha256sig0_i32:
; RV32ZKNH:       # %bb.0:
; RV32ZKNH-NEXT:    sha256sig0 a0, a0
; RV32ZKNH-NEXT:    ret
    %val = call i32 @llvm.riscv.sha256sig0.i32(i32 %a)
    ret i32 %val
}

declare i32 @llvm.riscv.sha256sig1.i32(i32);

define i32 @sha256sig1_i32(i32 %a) nounwind {
; RV32ZKNH-LABEL: sha256sig1_i32:
; RV32ZKNH:       # %bb.0:
; RV32ZKNH-NEXT:    sha256sig1 a0, a0
; RV32ZKNH-NEXT:    ret
    %val = call i32 @llvm.riscv.sha256sig1.i32(i32 %a)
    ret i32 %val
}

declare i32 @llvm.riscv.sha256sum0.i32(i32);

define i32 @sha256sum0_i32(i32 %a) nounwind {
; RV32ZKNH-LABEL: sha256sum0_i32:
; RV32ZKNH:       # %bb.0:
; RV32ZKNH-NEXT:    sha256sum0 a0, a0
; RV32ZKNH-NEXT:    ret
    %val = call i32 @llvm.riscv.sha256sum0.i32(i32 %a)
    ret i32 %val
}

declare i32 @llvm.riscv.sha256sum1.i32(i32);

define i32 @sha256sum1_i32(i32 %a) nounwind {
; RV32ZKNH-LABEL: sha256sum1_i32:
; RV32ZKNH:       # %bb.0:
; RV32ZKNH-NEXT:    sha256sum1 a0, a0
; RV32ZKNH-NEXT:    ret
    %val = call i32 @llvm.riscv.sha256sum1.i32(i32 %a)
    ret i32 %val
}

declare i32 @llvm.riscv.sha512sig0l(i32, i32);

define i32 @sha512sig0l(i32 %a, i32 %b) nounwind {
; RV32ZKNH-LABEL: sha512sig0l:
; RV32ZKNH:       # %bb.0:
; RV32ZKNH-NEXT:    sha512sig0l a0, a0, a1
; RV32ZKNH-NEXT:    ret
    %val = call i32 @llvm.riscv.sha512sig0l(i32 %a, i32 %b)
    ret i32 %val
}

declare i32 @llvm.riscv.sha512sig0h(i32, i32);

define i32 @sha512sig0h(i32 %a, i32 %b) nounwind {
; RV32ZKNH-LABEL: sha512sig0h:
; RV32ZKNH:       # %bb.0:
; RV32ZKNH-NEXT:    sha512sig0h a0, a0, a1
; RV32ZKNH-NEXT:    ret
    %val = call i32 @llvm.riscv.sha512sig0h(i32 %a, i32 %b)
    ret i32 %val
}

declare i32 @llvm.riscv.sha512sig1l(i32, i32);

define i32 @sha512sig1l(i32 %a, i32 %b) nounwind {
; RV32ZKNH-LABEL: sha512sig1l:
; RV32ZKNH:       # %bb.0:
; RV32ZKNH-NEXT:    sha512sig1l a0, a0, a1
; RV32ZKNH-NEXT:    ret
    %val = call i32 @llvm.riscv.sha512sig1l(i32 %a, i32 %b)
    ret i32 %val
}

declare i32 @llvm.riscv.sha512sig1h(i32, i32);

define i32 @sha512sig1h(i32 %a, i32 %b) nounwind {
; RV32ZKNH-LABEL: sha512sig1h:
; RV32ZKNH:       # %bb.0:
; RV32ZKNH-NEXT:    sha512sig1h a0, a0, a1
; RV32ZKNH-NEXT:    ret
    %val = call i32 @llvm.riscv.sha512sig1h(i32 %a, i32 %b)
    ret i32 %val
}

declare i32 @llvm.riscv.sha512sum0r(i32, i32);

define i32 @sha512sum0r(i32 %a, i32 %b) nounwind {
; RV32ZKNH-LABEL: sha512sum0r:
; RV32ZKNH:       # %bb.0:
; RV32ZKNH-NEXT:    sha512sum0r a0, a0, a1
; RV32ZKNH-NEXT:    ret
    %val = call i32 @llvm.riscv.sha512sum0r(i32 %a, i32 %b)
    ret i32 %val
}

declare i32 @llvm.riscv.sha512sum1r(i32, i32);

define i32 @sha512sum1r(i32 %a, i32 %b) nounwind {
; RV32ZKNH-LABEL: sha512sum1r:
; RV32ZKNH:       # %bb.0:
; RV32ZKNH-NEXT:    sha512sum1r a0, a0, a1
; RV32ZKNH-NEXT:    ret
    %val = call i32 @llvm.riscv.sha512sum1r(i32 %a, i32 %b)
    ret i32 %val
}
