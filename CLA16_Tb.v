`timescale 1ns/1ns
module CLA16_Tb;
parameter tlimit = 100;

reg[15:0]A;
reg[15:0]B;
reg Ci;
wire [15:0]S;

CLA16 U16 (A,B,Ci,S,Co, PG,GG);
initial begin
	Ci=0;
end

always begin
	if($time >=tlimit) $stop;
	else begin
		#10;
		A[15:0]=$random;
		B[15:0]=$random;
	end
end

integer result, result1;
wire on;
assign on = ($time < tlimit)?1:0;
always @(*)begin
	if(on)begin
		result = $fopen("result10.txt");
	result1 = $fopen("result11.txt");
		$fdisplay(result,"A=%h, B=%h, Co=%d, Sum=%h, Sum_ans=%h", A,B,Co,S,A+B);
	$fdisplay(result1,"A=%d, B=%d, Co=%d, Sum=%d, Sum_ans=%d", A,B,Co,S,A+B);
	//If Co occurs, Co equals to 2**16. The sum is equal to the decimal addition -2**16.
	end
	else begin
	$fclose(result);
	$fclose(result1);
	end
end

endmodule
