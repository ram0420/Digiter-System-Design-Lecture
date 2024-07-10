`timescale 1ns/1ns
//CLA16 U16 (A,B,Ci,S,Co, PG,GG);
module CLA16(A, B, Ci, S, Co, PG, GG);
input [15:0] A;
input [15:0] B;
input Ci;

output Co;
output PG;
output GG;
output [15:0] S;

wire [3:0] G;
wire [3:0] P;
wire [3:1] C;
wire x;

CLALogic_2 CarryLogic (G, P, Ci, C, Co, PG, GG);
//module CLA4(A, B, Ci, Co, PG, GG, S);
CLA4 CLA4_1 (A[3:0], B[3:0], Ci, x, P[0], G[0], S[3:0]);
CLA4 CLA4_2 (A[7:4], B[7:4], C[1], x, P[1], G[1], S[7:4]);
CLA4 CLA4_3 (A[11:8], B[11:8], C[2], x, P[2], G[2], S[11:8]);
CLA4 CLA4_4 (A[15:12], B[15:12], C[3], Co, P[3], G[3], S[15:12]);

endmodule
