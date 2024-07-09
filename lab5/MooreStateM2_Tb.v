
`timescale 1ns/1ns

module MooreStateM2_Tb;

parameter tlimit = 400;
parameter ckPeriod = 7;

reg Reset = 1'b1, Ck=1'b0, OC=1'b0;
reg [1:0] X=2'b00;
wire[2:0] outState;
wire Z;

MooreStateM2 U (Reset, Ck, X, OC, outState, Z);

initial begin #10 Reset = 1'b0; OC = 1'b1;
	 #tlimit $stop;
end

always #ckPeriod Ck=~Ck;
always @(negedge Ck) begin
	X=$random;
end

integer result2;
always @(outState or Z) begin
	result2 = $fopen("result2.txt");
	$fwrite(result2, "time = %d, OC=%d, X=%d, ", $time, OC, X);
	#2;
	$fdisplay (result2, "outState = %d, Z=%d", outState, Z);
end
endmodule
