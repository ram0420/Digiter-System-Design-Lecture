`timescale 1ns/1ns

module D_FF(Reset, Ck, Load, D, Q);
input Reset, Ck, Load, D;
output Q;
reg Q;

always @ (posedge Ck) begin
	if (Reset) Q <= 1'b0; //synchronous reset
	else if (Load) Q <= D;
	else Q <= Q;
end

endmodule

