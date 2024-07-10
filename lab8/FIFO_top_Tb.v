`timescale 1ns/1ns 

module FIFO_top_Tb;

parameter ckPeriod = 7;
parameter M = 5;
parameter N = 5;

reg clk = 1'b0;
reg rst = 1'b1;
reg rd = 1'b0;
reg wr = 1'b0;
reg [N-1:0] data_in;

wire empty, full;
wire [N-1:0] data_out;
wire [M:0] fifo_cnt;

wire [M-1:0]rd_ptr, wr_ptr;
pointer #(5,5) PT(clk, rst, rd, wr, empty, full, rd_ptr, wr_ptr);

FIFO_top #(5,5) FT(clk, rst, rd, wr, data_in, empty, full, fifo_cnt, data_out);

always #ckPeriod clk = ~clk;
initial begin //write down to memory
	#20 rst = 1'b0;
end

integer i, k, result;

initial begin //write down to memory
	for (k=0; k<34; k = k+1) begin
		@(posedge clk);
		#3 data_in = k; wr = 1'b1;
	end
	#20 wr = 1'b0;
	
	result = $fopen ("result.txt");
	$fdisplay (result, "time = %d, fifo_cnt = %d", $time, fifo_cnt);
	if (full) $fdisplay (result, "FIFO is full!");

	#20 rd = 1'b1;
	for (i=0; i<34; i=i+1) begin
		@(posedge clk);
		#3; //wait for data available
		$fdisplay (result, "time = %d, data_out = %h, fifo_cnt = %d", $time, data_out, fifo_cnt);
	end
	if (empty) $fdisplay (result, "FIFO is empty!");
	wr = 1'b0; rd = 1'b0;

	#20 $fdisplay (result, "Test with random data! current fifo_count = %d", fifo_cnt);
	for (i=0; i<30; i=i+1) begin
		wr = $random;
		rd = $random;
		data_in = $random;
		@(posedge clk);
		if (wr) #1 $fdisplay (result, "time = %d, wr = %d, data_in = %h", $time, wr, data_in);
		if (rd) #3 $fdisplay (result, "time = %d, rd = %d, data_out = %h", $time, rd, data_out);
			$fdisplay (result, "time = %d, fifo_cnt = %d", $time, fifo_cnt);
	end
	#20 $stop;
end
endmodule 
