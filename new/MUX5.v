module MUX5
(
	flag_i,
	data1_i,
	data2_i,
	data_o
);

input [4:0] data1_i,data2_i;
input flag_i;
output [4:0] data_o;

reg [4:0] r;

assign data_o=r;

always@(flag_i)begin
	if(flag_i)begin
		r <= data2_i;
	end
	else begin
		r <= data1_i;
	end
end

endmodule
