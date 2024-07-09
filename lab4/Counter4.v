`timescale 1ns/1ns

module Counter4 (Reset, Ck, Mode, Din, Out);
input Reset, Ck;
input [1:0] Mode;
input [3:0] Din;
output [3:0] Out;
wire [3:0] Out;

parameter LOAD = 2'b01, C_UP = 2'b10, C_DOWN = 2'b11;

reg [3:0] Register;

always @ (posedge Ck) begin
	if (Reset)
		Register <= 4'b0;
	else
		case (Mode)
		LOAD: Register <= Din;
		C_UP: Register <= Register +1;
		C_DOWN: Register <= Register -1;
		default: Register <= Register;
		endcase
end

assign Out = Register;

endmodule
