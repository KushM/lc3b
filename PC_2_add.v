module PC_2_add(in, out, odd_PC,reset,clk);
input [15:0] in;
input clk;
output reg [15:0] out;
input reset;
output reg odd_PC;
always @(posedge clk)
begin
 out = (reset)?0:(in+16'h0002);
 odd_PC = (in % 2)? 1:0;
end
	
endmodule
