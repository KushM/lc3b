//if mdrControl is zero, we are playing with 8 bits

module memory(clk, address, dout, din, WE, reset, mdrControl);

input clk;
input reset;
input WE;
input mdrControl;
input signed [15:0]address;
output signed [15:0]dout;
input signed [15:0] din;


wire [7:0]dinEven = din[7:0];
wire [7:0]dinOdd = mdrControl?din[15:8]:din[7:0];
wire [7:0]q[0:511];
wire load[0:511];

genvar i;

generate
	for(i =22; i<256; i = i +1)begin:MEMORY1
		register memEven(q[2*i], clk, dinEven, reset, load[2*i]);
		register memOdd(q[2*i+1], clk, dinOdd, reset, load[2*i+1]);
	end
endgenerate


generate
	for (i=22;i<256;i=i+1)begin:LOAD1
		assign load[2*i] = WE&(address==2*i);
		assign load[2*i+1] = WE&(((~mdrControl)&(address==2*i+1))||((address==2*i)&(mdrControl)));
	end
endgenerate

/*
program memory instructions here:
*/
assign q[40] = 8'b11110000;
assign q[41] = 8'b11110000;
assign q[42] = 8'b00000000;
assign q[43] = 8'b00001111;
assign q[1] = 8'b01100001;
assign q[0] = 8'b10010100;
assign q[3] = 8'b01100011;
assign q[2] = 8'b10010101;
assign q[5] = 8'b00010100;
assign q[4] = 8'b00000001;
//assign q[7] = 8'b01110101;
//assign q[6] = 8'b10010110;
//assign q[9] = 8'b01100001;
//assign q[8] = 8'b10010110;
assign q[7] = 8'b00000010;
assign q[6] = 8'b00000010;
assign q[15] = 8'b00100001;
assign q[14] = 8'b10010111;
assign q[17] = 8'b11000001;
assign q[16] = 8'b10000000;
/*
instructions end here
*/


assign dout[7:0] = q[address];
assign dout[15:8] = q[address+1];

endmodule
