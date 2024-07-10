`timescale 1ns/1ns
module pointer #(parameter M=5, N=5)
	(input clk, rst, rd, wr, empty, full, output reg [M-1:0] rd_ptr, wr_ptr);

// increase wr_ptr when "wr"
always @(posedge clk) begin
	if (rst) begin
		wr_ptr <= 0;
	end
	else begin
		if ((wr==1)&&(!full)) wr_ptr <= wr_ptr + 1;
		else wr_ptr <= wr_ptr ; end
end

//increase rd_ptr when "rd"
always @(posedge clk) begin
	if (rst) begin
		rd_ptr <= 0;
	end
	else begin
		if ((rd==1)&&(!empty)) rd_ptr <= rd_ptr + 1;
		else if ((rd==1)&&(empty)&&(wr==1)) rd_ptr <= rd_ptr + 1;
		else rd_ptr <= rd_ptr; end
end
endmodule 

