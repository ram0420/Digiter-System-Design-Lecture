`timescale 1ns/1ns

module MealyStateM1(Reset, Ck, X, OC, outState, Z);
input Reset, Ck;
input [1:0] X;
input OC;

output [1:0] Z;
reg [1:0] Z;
output [1:0] outState;
wire [1:0] outState;

localparam [1:0] S0=2'b00, S1=2'b01, S2=2'b10, S3=2'b11;

reg [1:0] preState, nextState;

always @ (posedge Ck) begin
	if (Reset)
		preState <= S0;
	else preState <= nextState;
end

assign outState = (OC) ? preState: 2'bz;

always @ (*) begin
		Z = 2'b00;
	case (preState)
		S0 : begin 
			if (X == 2'b00) Z = 2'b00;
			else if (X == 2'b01) Z = 2'b10;
			else if (X == 2'b10) Z = 2'b11;
			else Z = 2'b01;
		    end
		S1 : begin
			 if (X == 2'b00) Z = 2'b10;
			else if (X == 2'b01) Z = 2'b10;
			else if (X == 2'b10) Z = 2'b11;
			else Z = 2'b11;
			end
		S2 : begin
			 if (X == 2'b00) Z = 2'b00;
			else if (X == 2'b01) Z = 2'b10;
			else if (X == 2'b10) Z = 2'b11;
			else Z = 2'b01;
		end
		S3 : begin
			if (X == 2'b00) Z = 2'b00;
			else if (X == 2'b01) Z = 2'b00;
			else if (X == 2'b10) Z = 2'b01;
			else Z = 2'b01;
		end
	endcase
end

always @(*) begin
	nextState = S0;
	case (preState)
		S0 : begin
			if(X == 2'b00) nextState = S3;
			else if (X == 2'b01) nextState = S2;
			else if (X == 2'b10) nextState = S1;
			else nextState = S0;
		end
		S1 : begin 
			if(X == 2'b00) nextState = S0;
			else if (X == 2'b01) nextState = S1;
			else if (X == 2'b10) nextState = S2;
			else nextState = S3;
		end
		S2 : begin
			if(X == 2'b00) nextState = S3;
			else if (X == 2'b01) nextState = S0;
			else if (X == 2'b10) nextState = S1;
			else nextState = S1;
		end
		S3 : begin
			if(X == 2'b00) nextState = S2;
			else if (X == 2'b01) nextState = S2;
			else if (X == 2'b10) nextState = S1;
			else nextState = S0;
		end
	endcase
end

endmodule




