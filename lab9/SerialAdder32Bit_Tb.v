`timescale 1ns/1ns

module SerialAdder32Bit_Tb;

parameter tlimit = 1000;
parameter ckPeriod = 7;
parameter M=32;
parameter N=5;

reg  Reset = 1'b1, clock = 1'b0, Start = 1'b0;
reg [M-1:0]x = 'b0, y = 'b0;
wire [M:0] sum;
wire Done;

always #ckPeriod clock = ~clock;
SerialAdder32Bit #(32, 6) U1(clock, Reset, Start, x, y, Done, sum);

initial #tlimit $stop;
initial #10 Reset = 1'b0;

reg[N-1:0] clockCount;
always @ (posedge clock)
	if(Reset)clockCount<=0;
	else if (clockCount == 32) clockCount <=0;
	else clockCount <= clockCount +1;

always @ (negedge clock)
	if(clockCount ==0) Start<=1;
	else Start <= 0;

always @ (negedge clock) begin 
	x = $random; 
	y = $random; end

integer result;
always@(posedge clock) begin 
		result = $fopen("result_32bit.txt");
	if(!Reset&Start) $fwrite (result, "time = %d, x=%d, y=%d", $time, x, y);
	#2;
	if(Done)$fdisplay(result, " time = %d, sum = %d,", $time, sum);
end

endmodule
