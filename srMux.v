module srMux(srmux, irOut, srmuxOut);
input [15:0]irOut;
input srmux;
output [2:0]srmuxOut;
assign srmuxOut = srmux?irOut[8:6]:irOut[11:9];
endmodule
