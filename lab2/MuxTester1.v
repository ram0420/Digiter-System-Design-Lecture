`timescale 1ns/1ns
module MuxTester1;

parameter tlimit = 100;

reg [3:0] X = 4'b0;
reg [3:0] Y = 4'b0;
reg A = 0;

wire [3:0] Z;

Mux U (X, Y, A, Z);

always @(*) begin
	if( $time >= tlimit ) $stop ;
	else begin
	 repeat (12) begin
		$display("time = %d, X = %d, Y = %d, A = %d, Z = %d", $time, X, Y, A, Z);
		A = ~A;
		X = X + 1;
		Y = 15 - Y;
		#10;
		end
	end
end

endmodule
