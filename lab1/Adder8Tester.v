`timescale 1ns/100ps

module Adder8Tester;
reg[7:0] x = 8'd5;
reg[7:0] y= 8'b0;
reg Cin =0;
wire [7:0] Sum;
wire Cout;
parameter tlimit = 100;

Adder8 A8(x, y, Cin, Sum, Cout);

wire correct;
wire [8:0] Answer = x +y;
assign correct = ( {Cout, Sum} == Answer )? 1:0;
integer result;

always@(*) begin
	if($time>=tlimit)$stop;
	else begin
		result = $fopen("result.txt");
		repeat (20) begin
			#10
			$fdisplay (result, "time = %d, x = %d, y=%d, correct = %d, Answer = %d, Cout_Sum = %d,", $time, x, y, correct, Answer, {Cout, Sum});
			y=y+17;
		end
	end
end

endmodule
