module datapath(reset, clk, marE, mdrE, nzpE, regWriteE, pcE, irE, memWriteE, marmux, srmux, drmux, regmux, adjmux, pcmux, opmux, mdrmux, mdrControl, lshift, aluControl, N, Z, P, opcode);

wire signed [15:0]pcmuxOut;
wire signed [15:0]pcOut;
input pcE;
wire signed [15:0]RA;
wire signed [15:0]RB;
wire signed [15:0]irOut;
input [2:0] aluControl;
wire signed [15:0] aluOut;
wire signed [15:0] marmuxOut;
input marE;
wire signed [15:0]marOut;
input mdrE;
input mdrControl;
wire signed [15:0]mdrmuxOut;
wire signed [15:0]mdrOut; 
input clk;
input reset;
input memWriteE;
wire signed [15:0]memOut;
input irE;
wire signed [15:0]regmuxOut;
input regWriteE;
wire [2:0]drmuxOut;
wire [2:0]srmuxOut;
wire signed [15:0]opmuxOut;
input nzpE;
output N, Z, P;
input srmux;
input mdrmux;
input marmux;
wire signed [15:0] pcadderOut;
input [1:0]pcmux;
input [1:0]opmux;
input lshift;
input drmux;
wire signed [15:0]adjmuxOut;
input [1:0]regmux;
wire [2:0]nzp;
input adjmux;
output [15:0]opcode;
assign opcode = irOut;
wire signed [15:0]increasedPC;

pc pc1(.pcin(pcmuxOut), .pcout(pcOut), .pcE(pcE));
alu alu1(.inputA(RA),.inputB(opmuxOut),.aluControl(aluControl),.aluOut(aluOut));
mar mar1(.din(marmuxOut), .dout(marOut), .mare(marE));
mdr mdr1(.mdre(mdrE), .mdrControl(mdrControl), .din(mdrmuxOut), .dout(mdrOut));
memory memory1(.clk(clk), .address(marOut), .dout(memOut), .din(mdrOut), .WE(memWriteE), .reset(reset), .mdrControl(mdrControl));
registerFile registerFile1(.bus(regmuxOut), .clk(clk), .reset(reset), .WE(regWriteE), .DR(drmuxOut), .SR1(srmuxOut), .SR2(irOut[2:0]), .RA(RA), .RB(RB));
ir ir1(.din(mdrOut), .irOut(irOut), .irE(irE));
cc cc1(.nzp(nzp), .nzpE(nzpE), .N(N), .Z(Z), .P(P));

srMux srMux1(.srmux(srmux), .irOut(irOut), .srmuxOut(srmuxOut));
mdrMux mdrMux1(.memOut(memOut), .aluOut(aluOut), .mdrmux(mdrmux), .mdrmuxOut(mdrmuxOut));
marMux marMux1(.pcOut(pcOut), .aluOut(aluOut), .marmux(marmux), .marmuxOut(marmuxOut));
muxPC muxPC1(.increasedPC(increasedPC), .aluOut(aluOut), .adderPC(pcadderOut), .pcmuxOut(pcmuxOut), .pcmux(pcmux));
opMux opMux1(.opmux(opmux), .RB(RB), .irOut(irOut), .opmuxOut(opmuxOut), .lshift(lshift));
drMux drMux1(.drmux(drmux), .irOut(irOut), .drmuxOut(drmuxOut));
adjMux adjMux1(.irOut(irOut), .adjmux(adjmux), .adjmuxOut(adjmuxOut));
regMux regMux1(.regmux(regmux), .mdrOut(mdrOut), .pcadderOut(pcadderOut), .aluOut(aluOut), .pcOut(pcOut), .regmuxOut(regmuxOut));

pcadder pcadder1(.pcOut(pcOut), .adjmuxOut(adjmuxOut), .pcadderOut(pcadderOut));
pcIncrement pcIncrement1(.pcOut(pcOut), .increasedPC(increasedPC));
genCC genCC1(.aluOut(aluOut), .nzp(nzp));

endmodule
