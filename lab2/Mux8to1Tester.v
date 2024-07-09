`timescale 1ns/1ns
module Mux8to1Tester;

parameter tlimit = 100;

reg [3:0] X0, X1, X2, X3, X4, X5, X6, X7;
reg A, B, C;

wire [3:0]Z1;

Mux8to1 U1 (X0, X1, X2, X3, X4, X5, X6, X7, A, B, C, Z1);

integer i, result;
initial begin
 X0 = 4'b0; X1 = 4'b0; X2 = 4'b0; X3 = 4'b0; X4 = 4'b0; X5 = 4'b0; X6 = 4'b0; X7 = 4'b0; A = 1'b0; B = 1'b0; C = 1'b0;
end

always @(*) begin
	if($time >= tlimit) $stop;
	else begin
	 result = $fopen("result.txt");
	 for(i =0; i<12; i=i+1) begin
		$fdisplay (result, "time = %d, ABC = %d, X0 = %d, X1 = %d, X2 = %d, X3 = %d, X4 = %d, X5 = %d, X6 = %d, X7 = %d, Z1 = %d", $time, {A, B, C}, X0, X1, X2, X3, X4, X5, X6, X7, Z1);
		{A, B, C} = $random;
		X0 = $random; X1 = $random; X2 = $random; X3 = $random; X4 = $random;
		X5 = $random; X6 = $random; X7 = $random;
		#10;
		end
	end
end

endmodule
