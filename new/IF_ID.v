module IF_ID
(
	hd_i,
	adder_i,
	instr_i,
	flush_i,
	instr_o,
	addr_o	
);

input 			hd_i,flush_i;
input [31:0]	adder_i,instr_i;
output	[31:0]	instr_o,addr_o;

reg [31:0]	addr,instr;

assign instr_o=instr;
assign addr_o=addr;

always@(hd_i or adder_i or instr_i or flush_i)begin
	if(hd_i)begin
		instr <= instr;
		addr <= addr;
	end
	else if(flush_i)begin
		instr <= 32'b0;
		addr <= 32'b0;
	end
	else begin
		instr <= instr_i;
		addr <= adder_i;
	end
end

endmodule
