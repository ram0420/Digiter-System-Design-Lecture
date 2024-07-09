`timescale 1ns/1ns

module MooreStateM_2_Tb;

parameter tlimit = 400;
parameter ckPeriod = 7;

reg Reset = 1'b1, Ck=1'b0, X=1'b0, OC=1'b0;
wire[1:0] outState;
wire Z;

MooreStateM_2 U (Reset, Ck, X, OC, outState, Z);

initial begin #10 Reset = 1'b0; OC = 1'b1;
	 #tlimit $stop;
end

always #ckPeriod Ck=~Ck;
always @(negedge Ck) begin
	X=$random;
end

integer result;
always @(outState or Z) begin
	result = $fopen("MooreStateM_2_Tb.txt");
	$fwrite(result, "time = %d, OC=%d, X=%d, ", $time, OC, X);
	#2;
	$fdisplay (result, "outState = %d, Z=%d", outState, Z);
end
endmodule

