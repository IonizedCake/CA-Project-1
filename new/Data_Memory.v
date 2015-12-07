module Data_Memory
(
	MemWrite_i,
	MemRead_i,
	data_i,
	addr_i,
	data_o
);

input			MemWrite_i,MemRead_i;
input	[31:0]	data_i,addr_i;
output	[31:0]	data_o;

reg		[31:0]	r;
reg		[7:0]	memory	[0:31];

assign data_o=r;

always@(*)begin
	if(MemWrite_i)begin
		memory[addr_i] <= data_i[7:0];
		memory[addr_i+1] <= data_i[15:8];
		memory[addr_i+2] <= data_i[23:16];
		memory[addr_i+3] <= data_i[31:24];
	end
	else if(MemRead_i)begin
		r<={memory[addr_i+3],memory[addr_i+2],memory[addr_i+1],memory[addr_i]};
	end
	else begin
	end
end

endmodule
