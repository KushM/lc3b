module REGISTER_FILE (rst, rd, wr, rd_index1, rd_index2, wr_index, rdata1, rdata2, wdata);
input rst;
input rd, wr;
input [2:0] rd_index1, rd_index2, wr_index;
input [15:0] wdata;
output reg [15:0] rdata1, rdata2;
reg [15:0] registers[7:0];

always @(rst or rd or wr or rd_index1 or rd_index2 or wr_index or wdata)
 begin

if (rst) begin
registers[0] = 16'h0000;
registers[1] = 16'h0000;
registers[2] = 16'h0000;
registers[3] = 16'h0000;
registers[4] = 16'h0000;
registers[5] = 16'h0000;
registers[6] = 16'h0000;
registers[7] = 16'h0000;
end
else begin
if (rd) begin
      rdata1 = registers[rd_index1];
      rdata2 = registers[rd_index2];
end
if (wr) begin
      registers[wr_index] = wdata;
end

end

end

endmodule