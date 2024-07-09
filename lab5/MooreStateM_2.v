`timescale 1ns/1ns

module MooreStateM_2(Reset, Ck, X, OC, outState, Z);
input Reset, Ck, X;
input OC; //output buffer control

output Z;
reg Z;
output [1:0] outState;
wire [1:0] outState;

localparam [1:0] S0=2'b00, S1=2'b01, S2=2'b10, S3=2'b11;

reg [1:0] preState, nextState;

always @ (posedge Ck) begin //sequential
	if(Reset) //Synchronous Reset
		preState <= S0;
	else preState <= nextState;
end

assign outState = (OC) ? preState : 2'bZ;

always @(*) begin //combinational
	nextState=S0;
	Z=1'b0;

	case (preState)
		S0: begin
			nextState = (X) ? S1: S3;
			Z = 1'b0; end
		S1: begin
			nextState = (X) ? S2: S0;
			Z = 1'b1; end

		S2: begin
			nextState = (X) ? S2: S1;
			Z = 1'b0; end
		default: begin
			nextState = (X) ? S1: S2;
			Z = 1'b1; end
	endcase
	
end

endmodule

