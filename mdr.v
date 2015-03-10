module mdr(mdre, mdrControl, din, dout);

input mdre;
input mdrControl;
input signed [15:0]din;
output reg signed [15:0]dout;

always @(posedge mdre)begin
	
	if(mdrControl)begin
		dout=din;
	end
	
	else begin
		dout = {{8{din[7]}}, {din[7:0]}};
	end
end

endmodule
