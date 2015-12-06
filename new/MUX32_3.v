module MUX32_3
(
	sel_i,
	data1_i,
	data2_i,
	data3_i,
	data_o
);

input 	[1:0]		sel_i;
input 	[31:0]		data1_i,data2_i,data3_i;
output 	[31:0]		data_o;
reg 	[31:0]		data;

assign data_o=data;

always@(sel_i)begin
	case(sel_i)
		2'b00:data <= data1_i;
		2'b01:data <= data2_i;
		2'b10:data <= data3_i;
		default:data <= data1_i;
	endcase
end

endmodule
