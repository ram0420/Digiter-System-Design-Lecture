`timescale 1ns/1ns

module MooreStateM(Reset, Ck, X, OC, outState, Z);
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
			if (X) nextState = S1;
			else nextState = S3;
			Z=1'b0;
		end

		S1: begin
			if (X) nextState = S2;
			else nextState = S0;
			Z = 1'b1;
		end

		S2: begin
			if(X) nextState = S2;
			else nextState = S1;
			Z=1'b0;
		end

		S3: begin
			if(X) nextState = S1;
			else nextState = S2;
			Z=1'b1;
		end

		default: begin
			nextState = S0;
			Z=1'b0;
		end
	endcase
	
end

endmodule

