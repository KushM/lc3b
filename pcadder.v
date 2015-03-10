module pcadder(pcOut, adjmuxOut, pcadderOut);

input signed [15:0]pcOut;
input signed [15:0]adjmuxOut;
output signed [15:0]pcadderOut;
assign pcadderOut = pcOut + adjmuxOut;
endmodule
