module MEM_WB
(
	clk_i,
	WB_i,
	RDaddr_i,
	ALUdata_i,
	DataMem_i,
	stall_i,
	MemToReg_o,
	RegWrite_o,
	RDaddr_o,
	ALUdata_o,
	DataMem_o
);

input			clk_i,stall_i;
input	[1:0]	WB_i;
input	[4:0]	RDaddr_i;
input	[31:0]	ALUdata_i,DataMem_i;
output			MemToReg_o,RegWrite_o;
output	[4:0]	RDaddr_o;
output	[31:0]	ALUdata_o,DataMem_o;

reg		[1:0]	wb;
reg		[4:0]	RDaddr;
reg		[31:0]	ALUdata,DataMem;

assign	RegWrite_o=wb[0];
assign	MemToReg_o=wb[1];
assign	RDaddr_o=RDaddr;
assign	ALUdata_o=ALUdata;
assign	DataMem_o=DataMem;

initial begin
	wb=2'b0;
	RDaddr=5'b0;
	ALUdata=32'b0;
	DataMem=32'b0;
end

always@(posedge clk_i)begin
	if(~stall_i)begin
		wb <= WB_i;
		RDaddr <= RDaddr_i;
		ALUdata <= ALUdata_i;
		DataMem <= DataMem_i;
	end
end

endmodule
