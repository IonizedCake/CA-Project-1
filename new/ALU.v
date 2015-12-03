module ALU
(
	data1_i,
	data2_i,
	ALUCtrl_i,
	data_o,
	Zero_o
);

input [31:0] 	data1_i,data2_i;
input [2:0] 	ALUCtrl_i;
output [31:0] 	data_o;
output 			Zero_o;
reg [31:0] 		r;

assign Zero_o=0;
assign data_o=r;

always@(data1_i or data2_i or ALUCtrl_i)begin
	case(ALUCtrl_i)
		3'b010:r<=data1_i+data2_i;
		3'b110:r<=data1_i-data2_i;
		3'b000:r<=data1_i&data2_i;
		3'b001:r<=data1_i|data2_i;
		3'b011:r<=data1_i*data2_i;//mult
	endcase
end

endmodule
