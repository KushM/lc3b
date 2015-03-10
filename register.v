module register(q, clk, d, reset, load);
input clk, reset, load; 
input [7:0] d;
output reg [7:0] q;

always @(posedge clk)
	if (reset) q <= 8'd0; 
	else if (load) q <= d;
endmodule
