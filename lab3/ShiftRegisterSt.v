`timescale 1ns/1ns

module ShiftRegisterSt (Reset, Ck, Shift, SI, Q);

input Reset, Ck, Shift, SI;
output [3:0] Q;

wire Q0, Q1, Q2;

D_FF DF0(Reset, Ck, Shift, SI, Q0);
D_FF DF1(Reset, Ck, Shift, Q0, Q1);
D_FF DF2(Reset, Ck, Shift, Q1, Q2);
D_FF DF3(Reset, Ck, Shift, Q2, Q);


endmodule
