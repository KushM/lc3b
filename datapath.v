module datapath(clk,clk1,IR,N,P,Z,oddpc);

// Mux1 = to reg file Mux2 = to ALU Mux3 = to Mux2
// Mux4 = MDR Mux5 = 9/11 Mux6 = PC/ALU Mux7 to PC
// Mux8 = Load byte
// lshift2 for 9/11
wire reset, reg_rd,reg_wr,mdr_cont,mdr_rw,write;
input clk;
input clk1;
output [15:0]IR;
wire   [1:0] Mux1,Mux2,Mux3,Mux7;
wire   [1:0]Mux4,Mux5,Mux6;
output N,P,Z,oddpc;
wire ld_mar,ld_mdr,ld_ir,ld_pc;
wire [2:0] ALUop;
wire in_size,in_write;


wire [15:0] out_1,out_2,ALU_out,mar_add,PC_out,ALU_inp2;
wire [15:0] pc_alu_wire,mdr_data,to_mdr,mdr_out;
//reg [15:0] ;
wire [15:0] reg_inp;
wire [2:0] rd_index1, rd_index2, wr_index;
wire [15:0] s1,s2,s3,s4,s5,l1,l2,m1;
wire [15:0] ADD_inp1, ADD_inp2,PC_inp, addout;
wire mar_size,mar_write,mem_size;

controller_lsb ctrl (.ld_ir(ld_ir),.sr1(rd_index1),.sr2(rd_index2),.dr(wr_index),.opcode(IR),.clk(clk),.reg_r(reg_rd),.reg_w(reg_wr),.alusel(Mux2),.opsel(ALUop),.rfsel(Mux1),.sel_pc(Mux7),.ld_pc(ld_pc),.pc_alu(Mux6),.ld_mdr(ld_mdr),.ld_mar(ld_mar),.nine(Mux5),.reset(reset),.mem_r_w(in_write),.mdr_sext(mdr_cont),.mem_size(in_size),.n(N),.p(P),.z(Z),.sel_mem(Mux4));
ALU alu1 (.A(out_1),.B(ALU_inp2),.op(ALUop),.out(ALU_out),.reg_r(reg_rd));
PSW psw1 (.in(ALU_out),.N(N),.Z(Z),.P(P));

MUX pc_alu (.data0(ALU_out),.data1(PC_out),.data2(16'd0),.data3(16'd0),.selectinp(Mux6),.out(pc_alu_wire));
MAR mar1 (.in(pc_alu_wire),.out(mar_add),.LD_MAR(ld_mar),.in_size(in_size), .out_size(mar_size), .in_write(in_write), .out_write(mar_write));

Memory mem (.rst(reset),.address(mar_add),.in(mdr_out),.out(mdr_data),.write(mar_write),.in_size(mar_size),.out_size(mem_size));

MDR mdr1 (.clk(clk),.LD_MDR(ld_mdr),.in(to_mdr),.out(mdr_out),.cont(mdr_cont));

MUX to_regf (.data0(mdr_out),.data1(m1),.data2(PC_out),.data3(ALU_out),.selectinp(Mux1),.out(reg_inp));

REGISTER_FILE reg1 ( .rst(reset), .rd(reg_rd), .wr(reg_wr), .rd_index1(rd_index1), .rd_index2(rd_index2), .wr_index(wr_index),.rdata1(out_1),.rdata2(out_2), .wdata(reg_inp));

IR ir1 (.clk(clk),.in(mdr_out),.out(IR),.LD_IR(ld_ir));

MUX alusel (.data0(out_2),.data1(s1),.data2(s2),.data3(s3),.selectinp(Mux2),.out(ALU_inp2));

SEXT sext1 (.in(IR[5:0]),.out(l1),.cont(5));
SEXT sext2 (.in(IR[4:0]),.out(s2),.cont(4));
SEXT sext3 (.in(IR[3:0]),.out(s3),.cont(3));

LSHIFT lshift1 (.in(l1),.out(s1),.shift(1),.opcode(IR));

SEXT sext4 (.in(IR[8:0]),.out(s4),.cont(8));
SEXT sext5 (.in(IR[10:0]),.out(s5),.cont(10));

MUX mux9_11 (.data0(s5),.data1(s4),.data2(16'd0),.data3(16'd0),.selectinp(Mux5),.out(l2));
LSHIFT lshift2 (.in(l2),.out(ADD_inp1),.shift(1),.opcode(IR));

ADDER add1 (.in1(ADD_inp1),.in2(ADD_inp2),.out(addout));
PC_2_add pc2 (.in(PC_out),.out(ADD_inp2),.odd_PC(oddpc),.reset(reset),.clk(clk));

PC pc0 (.in(PC_inp),.out(PC_out),.LD_PC(ld_pc),.reset(reset));

MUX selpc (.data0(ALU_out),.data1(addout),.data2(ADD_inp2),.data3(16'd0),.selectinp(Mux7),.out(PC_inp));


MUX to_mux2 (.data0(addout),.data1(16'd0),.data2(16'd0),.data3(16'd0),.selectinp(00),.out(m1));
MUX to_mdr1 (.data0(ALU_out),.data1(mdr_data),.data2(out_2),.data3(16'd0),.selectinp(Mux4),.out(to_mdr));


endmodule