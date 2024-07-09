`timescale 1ns/1ns

module ShiftRegister (Reset, Ck, Shift, SI, Q);
input Reset, Ck, Shift, SI;
output [3:0] Q;
reg [3:0] Q;

always @ (posedge Ck) begin
	if (Reset) //Synchronous Reset
		Q<=4'b0000;
	else if (Shift) //shift right
		Q <= {SI, Q[3:1]};
	else Q <= Q;
end

endmodule
