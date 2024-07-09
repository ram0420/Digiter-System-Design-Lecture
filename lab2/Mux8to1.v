`timescale 1ns/1ns

module Mux8to1 (I0, I1, I2, I3, I4, I5, I6, I7, A, B, C, Z);
input [3:0] I0, I1, I2, I3, I4, I5, I6, I7;
input A, B, C;
output [3:0] Z;

wire [3:0] Z1, Z2;

Mux4to1 M40 (I0, I2, I4, I6, A, B, Z1);
Mux4to1 M41 (I1, I3, I5, I7, A, B, Z2);
Mux Mfinal (Z1, Z2, C, Z);

endmodule
