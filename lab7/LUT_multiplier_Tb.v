`timescale 1ns/1ns

module LUT_multiplier_Tb;

parameter tlimit = 800;
parameter ckPeriod = 7;
parameter M = 5;
parameter N = 5;

reg [N-1:0] LUT [0:2**M-1];
reg Ck = 1'b0;
reg Reset = 1'b1;
reg [M-1:0] addr;
reg rd = 1'b0;
reg wr = 1'b0;
reg [N-1:0] writeData;
wire [N-1:0] readData;

LUT_multiplier #(5,5) U1 (Ck, Reset, rd, wr, addr, writeData, readData);

always #ckPeriod Ck = ~Ck;

initial begin
	#10 Reset = 1'b0;
	#5 wr = 1'b1;
	#500 wr = 1'b0; rd = 1'b1;
end

initial #tlimit $stop;
initial $readmemb ("mem.txt", LUT);

integer k;
initial begin
	for (k=0; k<2**M; k=k+1) begin
		@(negedge Ck);
		addr = k;
		writeData = LUT[addr];
	end
end

integer result;
reg [1:0] mcand;
reg [2:0] mplier;
always @(negedge Ck) begin
	if (rd) begin
		result = $fopen ("result.txt");
		mcand = $random % 4;
		mplier = $random % 8;
		addr = mcand*8 + mplier;
		$fwrite (result, "time = %d, addr = %d, mcand = %d, mplier = %d, ", 
			$time, addr, mcand, mplier);
		#10;
		$fdisplay (result, "data = %d", readData);
	end
end

endmodule 
