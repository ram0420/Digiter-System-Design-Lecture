`timescale 1ns/1ns

module Mux(X, Y, A, Z);
input [3:0] X, Y;
input A;
output [3:0] Z;

assign Z = (A) ? Y : X;

endmodule
