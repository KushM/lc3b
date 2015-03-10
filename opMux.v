module opMux(opmux, RB, irOut, opmuxOut, lshift);

input lshift;
input [1:0]opmux;
input signed [15:0]RB;
input signed [15:0]irOut;
output signed [15:0]opmuxOut;

wire signed [15:0]opmuxwire[0:3];
assign opmuxwire[0] = RB;
assign opmuxwire[1] = {{12{irOut[3]}},{irOut[3:0]}};
assign opmuxwire[2] = {{11{irOut[4]}},{irOut[4:0]}};
assign opmuxwire[3] = {{10{irOut[5]}},{irOut[5:0]}};

assign opmuxOut = lshift?{{opmuxwire[opmux][14:0]}, {1'b0}}:opmuxwire[opmux];
endmodule
