module IF_ID
(
	clk_i,
	hd_i,
	adder_i,
	instr_i,
	flush_i,
	stall_i,
	instr_o,
	addr_o	
);

input			clk_i;
input 			hd_i,flush_i,stall_i;
input [31:0]	adder_i,instr_i;
output	[31:0]	instr_o,addr_o;

reg [31:0]	addr,instr;

assign instr_o=instr;
assign addr_o=addr;

always@(posedge clk_i)begin
	if(hd_i || stall_i)begin
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
