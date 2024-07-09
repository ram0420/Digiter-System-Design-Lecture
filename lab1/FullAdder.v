`timescale 1ns/100ps

module FullAdder (input x,y,Cin, output Cout, Sum);
	assign Sum = x^y^Cin;
 assign Cout = x&y|x&Cin|y&Cin;
endmodule
