module Memory(address,in,out,write,in_size,out_size,rst);
// size = 1 => 16 bit
// size =0 => 8bit
input rst;
input [15:0] in;
input write;
input [7:0] address;
output [15:0] out;
reg [7:0] mem [0:255];
input in_size;
output out_size;
 
always @(in or write or address or in_size)
begin
if(rst)
begin
{mem[41],mem[40]}=16'd38;
{mem[43],mem[42]}=16'd1000;
 mem[16]=8'd52;
 mem[17]=8'd12;
		
//CODE:
        {mem[1],mem[0]}=16'b0110_000_000_010100;      // Load the MEM[41,40] into RF[0]
        {mem[3],mem[2]}=16'b0110_001_011_010101;      // Load the MEM[43,42] into RF[1]
        {mem[5],mem[4]}=16'b0010_010_011_010000;      // Load the MEM[16] into RF[2]
        {mem[7],mem[6]}=16'b0001_000_000_0_00_001;    // RF[0]=RF[0]+RF[1]
        {mem[9],mem[8]}=16'b0001_001_000_1_01111;     // RF[1]=RF[0]+#15
        {mem[11],mem[10]}=16'b0000_001_000001001;     // Branch to #30 if positive
        {mem[31],mem[30]}=16'b0101_010_010_1_11100;   // RF[2]=RF[2]&11100
        {mem[33],mem[32]}=16'b0010_100_110_010001;    // RF[4]=mem[17]
        {mem[35],mem[34]}=16'b1100_000_100_000000;    // JMP to RF[4]
        {mem[13],mem[12]}=16'b0100_1_00000000101;    //JSR to #26
        {mem[27],mem[26]}=16'b1101_000_000_0_0_0010;  // RF[0]=RF[0]<<2
        {mem[29],mem[28]}=16'b1100_000_111_000000;    // RET
        

		// no op
		{mem[15],mem[14]}=16'b1010_000_000_000000;

end
if(write ==1'b0)
begin
	if (in_size) begin 
	mem[address] <= in[7:0];
	mem[address+1] <= in[15:8];
	end
	else begin
	mem[address] <= in[7:0];
	end
end

end

assign out = (in_size)?{mem[address+1],mem[address]}:{8'd0,mem[address]};

assign out_size = in_size;

endmodule