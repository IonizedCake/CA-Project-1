module MUX32
(
	data1_i,
	data2_i,
	select_i,
	data_o
);

input [31:0] data1_i,data2_i;
input select_i;
output [31:0] data_o;

reg [31:0] r;

assign data_o=r;

always@(data1_i or data2_i or select_i)begin
	case(select_i)
		1:r<=data2_i;
		default:r<=data1_i;
	endcase
end

endmodule
