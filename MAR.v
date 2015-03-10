//MAR
module MAR(in, out, LD_MAR, in_size, out_size, in_write, out_write);
input [15:0] in;
input in_size, in_write;
output [15:0] out;
reg [15:0]temp;
reg temp_size,temp_write;
output out_size, out_write;
input LD_MAR;

always @(LD_MAR or in)
begin
	if (LD_MAR)
		temp <= in;
		temp_size <= in_size;
		temp_write <= in_write;
end

assign out=temp;
assign out_size=temp_size;
assign out_write=temp_write;
endmodule
		
