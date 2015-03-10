module cc(nzp, nzpE, N, Z, P);
input [2:0]nzp;
input nzpE;
output reg N, Z, P;
always @(posedge nzpE)begin
	N = nzp[2];
	Z = nzp[1];
	P = nzp[0];
end

endmodule
