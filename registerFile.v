module registerFile(bus, clk, reset, WE, DR, SR1, SR2, RA, RB);

input [15:0]bus;
input clk, reset, WE;
input [2:0]DR;
input [2:0]SR1;
input [2:0]SR2;
output [15:0]RA;
output [15:0]RB;

wire load[0:7];
wire [15:0]q[0:7];

genvar i;
generate
	for (i=0;i<8;i=i+1)begin:LOAD
		assign load[i] = WE&(DR==i);
	end
endgenerate

assign RA = q[SR1];
assign RB = q[SR2];

generate
	for(i =0; i<8; i = i +1)begin:REGisterFile
		register16 regs(q[i], clk, bus, reset, load[i]);
	end
endgenerate

endmodule 