module lc3b(clock, reset1);

wire marE, marmux, pcE, adjmux, mdrControl, mdrmux, mdrE, srmux, drmux, regWriteE, memWriteE, nzpE, irE, lshift;
wire [1:0] pcmux, regmux, opmux;
wire [2:0] aluControl;
wire [4:0] state;
wire [15:0] opcode;

wire [15:0]IR;
assign IR = opcode;

input clock;
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

input reset1;
wire reset;
assign reset = reset1;

controlpath C(.marE(marE), .marmux(marmux), .pcmux(pcmux), .pcE(pcE), .adjmux(adjmux), .regmux(regmux), .mdrControl(mdrControl), 
.mdrmux(mdrmux), .mdrE(mdrE), .opmux(opmux), .aluControl(aluControl), .srmux(srmux), .drmux(drmux), .regWriteE(regWriteE), 
.nzpE(nzpE), .irE(irE), .lshift(lshift), .IR(IR), .N(N), .Z(Z), .P(P), .clk(clk), .reset(reset), .memWriteE(memWriteE), 
.state(state));

datapath D(.reset(reset), .clk(clk), .marE(marE), .mdrE(mdrE), .nzpE(nzpE), .regWriteE(regWriteE), .pcE(pcE), .irE(irE), 
.memWriteE(memWriteE), .marmux(marmux), .srmux(srmux), .drmux(drmux), .regmux(regmux), .adjmux(adjmux), .pcmux(pcmux), 
.opmux(opmux), .mdrmux(mdrmux), .mdrControl(mdrControl), .lshift(lshift), .aluControl(aluControl), .N(N), .Z(Z), .P(P), 
.opcode(opcode));

endmodule





