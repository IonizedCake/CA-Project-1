module HD 
(
	addr1_i,
	addr2_i,
	RTaddr_i,
	MEM_i,
	if_id_o,
	pc_o,
	mux8_o
);

input	[4:0]	addr1_i,addr2_i,RTaddr_i;
input			MEM_i;
output			if_id_o,pc_o,mux8_o;
reg 			r;

assign if_id_o=r;
assign pc_o=r;
assign mux8_o=r;

initial begin
	r=0;
end

always@(addr1_i or addr2_i or RTaddr_i or MEM_i)begin
	if(MEM_i &&((RTaddr_i==addr1_i) || (RTaddr_i==addr2_i)))begin
		r <= 1;
	end
	else begin
		r <= 0;
	end
end

endmodule
