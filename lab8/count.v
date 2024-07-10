`timescale 1ns/1ns
//increase by each write operation and decreases by each read operation
//does not increase in "full" status and does not decrease in "empty"status
module count #(parameter M=5, N=5)
	(input clk, rst, rd, wr, empty, full, output reg [M:0] fifo_cnt);

always @(posedge clk) begin
	if (rst) fifo_cnt <= 0;
	else begin
		case ({wr, rd})
			2'b10 : begin if(!full)fifo_cnt <= fifo_cnt +1;
				else fifo_cnt <= fifo_cnt; end
			2'b01 : begin if(!empty) fifo_cnt <= fifo_cnt -1;
				else fifo_cnt <= fifo_cnt; end
			default fifo_cnt <= fifo_cnt;
		endcase
	end
end

endmodule 
