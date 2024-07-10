`timescale 1ns/1ns

module BinaryMultiplier(input clock, Reset, Start, input[3:0] mcand, mplier, output wire Done, output wire [8:0] m_result);

reg [8:0] Acc;
reg [3:0]mcand_reg;
reg [2:0]count;
wire [4:0] sum;
wire Ad;

always @(posedge clock)
  if (Reset)count<=4; //4,3,2,1,0  so 3bit
  else if (Start) count <= 4;
  else count <= count -1;

always @(posedge clock)
  if (Reset) begin Acc <= 0 ; mcand_reg <=0; end
  else if (Start) begin Acc <= {5'b0, mplier}; mcand_reg <= mcand; end
  else Acc <= (Ad)?{1'b0, sum, Acc[3:1]}: {1'b0,Acc[8:1]};

assign sum = (Acc[0])? Acc[7:4] + mcand_reg : Acc[7:4];
assign Ad = (Acc[0]);

assign Done = (!count)? 1:0;
assign m_result = Done? Acc:'bz;

endmodule 
