module genCC(aluOut, nzp);
input signed [15:0]aluOut;
output [2:0]nzp;

assign nzp[0] = aluOut[15];
assign nzp[1] = ~(|aluOut[15:0]);
assign nzp[2] = ~(aluOut[15] + nzp[1]);

endmodule

