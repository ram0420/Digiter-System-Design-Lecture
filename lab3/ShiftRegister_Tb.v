`timescale 1ns/1ns

module ShiftRegister_Tb;

parameter tlimit = 100;
parameter ckPeriod = 7;

reg Reset = 1'b1, Ck = 1'b0, Shift = 1'b0, SI = 1'b0;
wire [3:0] Q;

ShiftRegister U1 (Reset, Ck, Shift, SI, Q); 
//ShiftRegiterSt U1 (Reset, Ck, Shift, SI, Q); //This sentence is for your exercise

initial begin
	#25 Reset = 1'b0;
	#5 Shift = 1'b1; SI = 1'b1; //Shift Right
	#28 SI = 1'b0;
	#14 SI = 1'b1;
	#14 Shift = 1'b0;
end

always #ckPeriod Ck = ~Ck;

integer result;
always @(negedge Ck) begin
	if ($time >= tlimit) $stop;
	else begin
		result = $fopen("result.txt");
		//result = $fopen("result2.txt"); //This sentence is for your exercise
		$fdisplay (result, "time = %d, Shift = %d, SI = %d, Q = %b", $time, Shift, SI, Q);
		end
end
endmodule
