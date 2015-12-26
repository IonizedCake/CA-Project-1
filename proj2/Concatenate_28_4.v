module Concatenate_28_4
(
	data28_i,
	data4_i,
	data_o
);

input [31:0]	data28_i;
input [3:0]		data4_i;
output [31:0]	data_o;

assign data_o={data4_i,{data28_i[27:0]}};

endmodule
