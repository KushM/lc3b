module register16(q, clk, d, reset, load);
input clk, reset, load; 
input [15:0] d;
output reg [15:0] q;
initial q = 16'b0;

always @(posedge clk)
	if (reset) q <= 16'd0; 
	else if (load) q <= d;
endmodule
