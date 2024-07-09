`timescale 1ns/1ns

module Counter4_Tb;

parameter tlimit = 300;
parameter ckPeriod = 7;

reg Reset = 1'b1, Ck = 1'b0;
reg [1:0] Mode = 2'b00;
reg [3:0] Din = 4'b0000;
wire [3:0] Out;

Counter4 U1 (Reset, Ck, Mode, Din, Out);

initial #tlimit $stop;
initial #10 Reset = 1'b0;
always #ckPeriod Ck = ~Ck;

always @(negedge Ck) begin
	Mode = $random; Din = $random;
end

integer result;
always @(posedge Ck)begin
 if(!Reset) begin
	result = $fopen("result.txt");
	$fwrite (result, "time = %d, Mode = %d, Din = %d, ", $time, Mode, Din);
	#2;
	$fdisplay (result, "Out = %d", Out);
	end
end

endmodule
