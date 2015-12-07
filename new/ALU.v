module ALU
(
	data1_i,
	data2_i,
	ALUCtrl_i,
	data_o,
	Zero_o
);

input [31:0] 	data1_i,data2_i;
input [3:0] 	ALUCtrl_i;
output [31:0] 	data_o;
output 			Zero_o;
reg [31:0] 		r;

assign Zero_o=0;
assign data_o=r;

always@(data1_i or data2_i or ALUCtrl_i)begin
	case(ALUCtrl_i)
		4'b0010:r=data1_i+data2_i;//add
		4'b0110:r=data1_i-data2_i;//sub
		4'b0000:r=data1_i&data2_i;//and
		4'b0001:r=data1_i|data2_i;//or
		4'b0011:r=data1_i*data2_i;//mult
	endcase
	$display("r=%d,data1=%d,data2=%d",r,data1_i,data2_i);//debug
end

endmodule
