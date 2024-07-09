`timescale 1ns/1ns
module Mux4to1Tester1;

parameter tlimit = 100;

reg [3:0] X1, X2, X3, X4;
reg A, B;

wire [3:0]Z1;

Mux4to1 U1 (X1, X2, X3, X4, A, B, Z1);

integer i;

initial begin
	X1 = 4'b0; X2 = 4'b0; X3 = 4'b0; X4 = 4'b0; A = 1'b0; B = 1'b0;
end

always @(*) begin
	if ($time >= tlimit) $stop;
	else begin
	 for (i =0; i<12; i = i+1) begin
		$display ("time = %d, AB = %d, X1 = %d, X2 = %d, X3 = %d, X4 = %d, Z1 = %d", $time, {A,B}, X1, X2, X3, X4, Z1);
		{A, B} = i%4;
		X1 = X1 +1; X2 = X2 +2; X3 = X3 + 3; X4 = X4 +4;
		end
	end
end

endmodule
