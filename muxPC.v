module muxPC(increasedPC, aluOut, adderPC, pcmuxOut, pcmux);

input signed [15:0]aluOut;
input signed [15:0]increasedPC;
input signed [15:0]adderPC;
input [1:0]pcmux;

wire signed [15:0]pcmuxwire[0:2];
assign pcmuxwire[0] = increasedPC;
assign pcmuxwire[1] = aluOut;
assign pcmuxwire[2] = adderPC;

output signed [15:0]pcmuxOut;
assign pcmuxOut = pcmuxwire[pcmux];
endmodule

