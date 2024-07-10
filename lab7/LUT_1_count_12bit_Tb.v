`timescale 1ns/1ns

module LUT_1_count_12bit_Tb;

parameter tlimit = 800;
parameter ckPeriod = 7;
parameter K = 4;
parameter L=3;
parameter M = 12;
parameter N = 4;

reg [L-1:0] LUT [0:2**K-1];
reg Ck = 1'b0;
reg Reset = 1'b1;
reg [K-1:0] addr;
reg rd = 1'b0;
reg wr = 1'b0;
reg [L-1:0] writeData;
reg [M-1:0] inData;
wire [N-1:0] outData;

LUT_1_count_12bit #(4,3,12,4) U1 (Ck, Reset, rd, wr, addr, writeData, inData, outData);

always #ckPeriod Ck = ~Ck;

initial begin
	#10 Reset = 1'b0;
	#5 wr = 1'b1;
	#500 wr = 1'b0; rd = 1'b1;
end

initial #tlimit $stop;
initial $readmemb ("mem_1_count.txt",LUT);

integer k;
initial begin 
	for (k = 0; k<2**K; k=k+1) begin
		@(negedge Ck);
		addr = k;
		writeData = LUT[addr];
	end
end

integer result;
always @(negedge Ck) begin
	if(rd) begin
		result = $fopen("result_b.txt");
		inData = $random;
		$fwrite ( result, "time = %d, inData = %b, ", $time, inData);
		#10
		$fdisplay ( result, " #_of_1s = %d", outData);
	end
end

endmodule 
