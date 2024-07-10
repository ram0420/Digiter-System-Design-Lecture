`timescale 1ns/1ns

module LUT_multiplier #(parameter M=10, N=10) 
(input Ck, Reset, rd, wr, input [M-1 : 0] addr, input [N-1:0] writeData, output reg [N-1:0] readData);

reg [N-1:0] mem [0:2**M-1];

always @ (posedge Ck) begin
	if (Reset) readData <= 'bz;
	else if (wr && !rd) mem[addr] <= writeData;
	else if (rd && !wr) readData <= mem[addr];
	else readData <= 'bz;
end

endmodule 