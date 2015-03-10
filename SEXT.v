module SEXT(in, out, cont);
input [15:0] in;
input [3:0] cont;
output reg [15:0] out;

	always @(in or cont) begin
		case(cont)
			4'd15:  out=in;
			4'd14:  out={in[14],in[14:0]};
			4'd13:  out={{2{in[13]}},in[13:0]};
			4'd12:  out={{3{in[12]}},in[12:0]};
			4'd11:  out={{4{in[11]}},in[11:0]};
			4'd10:  out={{5{in[10]}},in[10:0]};
			4'd9:  out={{6{in[9]}},in[9:0]};
			4'd8:  out={{7{in[8]}},in[8:0]};
			4'd7:  out={{8{in[7]}},in[7:0]};
			4'd6:  out={{9{in[6]}},in[6:0]};
			4'd5:  out={{10{in[5]}},in[5:0]};
			4'd4:  out={{11{in[4]}},in[4:0]};
			4'd3:  out={{12{in[3]}},in[3:0]};
			4'd2:  out={{13{in[2]}},in[2:0]};
			4'd1:  out={{14{in[1]}},in[1:0]};
			4'd0:  out={{15{in[0]}},in[0:0]};

		endcase
	end
	
endmodule