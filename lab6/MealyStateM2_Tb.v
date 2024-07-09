`timescale 1ns/1ns

module MealyStateM2_Tb;
reg Reset = 1'b1, CLK=1'b0, X=1'b0, OC=1'b0;
wire [1:0]outState;
wire Z;

parameter tlimit = 400, ckPeriod = 7;

MealyStateM2 MS2(Reset, CLK, X, OC, outState, Z);

initial begin
	#10 Reset = 1'b0; OC=1'b1;
end

initial #tlimit $stop;
always #ckPeriod CLK = ~CLK;

always #10 X = $random;
integer result;
always @ (posedge CLK) begin
	result = $fopen ("result.txt");
	$fwrite (result, "time = %d, X = %d, Z = %d, " , $time, X, Z);
	#2
	$fdisplay (result, "outState = %d", outState);
end

endmodule

