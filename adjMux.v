module adjMux(irOut, adjmux, adjmuxOut);

input signed [15:0]irOut;
input adjmux;
output signed [15:0]adjmuxOut;

assign adjmuxOut = adjmux?{{4{irOut[10]}}, {irOut[10:0]}, {1'b0}}:{{6{irOut[8]}}, {irOut[8:0]}, {1'b0}};
endmodule
