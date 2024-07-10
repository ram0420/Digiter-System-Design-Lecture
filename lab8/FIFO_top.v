module FIFO_top #(parameter M=5, N=5)
	(input clk, rst, rd, wr, input[N-1:0] data_in, output empty, full, output[M:0] fifo_cnt, output[N-1:0] data_out);

wire [M-1:0] rd_ptr, wr_ptr;

FIFO #(5,5) F1(clk, rst, rd, wr, data_in, rd_ptr, wr_ptr, fifo_cnt, empty, full, data_out);
count #(5,5) C1(clk, rst, rd, wr, empty, full, fifo_cnt);
pointer #(5,5) P1(clk, rst, rd, wr, empty, full, rd_ptr, wr_ptr);

endmodule

