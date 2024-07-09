`timescale 1ns/1ns

module MooreStateM2(Reset, Ck, X, OC, outState, Z);
input Reset, Ck;
input [1:0]X;
input OC; //output buffer control

output Z;
reg Z;
output [2:0] outState;
wire [2:0] outState;

localparam [2:0] S0=3'b000, S1=3'b001, S2=3'b010, S3=3'b011, S4=3'b100, S5=3'b101;

reg [2:0] preState, nextState;

always @ (posedge Ck) begin //sequential
	if(Reset) //Synchronous Reset
		preState <= S0;
	else preState <= nextState;
end

assign outState = (OC) ? preState : 3'bZ;

always @(*) begin //combinational
	nextState=S0;
	Z=1'b0;

	case (preState)
		S0: begin
			if (X==2'b00) nextState = S0;
			else if (X==2'b11) nextState = S0;
			else if (X==2'b01) nextState = S2;
			else nextState = S4;
			Z=1'b0;
		end
	
		S1: begin
			if(X==2'b00) nextState = S1;
			else if (X==2'b11) nextState = S1;
			else if (X==2'b01) nextState = S3;
			else nextState = S5;
			Z=1'b1;
		end
	
		S2: begin
			if (X==2'b01) nextState = S2;
			else if ((X==2'b00)|(X==2'b11)) nextState = S0;
			//else if (X==2'b11) nextState = S0;
			else nextState = S4;
			Z = 1'b0;
		end
		
		S3: begin
			if (X==2'b00) nextState = S1;
			else if (X==2'b01) nextState = S3;
			else if (X==2'b10) nextState = S5;
			else nextState = S0;
			Z=1'b1;
		end
	
		S4: begin
			if (X==2'b00) nextState = S0;
			else if (X==2'b01) nextState = S3;
			else if (X==2'b10) nextState = S4;
			else nextState = S1;
				Z=1'b0;
		end
		S5: begin
			if (X==2'b00) nextState = S1;
			else if (X==2'b11) nextState = S1;
			else if (X==2'b01) nextState = S2;
			else nextState = S5;
			Z=1'b1;
		end
	
		default: begin
			nextState = S0;
			Z=1'b0;
		end
	endcase

end

endmodule

