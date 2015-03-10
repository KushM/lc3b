module MUX(data0, data1, data2, data3, selectinp, out);  // 4x1-16bit mux

	output reg [15:0] out;
	input  [15:0] data0, data1, data2, data3;
	input  [1:0] selectinp;
	
	always @(data0 or data1 or data2 or data3 or selectinp)
	begin
		case(selectinp)
			0: out = data0;
			1: out = data1;
			2: out = data2;
			3: out = data3;
		endcase
	end
	
endmodule
