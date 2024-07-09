`timescale 1ns/100ps
module Adder4Tester;
reg [3:0] x = 4'b0;
reg [3:0] y = 4'b0;
reg Cin = 0;

wire [3:0] Sum;
wire Cout;
parameter tlimit = 100;

Adder4 A4 (x, y, Cin, Sum, Cout);

always begin
	if($time >= tlimit) $stop;
	else begin
		x=5;
		repeat(12) #10 y = y+2;
	end
end

integer result;
wire on;

assign on = ($time < tlimit-1)? 1 : 0;

always@ (x, y, Cin)begin
	if (on) begin
		result = $fopen ("result2.txt");
		$fdisplay(result, $time,"%d, %d, %d, %d, %d",x, y, Cin, Sum, Cout);
	end
	else
		$fclose(result);
end

endmodule
