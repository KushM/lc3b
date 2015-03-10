module mdrMux(memOut, aluOut, mdrmux, mdrmuxOut);
input signed [15:0] memOut;
input signed [15:0] aluOut;
input mdrmux;
output signed [15:0]mdrmuxOut;
assign mdrmuxOut = mdrmux?memOut:aluOut;
endmodule
