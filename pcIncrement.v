module pcIncrement(pcOut, increasedPC);
input signed [15:0]pcOut;
output signed [15:0]increasedPC;
assign increasedPC = pcOut+2;
endmodule
