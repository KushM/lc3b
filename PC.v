module PC (in,out,LD_PC,reset);
input LD_PC,reset;
input [15:0] in;
output [15:0] out;
reg [15:0] temp;
initial 
begin
temp=16'd0;
end
always @(posedge LD_PC)
begin
if (reset) temp=16'd0;
if (LD_PC) temp = in;
end 
assign out = temp;

endmodule