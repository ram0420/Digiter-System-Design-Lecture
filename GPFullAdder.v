`timescale 1ns/1ns

module GPFullAdder (X, Y, Cin, G, P, Sum);
input X;
input Y;
input Cin;

output G;
output P;
output Sum;

assign G = X & Y;
assign P = X ^ Y;
assign Sum = P ^ Cin;

endmodule
