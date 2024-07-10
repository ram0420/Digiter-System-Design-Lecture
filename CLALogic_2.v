`timescale 1ns/1ns

module CLALogic_2 (G, P, Ci, C, Co, PG, GG);
input [3:0] G;
input [3:0] P;
input Ci;

output [3:1] C;
output Co;
output PG;
output GG;

assign C[1] = G[0] | (P[0]&Ci);
assign C[2] = G[1] | (P[1]&G[0]) | (P[1]&P[0]&Ci);
assign C[3] = G[2] | (P[2]&G[1]) | (P[2]&P[1]&G[0]) | (P[2]&P[1]&P[0]&Ci);
assign Co = G[3] | (P[3]&G[2]) | (P[3]&P[2]&G[1]) | (P[3]&P[2]&P[1]&G[0]) | (P[3]&P[2]&P[1]&P[0]&Ci);

assign PG = P[3]&P[2]&P[1]&P[0];
assign GG = G[3] | (P[3]&G[2]) | (P[3]&P[2]&G[1]) | (P[3]&P[2]&P[1]&G[0]);

endmodule
