module pc(pcin, pcout, pcE);

input signed [15:0]pcin;

output reg signed [15:0]pcout;

initial pcout = 0;
input pcE;
always @(posedge pcE)pcout = pcin;
endmodule
