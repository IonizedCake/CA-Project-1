module MUX32
(
	flag_i,
	data1_i,
	data2_i,
	data_o
);

input [31:0] data1_i,data2_i;
input flag_i;
output [31:0] data_o;

reg [31:0] r;

assign data_o=r;

always@(data1_i or data2_i or flag_i)begin
	case(flag_i)
		1:r <= data2_i;
		default:r <= data1_i;
	endcase
end

endmodule
