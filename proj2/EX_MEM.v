module EX_MEM
(
	clk_i,
	WB_i,
	M_i,
	RDaddr_i,
	ALUdata_i,
	mux7_i,
	stall_i,
	WB_o,
	FW_o,
	MemWrite_o,
	MemRead_o,
	RDaddr_o,
	data_o,
	ALUdata_o
);

input			clk_i,stall_i;
input	[1:0]	WB_i,M_i;
input	[4:0]	RDaddr_i;
input	[31:0]	ALUdata_i,mux7_i;
output	[1:0]	WB_o;
output			MemWrite_o,MemRead_o,FW_o;
output	[4:0]	RDaddr_o;
output	[31:0]	data_o,ALUdata_o;

reg		[1:0]	wb,m;
reg		[4:0]	RDaddr;
reg		[31:0]	ALUdata,mux7;

assign WB_o=wb;
assign FW_o=wb[0];
assign MemRead_o=m[0];
assign MemWrite_o=m[1];
assign RDaddr_o=RDaddr;
assign ALUdata_o=ALUdata;
assign data_o=mux7;

initial begin
	wb=2'b0;
	m=2'b0;
end

always@(posedge clk_i)begin
	if(~stall_i)begin
		wb = WB_i;
		m = M_i;
		RDaddr = RDaddr_i;
		ALUdata = ALUdata_i;
		mux7 = mux7_i;
	end
end

endmodule
