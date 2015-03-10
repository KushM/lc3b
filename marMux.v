module marMux(pcOut, aluOut, marmux, marmuxOut);
input signed [15:0] pcOut;
input signed [15:0] aluOut;
input marmux;
output signed [15:0]marmuxOut;
assign marmuxOut = marmux?aluOut:pcOut;
endmodule 