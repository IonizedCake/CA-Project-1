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

//assign data_o=r;

assign data_o=data1_i;//debug
/*initial begin
	r=data1_i;
end

always@(flag_i)begin
	if(flag_i==1)begin
		r <= data2_i;
	end
	else begin
		r <= data1_i;
	end
end*/

endmodule
