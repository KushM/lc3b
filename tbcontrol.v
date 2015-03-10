module testbenchcontrol();

wire [15:0]IR;
reg [15:0]IR1;
assign IR = IR1;

reg clock;
wire clk;
assign clk = clock;

reg N1;
wire N;
assign N = N1;
 
reg Z1;
wire Z;
assign Z = Z1;

reg P1;
wire P;
assign P = P1;

reg reset1;
wire reset;
assign reset = reset1;

wire marE, marmux, pcE, adjmux, mdrControl, mdrmux, mdrE, srmux, drmux, regWriteE, memWriteE, nzpE, irE, lshift;
wire [1:0] pcmux, regmux, opmux;
wire [2:0] aluControl;
wire [4:0] state;

controlpath C0(marE, marmux, pcmux, pcE, adjmux, regmux, mdrControl, mdrmux, mdrE, opmux, aluControl,
srmux, drmux, regWriteE, nzpE, irE, lshift, IR, N, Z, P, clk, reset, memWriteE, state);

initial begin
clock = 1;
reset1 = 0;
N1 = 0;
Z1 = 0;
P1 = 1;
		
end

always 
#50 clock = ~clock;

initial begin

#200
IR1 = 16'b0001101000000111;

#600
IR1 = 16'b0001101000110101;

#600
IR1 = 16'b0101101000000111;

#600
IR1 = 16'b0010000110000111;

#700
IR1 = 16'b0011101001000111;

#700
IR1 = 16'b0000101001100110;
N1 = 1;
Z1 = 1;

#500
IR1 = 16'b0000010001100110;
P1 = 0;
end

endmodule

