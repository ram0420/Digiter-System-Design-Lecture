`timescale 1ns/100ps
module FullAdderTester;
reg x=0,y=0,Cin=0;
wire Cout, Sum;
parameter tlimit = 500;
FullAdder FA1 (x,y,Cin,Cout,Sum);

	always begin
if ($time>=tlimit) $stop;
else begin
#17 x=~x;
#13 Cin = ~Cin;
#19 y=~y;
end
	end
endmodule

