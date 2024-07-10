`timescale 1ns/1ns

module CLA4(A, B, Ci, Co, PG, GG, S);
input [3:0] A;
input [3:0] B;
input Ci;

output Co; //calculated carry
output PG;
output GG;
output [3:0] S;

wire [3:0] G;
wire [3:0] P;
wire [3:1] C;

CLALogic_1 CarryLogic (G, P, Ci, C, Co, PG, GG);
//module GPFullAdder (X, Y, Cin, G, P, Sum);
GPFullAdder FA0 (A[0], B[0], Ci, G[0], P[0], S[0]);
GPFullAdder FA1 (A[1], B[1], C[1], G[1], P[1], S[1]);
GPFullAdder FA2 (A[2], B[2], C[2], G[2], P[2], S[2]);
GPFullAdder FA3 (A[3], B[3], C[3], G[3], P[3], S[3]);

endmodule

