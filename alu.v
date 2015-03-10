module alu(inputA,inputB,aluControl,aluOut);

parameter op_add = 3'd0;
parameter op_and = 3'd1;
parameter op_xor = 3'd2;
parameter op_lsh = 3'd3;
parameter op_rs0 = 3'd4;
parameter op_rss = 3'd5;
parameter op_nopA = 3'd6;
parameter op_nopB = 3'd7;

input [2:0]aluControl;
output signed [15:0]aluOut;

input signed [15:0]inputB;
input signed [15:0]inputA;

wire signed [15:0]ops[0:7];
assign ops[op_add] = inputA+inputB;
assign ops[op_and] = inputA&inputB;
assign ops[op_xor] = inputA^inputB;
assign ops[op_lsh] = inputA<<inputB;
assign ops[op_rs0] = inputA>>inputB;
assign ops[op_rss] = inputA>>>inputB;
assign ops[op_nopA] = inputA;
assign ops[op_nopB] = inputA;

assign aluOut = ops[aluControl];

endmodule
