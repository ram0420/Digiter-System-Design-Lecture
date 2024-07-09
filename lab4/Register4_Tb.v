`timescale 1ns/1ns

module Register4_Tb;

parameter tlimit = 300;
parameter ckPeriod = 7;

reg Reset = 1'b1, Ck = 1'b0;
reg R_In = 1'b1, L_In = 1'b1;
reg [2:0] Mode = 3'b000;
reg [3:0] Din = 4'b0000;
wire [3:0] Out;

Register4 U1 (Reset, Ck, R_In, L_In, Mode, Din, Out);

initial #tlimit $stop;
initial #10 Reset = 1'b0;
always #ckPeriod Ck = ~Ck;

always @(negedge Ck) begin
	Mode = $random; Din = $random; R_In = $random; L_In = $random;
end

integer result;
always @(posedge Ck)begin
 if(!Reset) begin
	result = $fopen("result2.txt");
	$fwrite (result, "time = %d, Mode = %d, Din = %d, R_In = %d, L_In = %d, ", $time, Mode, Din, R_In, L_In);
	#2;
	$fdisplay (result, "Out = %d", Out);
	end
end

endmodule
