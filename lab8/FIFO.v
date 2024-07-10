`timescale 1ns/1ns

module FIFO #(parameter M=5, N=5)
    (input clk, rst, rd, wr, input[N-1:0] data_in, input [M-1:0] rd_ptr, wr_ptr, input [M:0] fifo_cnt, output empty, full, output[N-1:0] data_out);

reg [N-1:0] fifo_ram [0:2**M-1];
reg [N-1:0] fifo_out;

//write down data_in to fifo_ram when "wr"
always @(posedge clk) begin
	if (rst) fifo_out <= 'bz;
	else begin
	 if ((wr==1)&&(!full)) fifo_ram [wr_ptr] <= data_in;
	 else fifo_out <= 'bz;
	end
end

//read from fifo_ram and put into fifo_out when "rd"
always @(posedge clk) begin
	if (rst) fifo_out <= 'bz;
	else begin
	 if ((rd==1)&&(!empty)) fifo_out <= fifo_ram[rd_ptr];
	 else if ((empty) && (wr == 1) && (rd == 1)) fifo_out <= data_in;
	 else fifo_out <= 'bz;
	end
end

assign data_out = fifo_out;
assign empty = (fifo_cnt == 0);
assign full = (fifo_cnt == 2**M);

endmodule 
