module SerialAdder4Bit #(parameter M=8, N=4)(input clock, Reset, Start, input[M:0] x, y, output wire Done, output wire [4:0] sum);
// 8bit -> 9 -> need 4bit

reg[M:0] Acc, y_reg;
reg[2:0] count;
reg Q;
wire D, s;
wire xi, yi, ci;

always@(posedge clock)
	if (Reset) Q <= 0;
	else if(Start) Q <= 0;
	else Q <= D;

always@(posedge clock)
	if (Reset) count <= 4;
	else if(Start) count <= 4;
	else count <=count -1;

always@(posedge clock)
	if(Reset)begin Acc <=0; y_reg<=0; end
	else if (Start) begin Acc < x; y_reg <= y; end
	else begin Acc <= {s,Acc[3:1]}; y_reg <= y_reg>>1 ; end

assign s = xi^yi^ci;
assign D = xi&yi | ci&yi | ci&xi;

assign xi = Acc[0];
assign yi = y_reg[0];
assign ci = Q;

assign Done = (!count)? 1:0;
assign sum = Done? {ci,Acc}:'bz;

endmodule
