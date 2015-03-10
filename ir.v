module ir(din, irOut, irE);
input signed [15:0]din;
output reg signed [15:0]irOut;
input irE;
always @(posedge irE)irOut = din;
endmodule
