module FW
(
	ID_EX_RTaddr_i,
	ID_EX_RSaddr_i,
	EX_MEM_RDaddr_i,
	MEM_WB_RDaddr_i,
	EX_MEM_WB_i,
	MEM_WB_WB_i,
	mux6_o,
	mux7_o
);

input	[4:0]	ID_EX_RTaddr_i,ID_EX_RSaddr_i,EX_MEM_RDaddr_i,MEM_WB_RDaddr_i;
input			EX_MEM_WB_i,MEM_WB_WB_i;
output 	[1:0]		mux6_o,mux7_o;
reg 	[1:0] 	mux6,mux7;

assign mux6_o=mux6;
assign mux7_o=mux7;

always@(ID_EX_RTaddr_i or ID_EX_RSaddr_i or EX_MEM_RDaddr_i or MEM_WB_RDaddr_i
		or EX_MEM_WB_i or MEM_WB_WB_i)begin
	if(EX_MEM_WB_i && (EX_MEM_RDaddr_i!=0) && (EX_MEM_RDaddr_i==ID_EX_RSaddr_i))begin
		mux6 <= 2'b10;
	end
	else if(MEM_WB_WB_i && (MEM_WB_RDaddr_i!=0) && (EX_MEM_RDaddr_i!=ID_EX_RSaddr_i) && (MEM_WB_RDaddr_i==ID_EX_RSaddr_i))begin
		mux6 <= 2'b01;
	end
	else begin
		mux6 <= 2'b00;
	end
	if(EX_MEM_WB_i && (EX_MEM_RDaddr_i!=0) && (EX_MEM_RDaddr_i==ID_EX_RTaddr_i))begin
		mux7 <= 2'b10;
	end
	else if(MEM_WB_WB_i && (MEM_WB_RDaddr_i!=0) && (EX_MEM_RDaddr_i!=ID_EX_RTaddr_i) && (MEM_WB_RDaddr_i==ID_EX_RTaddr_i))begin
		mux7 <= 2'b01;
	end
	else begin
		mux7 <= 2'b00;
	end
end

endmodule
