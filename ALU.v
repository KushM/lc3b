// Verilog implementation of the ALU 
// this code implements ADD,SUB,XOR, and compare
// it generates the output signal based on 2 inputs and the control input

module ALU (A, B, op, out,reg_r);
input reg_r;
input [15:0] A, B;
input [2:0] op;
output reg [15:0] out;

always@(op or A or B ) 
begin
case(op)
3'b000: out = A&B; // add operation
3'b001: out = A+B; // and operation
3'b010: out = A^B; // bitwise xor operation
// while using the ALU in following modes, B[3:0] is set as amount to be shifted
3'b011: out = A<<B[3:0]; //left shift
3'b100: out = A>>B[3:0]; //right shift logical
3'b101: begin // right shift arithmetic
		case(B[3:0])
			4'd0:  out=A;
			4'd1:  out={A[15],A[15:1]};
			4'd2:  out={{2{A[15]}},A[15:2]};
			4'd3:  out={{3{A[15]}},A[15:3]};
			4'd4:  out={{4{A[15]}},A[15:4]};
			4'd5:  out={{5{A[15]}},A[15:5]};
			4'd6:  out={{6{A[15]}},A[15:6]};
			4'd7:  out={{7{A[15]}},A[15:7]};
			4'd8:  out={{8{A[15]}},A[15:8]};
			4'd9:  out={{9{A[15]}},A[15:9]};
			4'd10: out={{10{A[15]}},A[15:10]};
			4'd11: out={{11{A[15]}},A[15:11]};
			4'd12: out={{12{A[15]}},A[15:12]};
			4'd13: out={{13{A[15]}},A[15:13]};
			4'd14: out={{14{A[15]}},A[15:14]};
			4'd15: out={16{A[15]}};
		endcase
		end
endcase
end

endmodule