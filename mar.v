module mar(din, dout, mare);

input mare;
output reg [15:0]dout;
input [15:0]din;

always @(posedge mare)dout = din;

endmodule
