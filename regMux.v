module regMux(regmux, mdrOut, pcadderOut, aluOut, pcOut, regmuxOut);

input signed [15:0]mdrOut, pcadderOut, aluOut, pcOut;
input [1:0] regmux;
wire signed [15:0]regmuxwire[0:3];
assign regmuxwire[0] = mdrOut;
assign regmuxwire[1] = pcadderOut;
assign regmuxwire[2] = aluOut;
assign regmuxwire[3] = pcOut;

output signed [15:0]regmuxOut;
assign regmuxOut = regmuxwire[regmux];
endmodule
