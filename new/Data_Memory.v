module Data_Memory
(
	clk_i,
	MemWrite_i,
	MemRead_i,
	data_i,
	addr_i,
	data_o
);

input			clk_i;
input			MemWrite_i,MemRead_i;
input	[31:0]	data_i,addr_i;
output	[31:0]	data_o;

reg		[31:0]	r;
reg		[31:0]	memory	[0:31];

assign data_o=r;

always@(posedge clk_i)begin
	if(MemWrite_i)begin
		memory[addr_i] = data_i;
	end
	else if(MemRead_i)begin
		r = memory[addr_i];
	end
	else begin
	end
end

endmodule
