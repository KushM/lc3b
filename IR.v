//Module to store current instruction
module IR(in, out, LD_IR,clk);
input [15:0] in;
input clk;
output [15:0] out;
reg [15:0] temp_ir;
input LD_IR;

always@(negedge clk)
if (LD_IR) temp_ir = in;

assign out = temp_ir;

endmodule
		