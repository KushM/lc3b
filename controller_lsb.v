module controller_lsb(opcode,clk,ld_ir,reg_r,reg_w,alusel,opsel,rfsel,sel_pc,ld_pc,pc_alu,ld_mdr,ld_mar,nine,sel_mem,reset,sr1,sr2,dr,mar_8,mem_r_w,mdr_sext,mem_size,n,p,z);
output reg  ld_ir,reg_r,reg_w,ld_pc,ld_mdr,ld_mar,mar_8,mem_r_w,mem_size,mdr_sext;
output reg reset=1;
output reg [1:0]sel_mem;
output reg [2:0]sr1;
output reg [2:0]sr2;
output reg [2:0]dr;
output reg [1:0]alusel;
output reg [2:0]opsel;
output reg [1:0]rfsel;
output reg [1:0]sel_pc=2'b10;
output reg [1:0]nine;
output reg [1:0]pc_alu;
reg stop;
input n,p,z;
input clk;
input [15:0]opcode;
reg [7:0]state=8'h0;
always @(posedge clk)
begin
if(stop==0)
begin
case(state) 
 8'd0: 
   begin
         ld_mar=0;
			ld_pc=0;
			reg_r=0;
			reg_w=0;  
			pc_alu=1;
			ld_mar=1;
			mem_size=1;
			mem_r_w=1;
			state=state+1;
   end
   8'd1: 
   begin
         ld_mdr=1;
         mdr_sext=0;
			ld_mar=0;
			ld_ir=0;
			ld_pc=1;
			reg_r=0;
			reg_w=0;
			mem_r_w=1;
			reset=0;
			state=state+1;
   end
   8'd2: 
   begin	
			ld_mar=1;
			ld_pc=0;
			reg_r=0;
			reg_w=0;
			mem_r_w=1;
			mar_8=0;
			sel_mem=01;
			mem_r_w=1;
			ld_ir=1;
			state=state+1;
   end
   8'd3: 
      begin		
			ld_mar=0;
			ld_ir=1;
			ld_pc=0;
			reg_r=0;
			reg_w=0;  // default values of the signal
			mem_r_w=1;
			state=state+1;
		end
	8'd4:
	begin // this decodes the instruction
  	      ld_mar=0;
			ld_ir=0;
			ld_pc=0;
			reg_r=0;
			reg_w=0;  
			mem_r_w=1;
	case(opcode[15:12])
			4'd0: state = 8'h10;  // branch 
			4'd1: state = 8'h20;  // add
			4'd2: state = 8'h30;  // ldb 
			4'd3: state = 8'h40;  // stb
			4'd4: state = 8'h50;  // jsr/jsrr
			4'd5: state = 8'h60;  // and
			4'd6: state = 8'h70;  // ldw
			4'd7: state = 8'h80;  // stw 
			4'd9: state = 8'h90;  // xor
			4'd12:state = 8'ha0;  // jmp/ret 
			4'd13:state = 8'hb0;  // shf
			4'd14:state = 8'hc0;  // lea
   endcase
	end

// branch instruction begins here
 8'h10:
    begin
			ld_mdr=0;	
			ld_mar=0;
			ld_ir=0;
			ld_pc=0;
			reg_r=0;
			reg_w=0;
			mem_r_w=1;
			if((n&opcode[11])+(z&opcode[10])+(p&opcode[9]))
			begin  
			nine=01;
			sel_pc=01;
			state=state+1;
			end 
			else 
			state=state+1;
   end
8'h11:
  begin 
      ld_mdr=0;	
			ld_mar=0;
			ld_ir=0;
			reg_r=0;
			reg_w=0;
			mem_r_w=1;
      ld_pc=0;
      state=8'd0;
  end
   
// branch ends here

// add instruction beginss here  
   8'h20: 
        begin
				ld_mdr=0;	
				ld_mar=0;
				ld_ir=0;
				ld_pc=0;
				mem_r_w=1 ; 
				sr1    = opcode[8:6];
				sr2    = opcode[2:0];
				dr     = opcode[11:9];
				reg_r=1; 
				reg_w=0;  
				alusel={opcode[5],1'b0};
				state=state+1;
        end  
   8'h21: 
   begin 
					ld_mdr=0;	
					ld_mar=0;
					ld_ir=0;
					ld_pc=0;
					reg_r=0;
					reg_w=0;
					mem_r_w=1;	
					opsel=001;  
					reg_w=1;
					reg_r=0;
					rfsel=11;
					state=8'd0;
					sel_pc=2'b10;  
   end

// add instruction ends here

  
// ldb instruction begins here
  8'h30: 
      begin    
		      pc_alu=0;
					ld_mdr=0;	
					ld_mar=0;
					ld_ir=0;
					ld_pc=0;
					mem_r_w=1;
					reg_r=1;
					reg_w=0;
					dr=opcode[11:9];
					sr1=opcode[8:6];
					alusel=01;
					state=state+1;
      end
  8'h31:
    begin
					ld_mdr=0;	
					ld_mar=0;
					ld_ir=0;
					ld_pc=0;
					reg_r=0;
					reg_w=0;
					mem_r_w=1;
					opsel=001;
					ld_mar=1;
					mem_size=0;
					state=state+1;
      end
  8'h32:
     begin	
					ld_mar=0;
					ld_ir=0;
					ld_pc=0;
					mem_r_w=1;
					ld_mdr=1;
					mdr_sext=1;
					sel_mem=01;
					rfsel=00;
					reg_w=1;
					reg_r=0;
					state=8'h00;
					sel_pc=2'b10;
      end
 // ldb ends here

  // stb begins here
 8'h40:
     begin     
	        pc_alu=0;
					ld_mdr=0;	
					ld_mar=0;
					ld_ir=0;
					ld_pc=0;
					mem_r_w=1;
					reg_r=1;
					reg_w=0;
					sr2=opcode[11:9];
					sr1=opcode[8:6];
					alusel=01;
					opsel=001;
					state=state+1;
      end
 8'h41:
      begin 
					ld_mdr=0;	
					ld_ir=0;
					ld_pc=0;
					reg_r=0;
					reg_w=0;
					mem_r_w=1;
					pc_alu=0;
					ld_mar=1;
					mem_size=0;
					state=state+1;
    end    
  8'h42:
      begin
               ld_mdr=1;	
					ld_ir=0;
					ld_pc=0;
					reg_r=0;
					reg_w=0;
					mem_r_w=0;
					pc_alu=0;
					mdr_sext=0;
					ld_mar=0;
					sel_pc=2'b10;
               sel_mem=10;
               state=8'd0;
      end  
  // stb ends

// jsr/jsrr begins here 
 8'h50:
   begin   
					ld_mdr=0;	
					ld_mar=0;
					ld_ir=0;
					ld_pc=0;
					mem_r_w=1;
					sr1=opcode[8:6];
					dr=3'd7;
					reg_w=1;
					reg_r=0;
					rfsel=10;
					state=state+1;
   end
  8'h51:
    begin
	               ld_mdr=0;	
						ld_mar=0;
						ld_ir=0;
						ld_pc=0;
						reg_w=0;
						mem_r_w=1;
					 if(opcode[11]==1)
					 begin
					  reg_r=0; 
						nine=00;
						sel_pc=01;
						state=state+2;
					 end
				  else
					 begin 
					    reg_r=1;
					    alusel=01;
					    opsel=001;
					    sel_pc=00;  
						  state=state+1;
             end
     end
   8'h52:  
    begin 
                  alusel=10;
						sel_pc=00;
                  ld_mdr=0;	
						ld_mar=0;
						ld_ir=0;
						ld_pc=1;
						reg_r=0;
						reg_w=1;
						mem_r_w=1;
						state=state+2;
		end
		8'h53:
		  begin
		                  state=state+1;                  ld_mdr=0;	
						ld_mar=0;
						ld_ir=0;
						ld_pc=1;
						reg_r=0;
						reg_w=0;
						mem_r_w=1;
						sel_pc=01;
				end
			8'h54:
			begin
			         ld_mdr=0;	
						ld_mar=0;
						ld_ir=0;
						ld_pc=1;
						reg_r=0;
						reg_w=0;
						mem_r_w=1;
						sel_pc=10;
						state=8'd0;
			end
			
// jsr ends here

// and begins here
 8'h60: 
        begin	  
			ld_mdr=0;	
			ld_mar=0;
			ld_ir=0;
			ld_pc=0;
			mem_r_w=1;
			sr1    = opcode[8:6];
			sr2    = opcode[2:0];
			dr     = opcode[11:9];
			reg_r=1;
		   reg_w=0;    
		   alusel={opcode[5],1'b0};
			state=state+1;
        end  
 8'h61: 
        begin 
	      ld_mdr=0;	
			ld_mar=0;
			ld_ir=0;
			ld_pc=0;
			mem_r_w=1;
         opsel=000;  
         reg_w=1;
			reg_r=0;
         rfsel=11;
         state=8'd0;
         sel_pc=2'b10;  
   end
// and ends here
// ldw begins here
 8'h70: 
      begin
		    pc_alu=0;
		   ld_mdr=0;	
			 ld_mar=0;
			 ld_ir=0;
			 ld_pc=0;
			 mem_r_w=1;
       reg_r=1;
			 reg_w=0;
			 dr=opcode[11:9];
			 sr1=opcode[8:6];
       alusel=01;
       state=state+1;
      end
  8'h71:
    begin
	     ld_mdr=0;	
			ld_ir=0;
			ld_pc=0;
			reg_r=0;
			reg_w=0;
      opsel=001;
      pc_alu=0;
		  ld_mar=1;
		  mem_size=1;
		  mem_r_w=1;
      state=state+1;
      end
  8'h72:
     begin	
			ld_mar=0;
			ld_ir=0;
			ld_pc=0;
			mem_r_w=1;
         ld_mdr=1;
         mdr_sext=0;
         sel_mem=01;
         rfsel=00;
         reg_w=1;
         reg_r=0;
         state=8'h00;
         sel_pc=2'b10;
       end
// ldw ends here
// stw begins here
8'h80:
     begin  
	      pc_alu=0;
	  			ld_mdr=0;	
				ld_mar=0;
				ld_ir=0;
				ld_pc=0;
				mem_r_w=1;
			  reg_r=1;
				reg_w=0;
				sr2=opcode[11:9];
				sr1=opcode[8:6];
			  alusel=01;
			  state=state+1;
      end
 8'h81:
      begin
				 ld_mdr=0;	
			   ld_ir=0;
			   ld_pc=0;
		    	reg_r=0;
		    	reg_w=0;
				 pc_alu=0;
			  	ld_mar=1;
				 mem_size=1;
				 sel_mem=10;
				 mem_r_w=1;
				 state=state+1;
    end    
  8'h82:
       begin
          ld_mdr=1;	
					ld_ir=0;
					ld_pc=0;
					reg_r=0;
					reg_w=0;
					mem_r_w=0;
					pc_alu=0;
					mdr_sext=0;
					ld_mar=0;
          sel_mem=10;
          state=8'd0;
          sel_pc=2'b10;
       end  
// stw ends here
//xor begins here
 8'h90:
        begin
				ld_mdr=0;	
				ld_mar=0;
				ld_ir=0;
				ld_pc=0;
				mem_r_w=1;
				reg_r=1;
				reg_w=0;     
				alusel={opcode[5],1'b0};
				state=state+1;
        end  
8'h91: 
   begin 
	        	ld_mdr=0;	
				ld_mar=0;
				ld_ir=0;
				ld_pc=0;
				reg_r=0;
				reg_w=0;
				mem_r_w=1;
			   opsel=010;  
			   state=state+1;  
   end
8'h92:
       begin
		      ld_mdr=0;	
				ld_mar=0;
				ld_ir=0;
				ld_pc=0;
				mem_r_w=1; 
				reg_w=1;
				reg_r=0;
				rfsel=11;
				state=8'd0;
				sel_pc=2'b10;
       end
// xor ends here
//jmp/ret begins here
8'ha0:
   begin
	      ld_mdr=0;	
				ld_mar=0;
				ld_ir=0;
				ld_pc=0;
				mem_r_w=1;
				reg_r=1;
				reg_w=0;
				sr1=opcode[8:6];
				alusel=10;
				opsel=001;
				sel_pc=00;
				state=state+1;
      end
8'ha1:
        begin
        ld_mdr=0;	
				ld_mar=0;
				ld_ir=0;
				ld_pc=1;
				mem_r_w=1;
				reg_r=1;
				reg_w=0;
				state=8'd0;
        end      		
// jmp/ret ends here
// lea begins here
8'hc0:
       begin
 			ld_mdr=0;	
			ld_mar=0;
			ld_ir=0;
			ld_pc=0;
			reg_r=0;
			reg_w=0;
			mem_r_w=1;
			dr=opcode[11:9];
		   nine=01;
			state=state+1;
       end
8'hc1:
      begin
		  	ld_mdr=0;	
			ld_mar=0;
			ld_ir=0;
			ld_pc=0;
			mem_r_w=1;
		   reg_w=1;
		   reg_r=0;
     	   rfsel=01;
			state=8'h0;
			sel_pc=2'b10;
      end
// lea ends here
//shf begins here
   8'hb0: 
        begin
				ld_mdr=0;	
				ld_mar=0;
				ld_ir=0;
				ld_pc=0;
				mem_r_w=1;
			   sr1    = opcode[8:6];
            dr     = opcode[11:9];
            reg_r=1;
            reg_w=0;   
            alusel=11;
            state=state+1;
        end  
   8'hb1: 
   begin
         ld_mdr=0;	
			ld_mar=0;
			ld_ir=0;
			ld_pc=0;
			mem_r_w=1;	
      case(opcode[5:4])
       2'b00:opsel=011;  
       2'b01:opsel=100;
       2'b10:opsel=101;   
     endcase
      reg_w=1;
      reg_r=0;
      rfsel=11;
      state=8'd0;  
   end
// shf ends here

endcase
end
end
  endmodule