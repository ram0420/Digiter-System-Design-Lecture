`timescale 1ns/1ns

module CLA4_Tb;

parameter tlimit = 100;

reg [3:0] A, B;
reg Ci;
wire [3:0] S;

CLA4 U (A, B, Ci, Co, PG, GG, S);

initial begin
   Ci = 0; end

always begin
   if ($time >= tlimit) $stop;
   else begin
      #10; A [3:0] = $random; B [3:0] = $random;
   end
end

integer result;
wire on;

assign on = ($time < tlimit) ? 1:0;

always @(*) begin
   if (on) begin
      result = $fopen ("result9.txt");
      $fdisplay (result, "A = %h, B = %h, Sum = %d%h", A, B, Co, S); end
   else $fclose(result);
end

endmodule
