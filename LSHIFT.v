module LSHIFT(in, out, shift, opcode);

	output [15:0] out;
	input  [15:0] in;
	input  [3:0] shift;
	input [15:0] opcode;
	
	assign out = (opcode[15:12]==4'b0010)?in:(in<<shift);
	
endmodule
