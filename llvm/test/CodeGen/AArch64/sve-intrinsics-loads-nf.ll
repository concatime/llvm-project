; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=aarch64-linux-gnu -mattr=+sve < %s 2>%t | FileCheck %s
; RUN: FileCheck --check-prefix=WARN --allow-empty %s <%t

; If this check fails please read test/CodeGen/AArch64/README for instructions on how to resolve it.
; WARN-NOT: warning

; Range testing for the immediate in the reg+imm(mulvl) addressing
; mode is done only for one instruction. The rest of the instrucions
; test only one immediate value in bound.

define <vscale x 16 x i8> @ldnf1b(<vscale x 16 x i1> %pg, i8* %a) {
; CHECK-LABEL: ldnf1b:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldnf1b { z0.b }, p0/z, [x0]
; CHECK-NEXT:    ret
  %load = call <vscale x 16 x i8> @llvm.aarch64.sve.ldnf1.nxv16i8(<vscale x 16 x i1> %pg, i8* %a)
  ret <vscale x 16 x i8> %load
}

define <vscale x 16 x i8> @ldnf1b_out_of_lower_bound(<vscale x 16 x i1> %pg, i8* %a) {
; CHECK-LABEL: ldnf1b_out_of_lower_bound:
; CHECK:       // %bb.0:
; CHECK-NEXT:    rdvl x8, #-9
; CHECK-NEXT:    add x8, x0, x8
; CHECK-NEXT:    ldnf1b { z0.b }, p0/z, [x8]
; CHECK-NEXT:    ret
  %base_scalable = bitcast i8* %a to <vscale x 16 x i8>*
  %base = getelementptr <vscale x 16 x i8>, <vscale x 16 x i8>* %base_scalable, i64 -9
  %base_scalar = bitcast <vscale x 16 x i8>* %base to i8*
  %load = call <vscale x 16 x i8> @llvm.aarch64.sve.ldnf1.nxv16i8(<vscale x 16 x i1> %pg, i8* %base_scalar)
  ret <vscale x 16 x i8> %load
}

define <vscale x 16 x i8> @ldnf1b_lower_bound(<vscale x 16 x i1> %pg, i8* %a) {
; CHECK-LABEL: ldnf1b_lower_bound:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldnf1b { z0.b }, p0/z, [x0, #-8, mul vl]
; CHECK-NEXT:    ret
  %base_scalable = bitcast i8* %a to <vscale x 16 x i8>*
  %base = getelementptr <vscale x 16 x i8>, <vscale x 16 x i8>* %base_scalable, i64 -8
  %base_scalar = bitcast <vscale x 16 x i8>* %base to i8*
  %load = call <vscale x 16 x i8> @llvm.aarch64.sve.ldnf1.nxv16i8(<vscale x 16 x i1> %pg, i8* %base_scalar)
  ret <vscale x 16 x i8> %load
}

define <vscale x 16 x i8> @ldnf1b_inbound(<vscale x 16 x i1> %pg, i8* %a) {
; CHECK-LABEL: ldnf1b_inbound:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldnf1b { z0.b }, p0/z, [x0, #1, mul vl]
; CHECK-NEXT:    ret
  %base_scalable = bitcast i8* %a to <vscale x 16 x i8>*
  %base = getelementptr <vscale x 16 x i8>, <vscale x 16 x i8>* %base_scalable, i64 1
  %base_scalar = bitcast <vscale x 16 x i8>* %base to i8*
  %load = call <vscale x 16 x i8> @llvm.aarch64.sve.ldnf1.nxv16i8(<vscale x 16 x i1> %pg, i8* %base_scalar)
  ret <vscale x 16 x i8> %load
}

define <vscale x 16 x i8> @ldnf1b_upper_bound(<vscale x 16 x i1> %pg, i8* %a) {
; CHECK-LABEL: ldnf1b_upper_bound:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldnf1b { z0.b }, p0/z, [x0, #7, mul vl]
; CHECK-NEXT:    ret
  %base_scalable = bitcast i8* %a to <vscale x 16 x i8>*
  %base = getelementptr <vscale x 16 x i8>, <vscale x 16 x i8>* %base_scalable, i64 7
  %base_scalar = bitcast <vscale x 16 x i8>* %base to i8*
  %load = call <vscale x 16 x i8> @llvm.aarch64.sve.ldnf1.nxv16i8(<vscale x 16 x i1> %pg, i8* %base_scalar)
  ret <vscale x 16 x i8> %load
}

define <vscale x 16 x i8> @ldnf1b_out_of_upper_bound(<vscale x 16 x i1> %pg, i8* %a) {
; CHECK-LABEL: ldnf1b_out_of_upper_bound:
; CHECK:       // %bb.0:
; CHECK-NEXT:    rdvl x8, #8
; CHECK-NEXT:    add x8, x0, x8
; CHECK-NEXT:    ldnf1b { z0.b }, p0/z, [x8]
; CHECK-NEXT:    ret
  %base_scalable = bitcast i8* %a to <vscale x 16 x i8>*
  %base = getelementptr <vscale x 16 x i8>, <vscale x 16 x i8>* %base_scalable, i64 8
  %base_scalar = bitcast <vscale x 16 x i8>* %base to i8*
  %load = call <vscale x 16 x i8> @llvm.aarch64.sve.ldnf1.nxv16i8(<vscale x 16 x i1> %pg, i8* %base_scalar)
  ret <vscale x 16 x i8> %load
}

define <vscale x 8 x i16> @ldnf1b_h(<vscale x 8 x i1> %pg, i8* %a) {
; CHECK-LABEL: ldnf1b_h:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldnf1b { z0.h }, p0/z, [x0]
; CHECK-NEXT:    ret
  %load = call <vscale x 8 x i8> @llvm.aarch64.sve.ldnf1.nxv8i8(<vscale x 8 x i1> %pg, i8* %a)
  %res = zext <vscale x 8 x i8> %load to <vscale x 8 x i16>
  ret <vscale x 8 x i16> %res
}

define <vscale x 8 x i16> @ldnf1b_h_inbound(<vscale x 8 x i1> %pg, i8* %a) {
; CHECK-LABEL: ldnf1b_h_inbound:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldnf1b { z0.h }, p0/z, [x0, #7, mul vl]
; CHECK-NEXT:    ret
  %base_scalable = bitcast i8* %a to <vscale x 8 x i8>*
  %base = getelementptr <vscale x 8 x i8>, <vscale x 8 x i8>* %base_scalable, i64 7
  %base_scalar = bitcast <vscale x 8 x i8>* %base to i8*
  %load = call <vscale x 8 x i8> @llvm.aarch64.sve.ldnf1.nxv8i8(<vscale x 8 x i1> %pg, i8* %base_scalar)
  %res = zext <vscale x 8 x i8> %load to <vscale x 8 x i16>
  ret <vscale x 8 x i16> %res
}

define <vscale x 8 x i16> @ldnf1sb_h(<vscale x 8 x i1> %pg, i8* %a) {
; CHECK-LABEL: ldnf1sb_h:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldnf1sb { z0.h }, p0/z, [x0]
; CHECK-NEXT:    ret
  %load = call <vscale x 8 x i8> @llvm.aarch64.sve.ldnf1.nxv8i8(<vscale x 8 x i1> %pg, i8* %a)
  %res = sext <vscale x 8 x i8> %load to <vscale x 8 x i16>
  ret <vscale x 8 x i16> %res
}

define <vscale x 8 x i16> @ldnf1sb_h_inbound(<vscale x 8 x i1> %pg, i8* %a) {
; CHECK-LABEL: ldnf1sb_h_inbound:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldnf1sb { z0.h }, p0/z, [x0, #7, mul vl]
; CHECK-NEXT:    ret
  %base_scalable = bitcast i8* %a to <vscale x 8 x i8>*
  %base = getelementptr <vscale x 8 x i8>, <vscale x 8 x i8>* %base_scalable, i64 7
  %base_scalar = bitcast <vscale x 8 x i8>* %base to i8*
  %load = call <vscale x 8 x i8> @llvm.aarch64.sve.ldnf1.nxv8i8(<vscale x 8 x i1> %pg, i8* %base_scalar)
  %res = sext <vscale x 8 x i8> %load to <vscale x 8 x i16>
  ret <vscale x 8 x i16> %res
}

define <vscale x 8 x i16> @ldnf1h(<vscale x 8 x i1> %pg, i16* %a) {
; CHECK-LABEL: ldnf1h:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldnf1h { z0.h }, p0/z, [x0]
; CHECK-NEXT:    ret
  %load = call <vscale x 8 x i16> @llvm.aarch64.sve.ldnf1.nxv8i16(<vscale x 8 x i1> %pg, i16* %a)
  ret <vscale x 8 x i16> %load
}

define <vscale x 8 x i16> @ldnf1h_inbound(<vscale x 8 x i1> %pg, i16* %a) {
; CHECK-LABEL: ldnf1h_inbound:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldnf1h { z0.h }, p0/z, [x0, #1, mul vl]
; CHECK-NEXT:    ret
  %base_scalable = bitcast i16* %a to <vscale x 8 x i16>*
  %base = getelementptr <vscale x 8 x i16>, <vscale x 8 x i16>* %base_scalable, i64 1
  %base_scalar = bitcast <vscale x 8 x i16>* %base to i16*
  %load = call <vscale x 8 x i16> @llvm.aarch64.sve.ldnf1.nxv8i16(<vscale x 8 x i1> %pg, i16* %base_scalar)
  ret <vscale x 8 x i16> %load
}

define <vscale x 8 x half> @ldnf1h_f16(<vscale x 8 x i1> %pg, half* %a) {
; CHECK-LABEL: ldnf1h_f16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldnf1h { z0.h }, p0/z, [x0]
; CHECK-NEXT:    ret
  %load = call <vscale x 8 x half> @llvm.aarch64.sve.ldnf1.nxv8f16(<vscale x 8 x i1> %pg, half* %a)
  ret <vscale x 8 x half> %load
}

define <vscale x 8 x bfloat> @ldnf1h_bf16(<vscale x 8 x i1> %pg, bfloat* %a) #0 {
; CHECK-LABEL: ldnf1h_bf16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldnf1h { z0.h }, p0/z, [x0]
; CHECK-NEXT:    ret
  %load = call <vscale x 8 x bfloat> @llvm.aarch64.sve.ldnf1.nxv8bf16(<vscale x 8 x i1> %pg, bfloat* %a)
  ret <vscale x 8 x bfloat> %load
}

define <vscale x 8 x half> @ldnf1h_f16_inbound(<vscale x 8 x i1> %pg, half* %a) {
; CHECK-LABEL: ldnf1h_f16_inbound:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldnf1h { z0.h }, p0/z, [x0, #1, mul vl]
; CHECK-NEXT:    ret
  %base_scalable = bitcast half* %a to <vscale x 8 x half>*
  %base = getelementptr <vscale x 8 x half>, <vscale x 8 x half>* %base_scalable, i64 1
  %base_scalar = bitcast <vscale x 8 x half>* %base to half*
  %load = call <vscale x 8 x half> @llvm.aarch64.sve.ldnf1.nxv8f16(<vscale x 8 x i1> %pg, half* %base_scalar)
  ret <vscale x 8 x half> %load
}

define <vscale x 8 x bfloat> @ldnf1h_bf16_inbound(<vscale x 8 x i1> %pg, bfloat* %a) #0 {
; CHECK-LABEL: ldnf1h_bf16_inbound:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldnf1h { z0.h }, p0/z, [x0, #1, mul vl]
; CHECK-NEXT:    ret
  %base_scalable = bitcast bfloat* %a to <vscale x 8 x bfloat>*
  %base = getelementptr <vscale x 8 x bfloat>, <vscale x 8 x bfloat>* %base_scalable, i64 1
  %base_scalar = bitcast <vscale x 8 x bfloat>* %base to bfloat*
  %load = call <vscale x 8 x bfloat> @llvm.aarch64.sve.ldnf1.nxv8bf16(<vscale x 8 x i1> %pg, bfloat* %base_scalar)
  ret <vscale x 8 x bfloat> %load
}

define <vscale x 4 x i32> @ldnf1b_s(<vscale x 4 x i1> %pg, i8* %a) {
; CHECK-LABEL: ldnf1b_s:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldnf1b { z0.s }, p0/z, [x0]
; CHECK-NEXT:    ret
  %load = call <vscale x 4 x i8> @llvm.aarch64.sve.ldnf1.nxv4i8(<vscale x 4 x i1> %pg, i8* %a)
  %res = zext <vscale x 4 x i8> %load to <vscale x 4 x i32>
  ret <vscale x 4 x i32> %res
}

define <vscale x 4 x i32> @ldnf1b_s_inbound(<vscale x 4 x i1> %pg, i8* %a) {
; CHECK-LABEL: ldnf1b_s_inbound:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldnf1b { z0.s }, p0/z, [x0, #7, mul vl]
; CHECK-NEXT:    ret
  %base_scalable = bitcast i8* %a to <vscale x 4 x i8>*
  %base = getelementptr <vscale x 4 x i8>, <vscale x 4 x i8>* %base_scalable, i64 7
  %base_scalar = bitcast <vscale x 4 x i8>* %base to i8*
  %load = call <vscale x 4 x i8> @llvm.aarch64.sve.ldnf1.nxv4i8(<vscale x 4 x i1> %pg, i8* %base_scalar)
  %res = zext <vscale x 4 x i8> %load to <vscale x 4 x i32>
  ret <vscale x 4 x i32> %res
}

define <vscale x 4 x i32> @ldnf1sb_s(<vscale x 4 x i1> %pg, i8* %a) {
; CHECK-LABEL: ldnf1sb_s:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldnf1sb { z0.s }, p0/z, [x0]
; CHECK-NEXT:    ret
  %load = call <vscale x 4 x i8> @llvm.aarch64.sve.ldnf1.nxv4i8(<vscale x 4 x i1> %pg, i8* %a)
  %res = sext <vscale x 4 x i8> %load to <vscale x 4 x i32>
  ret <vscale x 4 x i32> %res
}

define <vscale x 4 x i32> @ldnf1sb_s_inbound(<vscale x 4 x i1> %pg, i8* %a) {
; CHECK-LABEL: ldnf1sb_s_inbound:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldnf1sb { z0.s }, p0/z, [x0, #7, mul vl]
; CHECK-NEXT:    ret
  %base_scalable = bitcast i8* %a to <vscale x 4 x i8>*
  %base = getelementptr <vscale x 4 x i8>, <vscale x 4 x i8>* %base_scalable, i64 7
  %base_scalar = bitcast <vscale x 4 x i8>* %base to i8*
  %load = call <vscale x 4 x i8> @llvm.aarch64.sve.ldnf1.nxv4i8(<vscale x 4 x i1> %pg, i8* %base_scalar)
  %res = sext <vscale x 4 x i8> %load to <vscale x 4 x i32>
  ret <vscale x 4 x i32> %res
}

define <vscale x 4 x i32> @ldnf1h_s(<vscale x 4 x i1> %pg, i16* %a) {
; CHECK-LABEL: ldnf1h_s:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldnf1h { z0.s }, p0/z, [x0]
; CHECK-NEXT:    ret
  %load = call <vscale x 4 x i16> @llvm.aarch64.sve.ldnf1.nxv4i16(<vscale x 4 x i1> %pg, i16* %a)
  %res = zext <vscale x 4 x i16> %load to <vscale x 4 x i32>
  ret <vscale x 4 x i32> %res
}

define <vscale x 4 x i32> @ldnf1h_s_inbound(<vscale x 4 x i1> %pg, i16* %a) {
; CHECK-LABEL: ldnf1h_s_inbound:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldnf1h { z0.s }, p0/z, [x0, #7, mul vl]
; CHECK-NEXT:    ret
  %base_scalable = bitcast i16* %a to <vscale x 4 x i16>*
  %base = getelementptr <vscale x 4 x i16>, <vscale x 4 x i16>* %base_scalable, i64 7
  %base_scalar = bitcast <vscale x 4 x i16>* %base to i16*
  %load = call <vscale x 4 x i16> @llvm.aarch64.sve.ldnf1.nxv4i16(<vscale x 4 x i1> %pg, i16* %base_scalar)
  %res = zext <vscale x 4 x i16> %load to <vscale x 4 x i32>
  ret <vscale x 4 x i32> %res
}

define <vscale x 4 x i32> @ldnf1sh_s(<vscale x 4 x i1> %pg, i16* %a) {
; CHECK-LABEL: ldnf1sh_s:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldnf1sh { z0.s }, p0/z, [x0]
; CHECK-NEXT:    ret
  %load = call <vscale x 4 x i16> @llvm.aarch64.sve.ldnf1.nxv4i16(<vscale x 4 x i1> %pg, i16* %a)
  %res = sext <vscale x 4 x i16> %load to <vscale x 4 x i32>
  ret <vscale x 4 x i32> %res
}

define <vscale x 4 x i32> @ldnf1sh_s_inbound(<vscale x 4 x i1> %pg, i16* %a) {
; CHECK-LABEL: ldnf1sh_s_inbound:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldnf1sh { z0.s }, p0/z, [x0, #7, mul vl]
; CHECK-NEXT:    ret
  %base_scalable = bitcast i16* %a to <vscale x 4 x i16>*
  %base = getelementptr <vscale x 4 x i16>, <vscale x 4 x i16>* %base_scalable, i64 7
  %base_scalar = bitcast <vscale x 4 x i16>* %base to i16*
  %load = call <vscale x 4 x i16> @llvm.aarch64.sve.ldnf1.nxv4i16(<vscale x 4 x i1> %pg, i16* %base_scalar)
  %res = sext <vscale x 4 x i16> %load to <vscale x 4 x i32>
  ret <vscale x 4 x i32> %res
}

define <vscale x 4 x i32> @ldnf1w(<vscale x 4 x i1> %pg, i32* %a) {
; CHECK-LABEL: ldnf1w:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldnf1w { z0.s }, p0/z, [x0]
; CHECK-NEXT:    ret
  %load = call <vscale x 4 x i32> @llvm.aarch64.sve.ldnf1.nxv4i32(<vscale x 4 x i1> %pg, i32* %a)
  ret <vscale x 4 x i32> %load
}

define <vscale x 4 x i32> @ldnf1w_inbound(<vscale x 4 x i1> %pg, i32* %a) {
; CHECK-LABEL: ldnf1w_inbound:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldnf1w { z0.s }, p0/z, [x0, #7, mul vl]
; CHECK-NEXT:    ret
  %base_scalable = bitcast i32* %a to <vscale x 4 x i32>*
  %base = getelementptr <vscale x 4 x i32>, <vscale x 4 x i32>* %base_scalable, i64 7
  %base_scalar = bitcast <vscale x 4 x i32>* %base to i32*
  %load = call <vscale x 4 x i32> @llvm.aarch64.sve.ldnf1.nxv4i32(<vscale x 4 x i1> %pg, i32* %base_scalar)
  ret <vscale x 4 x i32> %load
}

define <vscale x 4 x float> @ldnf1w_f32(<vscale x 4 x i1> %pg, float* %a) {
; CHECK-LABEL: ldnf1w_f32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldnf1w { z0.s }, p0/z, [x0]
; CHECK-NEXT:    ret
  %load = call <vscale x 4 x float> @llvm.aarch64.sve.ldnf1.nxv4f32(<vscale x 4 x i1> %pg, float* %a)
  ret <vscale x 4 x float> %load
}

define <vscale x 4 x float> @ldnf1w_f32_inbound(<vscale x 4 x i1> %pg, float* %a) {
; CHECK-LABEL: ldnf1w_f32_inbound:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldnf1w { z0.s }, p0/z, [x0, #7, mul vl]
; CHECK-NEXT:    ret
  %base_scalable = bitcast float* %a to <vscale x 4 x float>*
  %base = getelementptr <vscale x 4 x float>, <vscale x 4 x float>* %base_scalable, i64 7
  %base_scalar = bitcast <vscale x 4 x float>* %base to float*
  %load = call <vscale x 4 x float> @llvm.aarch64.sve.ldnf1.nxv4f32(<vscale x 4 x i1> %pg, float* %base_scalar)
  ret <vscale x 4 x float> %load
}

define <vscale x 2 x i64> @ldnf1b_d(<vscale x 2 x i1> %pg, i8* %a) {
; CHECK-LABEL: ldnf1b_d:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldnf1b { z0.d }, p0/z, [x0]
; CHECK-NEXT:    ret
  %load = call <vscale x 2 x i8> @llvm.aarch64.sve.ldnf1.nxv2i8(<vscale x 2 x i1> %pg, i8* %a)
  %res = zext <vscale x 2 x i8> %load to <vscale x 2 x i64>
  ret <vscale x 2 x i64> %res
}

define <vscale x 2 x i64> @ldnf1b_d_inbound(<vscale x 2 x i1> %pg, i8* %a) {
; CHECK-LABEL: ldnf1b_d_inbound:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldnf1b { z0.d }, p0/z, [x0, #7, mul vl]
; CHECK-NEXT:    ret
  %base_scalable = bitcast i8* %a to <vscale x 2 x i8>*
  %base = getelementptr <vscale x 2 x i8>, <vscale x 2 x i8>* %base_scalable, i64 7
  %base_scalar = bitcast <vscale x 2 x i8>* %base to i8*
  %load = call <vscale x 2 x i8> @llvm.aarch64.sve.ldnf1.nxv2i8(<vscale x 2 x i1> %pg, i8* %base_scalar)
  %res = zext <vscale x 2 x i8> %load to <vscale x 2 x i64>
  ret <vscale x 2 x i64> %res
}

define <vscale x 2 x i64> @ldnf1sb_d(<vscale x 2 x i1> %pg, i8* %a) {
; CHECK-LABEL: ldnf1sb_d:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldnf1sb { z0.d }, p0/z, [x0]
; CHECK-NEXT:    ret
  %load = call <vscale x 2 x i8> @llvm.aarch64.sve.ldnf1.nxv2i8(<vscale x 2 x i1> %pg, i8* %a)
  %res = sext <vscale x 2 x i8> %load to <vscale x 2 x i64>
  ret <vscale x 2 x i64> %res
}

define <vscale x 2 x i64> @ldnf1sb_d_inbound(<vscale x 2 x i1> %pg, i8* %a) {
; CHECK-LABEL: ldnf1sb_d_inbound:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldnf1sb { z0.d }, p0/z, [x0, #7, mul vl]
; CHECK-NEXT:    ret
  %base_scalable = bitcast i8* %a to <vscale x 2 x i8>*
  %base = getelementptr <vscale x 2 x i8>, <vscale x 2 x i8>* %base_scalable, i64 7
  %base_scalar = bitcast <vscale x 2 x i8>* %base to i8*
  %load = call <vscale x 2 x i8> @llvm.aarch64.sve.ldnf1.nxv2i8(<vscale x 2 x i1> %pg, i8* %base_scalar)
  %res = sext <vscale x 2 x i8> %load to <vscale x 2 x i64>
  ret <vscale x 2 x i64> %res
}

define <vscale x 2 x i64> @ldnf1h_d(<vscale x 2 x i1> %pg, i16* %a) {
; CHECK-LABEL: ldnf1h_d:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldnf1h { z0.d }, p0/z, [x0]
; CHECK-NEXT:    ret
  %load = call <vscale x 2 x i16> @llvm.aarch64.sve.ldnf1.nxv2i16(<vscale x 2 x i1> %pg, i16* %a)
  %res = zext <vscale x 2 x i16> %load to <vscale x 2 x i64>
  ret <vscale x 2 x i64> %res
}

define <vscale x 2 x i64> @ldnf1h_d_inbound(<vscale x 2 x i1> %pg, i16* %a) {
; CHECK-LABEL: ldnf1h_d_inbound:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldnf1h { z0.d }, p0/z, [x0, #7, mul vl]
; CHECK-NEXT:    ret
  %base_scalable = bitcast i16* %a to <vscale x 2 x i16>*
  %base = getelementptr <vscale x 2 x i16>, <vscale x 2 x i16>* %base_scalable, i64 7
  %base_scalar = bitcast <vscale x 2 x i16>* %base to i16*
  %load = call <vscale x 2 x i16> @llvm.aarch64.sve.ldnf1.nxv2i16(<vscale x 2 x i1> %pg, i16* %base_scalar)
  %res = zext <vscale x 2 x i16> %load to <vscale x 2 x i64>
  ret <vscale x 2 x i64> %res
}

define <vscale x 2 x i64> @ldnf1sh_d(<vscale x 2 x i1> %pg, i16* %a) {
; CHECK-LABEL: ldnf1sh_d:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldnf1sh { z0.d }, p0/z, [x0]
; CHECK-NEXT:    ret
  %load = call <vscale x 2 x i16> @llvm.aarch64.sve.ldnf1.nxv2i16(<vscale x 2 x i1> %pg, i16* %a)
  %res = sext <vscale x 2 x i16> %load to <vscale x 2 x i64>
  ret <vscale x 2 x i64> %res
}

define <vscale x 2 x i64> @ldnf1sh_d_inbound(<vscale x 2 x i1> %pg, i16* %a) {
; CHECK-LABEL: ldnf1sh_d_inbound:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldnf1sh { z0.d }, p0/z, [x0, #7, mul vl]
; CHECK-NEXT:    ret
  %base_scalable = bitcast i16* %a to <vscale x 2 x i16>*
  %base = getelementptr <vscale x 2 x i16>, <vscale x 2 x i16>* %base_scalable, i64 7
  %base_scalar = bitcast <vscale x 2 x i16>* %base to i16*
  %load = call <vscale x 2 x i16> @llvm.aarch64.sve.ldnf1.nxv2i16(<vscale x 2 x i1> %pg, i16* %base_scalar)
  %res = sext <vscale x 2 x i16> %load to <vscale x 2 x i64>
  ret <vscale x 2 x i64> %res
}

define <vscale x 2 x i64> @ldnf1w_d(<vscale x 2 x i1> %pg, i32* %a) {
; CHECK-LABEL: ldnf1w_d:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldnf1w { z0.d }, p0/z, [x0]
; CHECK-NEXT:    ret
  %load = call <vscale x 2 x i32> @llvm.aarch64.sve.ldnf1.nxv2i32(<vscale x 2 x i1> %pg, i32* %a)
  %res = zext <vscale x 2 x i32> %load to <vscale x 2 x i64>
  ret <vscale x 2 x i64> %res
}

define <vscale x 2 x i64> @ldnf1w_d_inbound(<vscale x 2 x i1> %pg, i32* %a) {
; CHECK-LABEL: ldnf1w_d_inbound:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldnf1w { z0.d }, p0/z, [x0, #7, mul vl]
; CHECK-NEXT:    ret
  %base_scalable = bitcast i32* %a to <vscale x 2 x i32>*
  %base = getelementptr <vscale x 2 x i32>, <vscale x 2 x i32>* %base_scalable, i64 7
  %base_scalar = bitcast <vscale x 2 x i32>* %base to i32*
  %load = call <vscale x 2 x i32> @llvm.aarch64.sve.ldnf1.nxv2i32(<vscale x 2 x i1> %pg, i32* %base_scalar)
  %res = zext <vscale x 2 x i32> %load to <vscale x 2 x i64>
  ret <vscale x 2 x i64> %res
}

define <vscale x 2 x i64> @ldnf1sw_d(<vscale x 2 x i1> %pg, i32* %a) {
; CHECK-LABEL: ldnf1sw_d:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldnf1sw { z0.d }, p0/z, [x0]
; CHECK-NEXT:    ret
  %load = call <vscale x 2 x i32> @llvm.aarch64.sve.ldnf1.nxv2i32(<vscale x 2 x i1> %pg, i32* %a)
  %res = sext <vscale x 2 x i32> %load to <vscale x 2 x i64>
  ret <vscale x 2 x i64> %res
}

define <vscale x 2 x i64> @ldnf1sw_d_inbound(<vscale x 2 x i1> %pg, i32* %a) {
; CHECK-LABEL: ldnf1sw_d_inbound:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldnf1sw { z0.d }, p0/z, [x0, #7, mul vl]
; CHECK-NEXT:    ret
  %base_scalable = bitcast i32* %a to <vscale x 2 x i32>*
  %base = getelementptr <vscale x 2 x i32>, <vscale x 2 x i32>* %base_scalable, i64 7
  %base_scalar = bitcast <vscale x 2 x i32>* %base to i32*
  %load = call <vscale x 2 x i32> @llvm.aarch64.sve.ldnf1.nxv2i32(<vscale x 2 x i1> %pg, i32* %base_scalar)
  %res = sext <vscale x 2 x i32> %load to <vscale x 2 x i64>
  ret <vscale x 2 x i64> %res
}

define <vscale x 2 x i64> @ldnf1d(<vscale x 2 x i1> %pg, i64* %a) {
; CHECK-LABEL: ldnf1d:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldnf1d { z0.d }, p0/z, [x0]
; CHECK-NEXT:    ret
  %load = call <vscale x 2 x i64> @llvm.aarch64.sve.ldnf1.nxv2i64(<vscale x 2 x i1> %pg, i64* %a)
  ret <vscale x 2 x i64> %load
}

define <vscale x 2 x i64> @ldnf1d_inbound(<vscale x 2 x i1> %pg, i64* %a) {
; CHECK-LABEL: ldnf1d_inbound:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldnf1d { z0.d }, p0/z, [x0, #1, mul vl]
; CHECK-NEXT:    ret
  %base_scalable = bitcast i64* %a to <vscale x 2 x i64>*
  %base = getelementptr <vscale x 2 x i64>, <vscale x 2 x i64>* %base_scalable, i64 1
  %base_scalar = bitcast <vscale x 2 x i64>* %base to i64*
  %load = call <vscale x 2 x i64> @llvm.aarch64.sve.ldnf1.nxv2i64(<vscale x 2 x i1> %pg, i64* %base_scalar)
  ret <vscale x 2 x i64> %load
}

define <vscale x 2 x double> @ldnf1d_f64(<vscale x 2 x i1> %pg, double* %a) {
; CHECK-LABEL: ldnf1d_f64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldnf1d { z0.d }, p0/z, [x0]
; CHECK-NEXT:    ret
  %load = call <vscale x 2 x double> @llvm.aarch64.sve.ldnf1.nxv2f64(<vscale x 2 x i1> %pg, double* %a)
  ret <vscale x 2 x double> %load
}

define <vscale x 2 x double> @ldnf1d_f64_inbound(<vscale x 2 x i1> %pg, double* %a) {
; CHECK-LABEL: ldnf1d_f64_inbound:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldnf1d { z0.d }, p0/z, [x0, #1, mul vl]
; CHECK-NEXT:    ret
  %base_scalable = bitcast double* %a to <vscale x 2 x double>*
  %base = getelementptr <vscale x 2 x double>, <vscale x 2 x double>* %base_scalable, i64 1
  %base_scalar = bitcast <vscale x 2 x double>* %base to double*
  %load = call <vscale x 2 x double> @llvm.aarch64.sve.ldnf1.nxv2f64(<vscale x 2 x i1> %pg, double* %base_scalar)
  ret <vscale x 2 x double> %load
}

declare <vscale x 16 x i8> @llvm.aarch64.sve.ldnf1.nxv16i8(<vscale x 16 x i1>, i8*)

declare <vscale x 8 x i8> @llvm.aarch64.sve.ldnf1.nxv8i8(<vscale x 8 x i1>, i8*)
declare <vscale x 8 x i16> @llvm.aarch64.sve.ldnf1.nxv8i16(<vscale x 8 x i1>, i16*)
declare <vscale x 8 x half> @llvm.aarch64.sve.ldnf1.nxv8f16(<vscale x 8 x i1>, half*)
declare <vscale x 8 x bfloat> @llvm.aarch64.sve.ldnf1.nxv8bf16(<vscale x 8 x i1>, bfloat*)

declare <vscale x 4 x i8> @llvm.aarch64.sve.ldnf1.nxv4i8(<vscale x 4 x i1>, i8*)
declare <vscale x 4 x i16> @llvm.aarch64.sve.ldnf1.nxv4i16(<vscale x 4 x i1>, i16*)
declare <vscale x 4 x i32> @llvm.aarch64.sve.ldnf1.nxv4i32(<vscale x 4 x i1>, i32*)
declare <vscale x 4 x float> @llvm.aarch64.sve.ldnf1.nxv4f32(<vscale x 4 x i1>, float*)

declare <vscale x 2 x i8> @llvm.aarch64.sve.ldnf1.nxv2i8(<vscale x 2 x i1>, i8*)
declare <vscale x 2 x i16> @llvm.aarch64.sve.ldnf1.nxv2i16(<vscale x 2 x i1>, i16*)
declare <vscale x 2 x i32> @llvm.aarch64.sve.ldnf1.nxv2i32(<vscale x 2 x i1>, i32*)
declare <vscale x 2 x i64> @llvm.aarch64.sve.ldnf1.nxv2i64(<vscale x 2 x i1>, i64*)
declare <vscale x 2 x double> @llvm.aarch64.sve.ldnf1.nxv2f64(<vscale x 2 x i1>, double*)

; +bf16 is required for the bfloat version.
attributes #0 = { "target-features"="+sve,+bf16" }
