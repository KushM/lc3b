module drMux(drmux, irOut, drmuxOut);
input [15:0]irOut;
input drmux;
output [2:0]drmuxOut;
assign drmuxOut = drmux?3'b111:irOut[11:9];
endmodule
