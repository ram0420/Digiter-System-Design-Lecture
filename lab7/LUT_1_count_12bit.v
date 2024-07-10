`timescale 1ns/1ns

module LUT_1_count_12bit #(parameter K=4, L=3, M=12, N=4)
  (input Ck, Reset, rd, wr, input[K-1:0] addr, input [L-1:0] writeData, input[M-1:0]inData, output wire [N-1:0] outData);

wire [L-1:0] outData1, outData2, outData3;

reg [L-1:0] mem [0:2**K-1];


LUT_1_count C1 (Ck, Reset, rd, wr, addr, writeData, inData[M-9:M-12], outData3);
LUT_1_count C2 (Ck, Reset, rd, wr, addr, writeData, inData[M-5:M-8], outData2);
LUT_1_count C3 (Ck, Reset, rd, wr, addr, writeData, inData[M-1:M-4], outData1);


assign outData = {1'b0, outData1} + outData2 + outData3;

endmodule
