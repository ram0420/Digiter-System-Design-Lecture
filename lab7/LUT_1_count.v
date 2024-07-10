`timescale 1ns/1ns

module LUT_1_count #(parameter K=4, L=3)
 (input Ck, Reset, rd, wr, input [K-1:0] addr , input [L-1:0]writeData, input [K-1:0] inData, output reg [L-1:0] outData);

reg [L-1:0] mem [0:2**K-1];

always @ (posedge Ck) begin
	if (Reset) outData <= 'bz;
	else if (wr && !rd) mem[addr] <= writeData;
	else if (rd && !wr) outData <= mem[inData];
	else outData <= 'bz;
end


endmodule 
