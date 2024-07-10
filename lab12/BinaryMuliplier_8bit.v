
`timescale 1ns/1ns

module BinaryMultiplier_8bit #(parameter N = 8, M =3)(input clock, Reset, Start, input[N-1:0] mcand, mplier, output wire Done, output wire [2*N:0] m_result);

reg [2*N:0] Acc;
reg [N-1:0]mcand_reg;
reg [M:0]count;
wire [N:0] sum;
wire Ad;

always @(posedge clock)
  if (Reset)count<=N; 
  else if (Start) count <= N;
  else count <= count -1;

always @(posedge clock)
  if (Reset) begin Acc <= 0 ; mcand_reg <=0; end
  else if (Start) begin Acc <= {5'b0, mplier}; mcand_reg <= mcand; end  
  else Acc <= (Ad)?{1'b0, sum, Acc[N-1:1]}: {1'b0,Acc[2*N:1]};

assign sum = (Acc[0])? Acc[2*N-1:N] + mcand_reg : Acc[2*N-1:N];
assign Ad = (Acc[0]);

assign Done = (!count)? 1:0;
assign m_result = Done? Acc:'bz;

endmodule 