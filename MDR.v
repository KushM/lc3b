//MDR
module MDR(in, out, LD_MDR, cont,clk);
input [15:0] in;
input clk;
output [15:0] out;
reg [15:0] temp;
input LD_MDR;
input cont;

always@(negedge clk)
begin
	if (LD_MDR)
	case (cont)
	0: temp = in; // 8 bit, 16 bit
	1: temp = {{8{in[7]}},in[7:0]}; // 8 bit signed
	endcase
end

assign out = temp;
endmodule
		
