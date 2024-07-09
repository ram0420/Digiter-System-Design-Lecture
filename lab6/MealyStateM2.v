`timescale 1ns/1ns

module MealyStateM2 ( Reset, CLK, X, OC, outState, Z);
input Reset, CLK, X, OC;
output wire [1:0] outState;
output wire Z;

localparam [1:0] S0 = 2'b00, S1 = 2'b01, S2 = 2'b10, S3 = 2'b11;

reg [1:0] preState, nextState;

assign outState = (OC)? preState : 2'bz;
assign Z = (((preState == S0)&&(X==1'b1))|((preState == S1)&&(X==1'b0))|((preState == S2)&&(X==1'b1))|((preState == S3)&&(X==1'b1)))? 1'b1 : 1'b0;

always @(posedge CLK) begin
	if(Reset)
		preState <= S0;
	else
		preState <= nextState;
end

always @ (*) begin
	nextState = S0;
	case (preState)
		S0 : if(!X) nextState = S0;
			else nextState = S1;
		S1 : if(!X) nextState = S1;
			else nextState = S2;
		S2 : if(!X) nextState = S2;
			else nextState = S0;
		S3 : if(!X) nextState = S3;
			else nextState = S1;
	endcase
end

endmodule


