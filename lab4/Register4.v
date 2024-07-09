`timescale 1ns/1ns

module Register4 (Reset, Ck, R_In, L_In, Mode, Din, Out);
input Reset, Ck, R_In, L_In ;
input [2:0] Mode;
input [3:0] Din;
output [3:0] Out;
wire [3:0] Out;

parameter LOAD = 3'b001, C_UP = 3'b010, C_DOWN = 3'b011, R_SHIFT = 3'b100, L_SHIFT = 3'b101, COMP1 = 3'b110, R_SWAP_L_2BIT = 3'b111 ;

reg [3:0] Register;

always @ (posedge Ck) begin
	if (Reset)
		Register <= 4'b0;
	else
		case (Mode)
		LOAD: Register <= Din;
		C_UP: Register <= Register +1;
		C_DOWN: Register <= Register -1;
		R_SHIFT : Register <= {R_In ,Register[3:1]};
		L_SHIFT : Register <= {Register[2:0], L_In};
		COMP1 : Register <= ~Register;
		R_SWAP_L_2BIT : Register <= {Register[1:0], Register[3:2]};

		default: Register <= Register;
		endcase
end

assign Out = Register;

endmodule
