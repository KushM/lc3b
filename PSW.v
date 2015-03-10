//Program status Word 
module PSW(in, Z, N, P);
input [15:0] in;
output wire Z,N,P;
assign Z = ((in==16'b0)? 1 : 0);    // Zero flag
assign N = ((in < 16'b0)? 1 : 0);   // NEG flag
assign P = ((in > 16'b0)? 1 : 0);   // Pos Flag
endmodule
		
