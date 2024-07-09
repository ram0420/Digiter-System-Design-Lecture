`timescale 1ns/1ns

module MealyStateM3_Tb;

parameter tlimit = 400;
parameter ckPeriod = 7;

reg Reset = 1'b1, Ck = 1'b0, OC = 1'b0;
reg [1:0] X = 2'b00;
wire [1:0] outState;
wire [1:0] Z;

MealyStateM3 U(Reset, Ck, X, OC, outState, Z);

initial begin
           #10 Reset = 1'b0; OC = 1'b1; 
end

initial #tlimit $stop;   

always #ckPeriod Ck = ~Ck;
always #10 X = $random;

integer result;
always @(posedge Ck) begin
	   result = $fopen ("result_M3.txt");
          	   $fwrite (result, "time = %d, X = %d,  Z = %d,", $time, X, Z);
	    #2;
           	   $fdisplay (result, "outState = %d", outState);
end

endmodule
