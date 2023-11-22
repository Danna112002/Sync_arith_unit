/* Generated by Yosys 0.9 (git sha1 1979e0b) */

module przesuniecie_rtl(i_arg_A, i_arg_B, o_result, o_error, o_overflow);
  wire _00_;
  wire _01_;
  wire _02_;
  wire _03_;
  wire _04_;
  wire _05_;
  wire _06_;
  wire _07_;
  wire _08_;
  wire _09_;
  wire _10_;
  wire _11_;
  wire _12_;
  wire _13_;
  wire _14_;
  wire _15_;
  wire _16_;
  wire _17_;
  wire _18_;
  wire _19_;
  wire _20_;
  wire _21_;
  wire _22_;
  wire _23_;
  wire _24_;
  wire _25_;
  wire _26_;
  wire _27_;
  wire _28_;
  wire _29_;
  wire _30_;
  wire _31_;
  wire _32_;
  wire \$unknown ;
  input [31:0] i_arg_A;
  input [31:0] i_arg_B;
  output o_error;
  output o_overflow;
  output [31:0] o_result;
  assign _31_ = i_arg_B[4] & i_arg_B[3];
  assign _32_ = i_arg_B[2] & i_arg_B[1];
  assign _00_ = i_arg_B[0] & _32_;
  assign _01_ = _31_ & _00_;
  assign _02_ = i_arg_B[5] | _01_;
  assign _03_ = i_arg_B[9] & i_arg_B[8];
  assign _04_ = i_arg_B[7] & i_arg_B[6];
  assign _05_ = _03_ & _04_;
  assign _06_ = i_arg_B[13] & i_arg_B[12];
  assign _07_ = i_arg_B[11] & i_arg_B[10];
  assign _08_ = _06_ & _07_;
  assign _09_ = i_arg_B[17] & i_arg_B[16];
  assign _10_ = i_arg_B[15] & i_arg_B[14];
  assign _11_ = _09_ & _10_;
  assign _12_ = _08_ & _11_;
  assign _13_ = _05_ & _12_;
  assign _14_ = i_arg_B[31] & i_arg_B[30];
  assign _15_ = i_arg_B[29] & i_arg_B[28];
  assign _16_ = i_arg_B[27] & i_arg_B[26];
  assign _17_ = _15_ & _16_;
  assign _18_ = _14_ & _17_;
  assign _19_ = i_arg_B[21] & i_arg_B[20];
  assign _20_ = i_arg_B[19] & i_arg_B[18];
  assign _21_ = _19_ & _20_;
  assign _22_ = i_arg_B[25] & i_arg_B[24];
  assign _23_ = i_arg_B[23] & i_arg_B[22];
  assign _24_ = _22_ & _23_;
  assign _25_ = _21_ & _24_;
  assign _26_ = _18_ & _25_;
  assign _27_ = _13_ & _26_;
  assign _28_ = _02_ & _27_;
  assign o_overflow = ~_28_;
  assign _29_ = i_arg_B[5] & _01_;
  assign _30_ = _27_ & _29_;
  assign o_result[0] = i_arg_A[0] & _30_;
  assign o_result[1] = i_arg_A[1] & _30_;
  assign o_result[2] = i_arg_A[2] & _30_;
  assign o_result[3] = i_arg_A[3] & _30_;
  assign o_result[4] = i_arg_A[4] & _30_;
  assign o_result[5] = i_arg_A[5] & _30_;
  assign o_result[6] = i_arg_A[6] & _30_;
  assign o_result[7] = i_arg_A[7] & _30_;
  assign o_result[8] = i_arg_A[8] & _30_;
  assign o_result[9] = i_arg_A[9] & _30_;
  assign o_result[10] = i_arg_A[10] & _30_;
  assign o_result[11] = i_arg_A[11] & _30_;
  assign o_result[12] = i_arg_A[12] & _30_;
  assign o_result[13] = i_arg_A[13] & _30_;
  assign o_result[14] = i_arg_A[14] & _30_;
  assign o_result[15] = i_arg_A[15] & _30_;
  assign o_result[16] = i_arg_A[16] & _30_;
  assign o_result[17] = i_arg_A[17] & _30_;
  assign o_result[18] = i_arg_A[18] & _30_;
  assign o_result[19] = i_arg_A[19] & _30_;
  assign o_result[20] = i_arg_A[20] & _30_;
  assign o_result[21] = i_arg_A[21] & _30_;
  assign o_result[22] = i_arg_A[22] & _30_;
  assign o_result[23] = i_arg_A[23] & _30_;
  assign o_result[24] = i_arg_A[24] & _30_;
  assign o_result[25] = i_arg_A[25] & _30_;
  assign o_result[26] = i_arg_A[26] & _30_;
  assign o_result[27] = i_arg_A[27] & _30_;
  assign o_result[28] = i_arg_A[28] & _30_;
  assign o_result[29] = i_arg_A[29] & _30_;
  assign o_result[30] = i_arg_A[30] & _30_;
  assign o_result[31] = i_arg_A[31] & _30_;
  assign \$unknown  = 1'hx;
  assign o_error = 1'h0;
endmodule
