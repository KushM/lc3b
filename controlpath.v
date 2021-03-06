module controlpath(marE, marmux, pcmux, pcE, adjmux, regmux, mdrControl, mdrmux, mdrE, opmux, aluControl,
srmux, drmux, regWriteE, nzpE, irE, lshift, IR, N, Z, P, clk, reset, memWriteE, state);

`define if1 5'd0
`define if2 5'd1
`define if3 5'd2
`define decode 5'd3
`define add 5'd4
`define regccw 5'd5
`define and1 5'd6
`define xor1 5'd7
`define branch 5'd8
`define ld0 5'd9
`define ld1 5'd10
`define ld2 5'd11
`define st0 5'd12
`define st1 5'd13
`define st2 5'd14
`define st3 5'd15
`define regw 5'd16
`define jmp 5'd17
`define jsr0 5'd18
`define jsr1 5'd19
`define jsr2 5'd20
`define lea 5'd21
`define shift 5'd22
 
input clk, reset;
input N, Z, P;
input [15:0] IR;
output reg [4:0] state = 5'd0;
wire n ,z, p;
assign n = IR[11];
assign z = IR[10];
assign p = IR[9];
wire clk1;
assign clk1 = clk;

output reg marE, marmux, pcE, adjmux, mdrControl, mdrmux, mdrE, srmux, drmux, regWriteE, memWriteE, nzpE,	irE, lshift;
output reg [1:0] pcmux, regmux, opmux;
output reg [2:0] aluControl;

initial state = 0;

always @(posedge clk)begin
	
	//some default signal values
	mdrControl = 1;
	lshift = 0;
	drmux = 0;
	
	case(state)
	
	`if1:begin
		marmux = 0;
	end
	
	`if2:begin
		pcmux = 2'b00;
		mdrmux = 1;
	end
	
	`if3:begin
	end
	
	`decode:begin
                     //opcode decode
	 end
	 
	`add:begin
		if(IR[5]==0)begin
			regmux = 2'b10;
			opmux = 2'b00;
			aluControl = 3'b000;
			srmux = 1;
		end
		else begin
			regmux = 2'b10;
			opmux = 2'b10;
			aluControl = 3'b000;
			srmux = 1;
		end
	end
	
	`regccw:begin
		drmux = 0;
	end
	
	`and1:begin
		if(IR[5]==0)begin
			regmux = 2'b10;
			opmux = 2'b00;
			aluControl = 3'b001;
			srmux = 1;
		end
		else begin
			regmux = 2'b10;
			opmux = 2'b10;
			aluControl = 3'b001;
			srmux = 1;
		end
	end
	
	`xor1:begin
		if(IR[5]==0)begin
			regmux = 2'b10;
			opmux = 2'b00;
			aluControl = 3'b010;
			srmux = 1;
		end
		else begin
			regmux = 2'b10;
			opmux = 2'b10;
			aluControl = 3'b010;
			srmux = 1;
		end
	end
	
	`branch:begin	
		pcmux = 2'b10;
		adjmux =1;
	end
	
	`ld0:begin
		marmux = 1;
		regmux = 2'b00;
		mdrControl = IR[14];
		opmux = 2'b11;
		lshift = IR[14];
		aluControl = 3'b000;
		srmux = 1;
		mdrmux = 1;
	end
	
	`ld1:begin
		mdrControl = IR[14];
		regmux = 2'b00;
		lshift = IR[14];
		mdrmux = 1;
		drmux = 0;
	end
	
	`st0:begin
		lshift = IR[14];
		marmux = 1;
		opmux = 2'b11;
		aluControl = 3'b000;
		srmux = 1;
		mdrControl = IR[14];
	end
	
	`st1:begin
		mdrmux = 0;
		lshift = IR[14];
		
		aluControl = 3'b110;
		srmux = 0;
		mdrControl = IR[14];
	end
	
	`st2:begin
		lshift = IR[14];
		mdrControl = IR[14];
		//memWriteE = 1;////*******************************************
	end
	
	`jmp:begin
		pcmux = 2'b01;
		aluControl = 3'b110;
		srmux = 1;
	end
	
	`jsr0:begin
		regmux = 2'b11;
		drmux = 1;
	end
	
	`jsr1:begin
		//regWriteE = 1;///////////*****************
		drmux = 1;
	end
	
	`jsr2:begin
		if (IR[11] == 0)begin
			pcmux = 2'b10;
			aluControl = 3'b110;
			srmux = 1;
		end

		else begin
			pcmux = 2'b10;
			adjmux = 0;	
		end
	end

	`lea:begin
		adjmux = 1;
		regmux = 2'b01;
		aluControl = 3'b101;
		srmux = 1;
		drmux = 0;
	end
	
	`shift:begin
		if (IR[5:4] == 2'b00) begin
			opmux = 2'b01;
			aluControl = 3'b011;
			srmux = 1;
			drmux = 1;
			end
		else if (IR[5:4] == 2'b01) begin
			opmux = 2'b01;
			aluControl = 3'b100;
			srmux = 1;
			drmux = 1;
			end
		else if (IR[5:4] == 2'b11) begin
			opmux = 2'b01;
			aluControl = 3'b101;
			srmux = 1;
			drmux = 1;
			end
		end
	endcase
	end
	
	always @(negedge clk1)begin
	
		//default values
	marE = 0;
	pcE = 0;
	mdrE = 0;
	nzpE = 0;
	irE = 0;
	regWriteE = 0;
	memWriteE = 0;
	
	case(state)
	
	default:
	begin
		state = `if1;
	end
	
	`if1:begin
		marE = 1;
		state  = `if2;
	end
	
	`if2:begin
		pcE = 1;
		mdrE = 1;
		state = `if3;
	end
	
	`if3:begin
		irE = 1;
		state = `decode;
	end
	
	`decode:begin
        case(IR[15:12])
		  
        4'b0001:begin
        state <= `add;        //add
        end
        
        4'b0101:
        begin
          state <= `and1;      //and
        end
        
        4'b0000:
        begin
          state <= `branch;      //br
        end
        
        4'b1100:
        begin
          state <= `jmp;      //jmp
        end
        
        4'b0100:
        begin
          state <= `jsr0;      //jsr
        end
        
        4'b0010:
        begin
          state <= `ld0;      //ld
        end
        
        4'b0110:
        begin
          state <= `ld0;     //ldw
        end
        
        4'b1110:
        begin
          state <= `lea;     //lea
        end
        
        4'b1001:
        begin
          state <= `xor1;     //xor
        end

        4'b1101:
        begin
          state <= `shift;     //shf
        end
        
        4'b0011:
        begin
          state <= `st0;     //stb
        end
        
        4'b0111:
        begin
          state <= `st0;     //stw
        end

  		  4'b1111:
		  begin
		    state <= `decode;   //end program
		  end	
   
	 endcase              //opcode decode
	 end
	 
	`add:begin
		state = `regccw;
	end
	
	`regccw:begin
		regWriteE = 1;
		nzpE = 1;
		state = `if1;
	end
	
	`and1:begin
		state = `regccw;
	end
	
	`xor1:begin
		state = `regccw;
	end
	
	`branch:begin	
		pcE = (n&N|z&Z|p&P);
		state = `if1;
	end
	
	`ld0:begin
		marE = 1;
		state = `ld1;
	end
	
	`ld1:begin
		mdrE = 1;
		state = `regccw;
	end
	
	`st0:begin
		marE =1;
		state = `st1;
	end
	
	`st1:begin
		state = `st2;
		marE = 0;
		mdrE = 1;
	end
	
	`st2:begin
		memWriteE = 1;
		state = `if1;
	end

	`jmp:begin
		pcE = 1;
		state = `if1;
	end
	
	`jsr0:begin
		//drmux = 1;//***************************************//
		regWriteE = 1;
		state = `jsr1;
	end
	
	`jsr1:begin
		regWriteE = 1;
		state = `jsr2;
	end
	
	`jsr2:begin
		if (IR[11] == 0)begin
			pcE = 1;
		end
		
		state = `if1;
	end

	`lea:begin
		state = `regccw;
	end
	
	`shift:begin
		state = `regccw;	
	end
	
	endcase
	end
	
	endmodule
