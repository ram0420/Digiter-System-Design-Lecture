module Adder8 (A, B, Cin, S, Cout);
output [7:0] S;
output Cout;
input [7:0] A, B;
input Cin;

wire C;

Adder4 A40 (A[3:0], B[3:0], Cin, S[3:0], C);
Adder4 A41 (A[7:4], B[7:4], C, S[7:4], Cout);

endmodule