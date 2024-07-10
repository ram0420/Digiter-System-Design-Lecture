`timescale 1ns/1ns

module SerialAdder4Bit_Tb;

parameter tlimit = 1000;
parameter ckPeriod = 7;

reg  Reset = 1'b1, clock = 1'b0, Start = 1'b0;
reg [3:0]x = 'b0, y = 'b0;
wire [4:0] sum;
wire Done;

always #ckPeriod clock = ~clock;
SerialAdder4Bit U1(clock, Reset, Start, x, y, Done, sum);





initial #tlimit $stop;
initial #10 Reset = 1'b0;

reg[2:0] clockCount;
always @ (posedge clock)
	if(Reset)clockCount<=0;
	else if (clockCount == 4) clockCount <=0;
	else clockCount <= clockCount +1;

always @ (negedge clock)
	if(clockCount ==0) Start<=1;
	else Start <= 0;

always @ (negedge clock) begin 
	x = $random; 
	y = $random; end

integer result;
always@(posedge clock) begin 
		result = $fopen("result_4bit.txt");
	if(!Reset&Start) $fwrite (result, "time = %d, x=%d, y=%d", $time, x, y);
	#2;
	if(Done)$fdisplay(result, " time = %d, sum = %d,", $time, sum);
end

endmodule
