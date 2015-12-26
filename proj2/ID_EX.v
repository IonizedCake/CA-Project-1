module ID_EX
(
	clk_i,
	WB_i,
	M_i,
	EX_i,
	RSaddr_i,
	RTaddr_i,
	RDaddr_i,
	RSdata_i,
	RTdata_i,
	jumpAddr_i,
	stall_i,
	RTaddr_o,
	RSaddr_o,
	RDaddr_o,
	jumpAddr_o,
	RSdata_o,
	RTdata_o,
	WB_o,
	M_o,
	HD_o,
	ALUSrc_o,
	ALUOp_o,
	RegDst_o
);

input 			clk_i,stall_i;
input	[1:0]	WB_i,M_i;
input	[3:0]	EX_i;
input 	[4:0]	RSaddr_i,RTaddr_i,RDaddr_i;
input	[31:0]	RSdata_i,RTdata_i,jumpAddr_i;
output	[4:0]	RSaddr_o,RTaddr_o,RDaddr_o;
output	[31:0]	RSdata_o,RTdata_o,jumpAddr_o;
output	[1:0]	WB_o,M_o,ALUOp_o;
output			HD_o,ALUSrc_o,RegDst_o;

reg		[1:0]	wb,m;
reg		[3:0]	ex;
reg	 	[4:0]	RSaddr,RTaddr,RDaddr;
reg		[31:0]	RSdata,RTdata,jumpAddr;

assign WB_o=wb;
assign M_o=m;
assign HD_o=m[0];
assign RSaddr_o=RSaddr;
assign RTaddr_o=RTaddr;
assign RDaddr_o=RDaddr;
assign RSdata_o=RSdata;
assign RTdata_o=RTdata;
assign jumpAddr_o=jumpAddr;
assign ALUSrc_o=ex[0];
assign ALUOp_o=ex[2:1];
assign RegDst_o=ex[3];

always@(posedge clk_i)begin
	if(~stall_i)begin
		wb <=WB_i;
		m <= M_i;
		ex <= EX_i;
		RSaddr <= RSaddr_i;
		RTaddr <= RTaddr_i;
		RDaddr <= RDaddr_i;
		RSdata <= RSdata_i;
		RTdata <= RTdata_i;
		jumpAddr <= jumpAddr_i;
	end
end

endmodule
