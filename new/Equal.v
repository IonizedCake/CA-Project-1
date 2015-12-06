module Equal
(
	data1_i,
	data2_i,
	data_o
);

input	[31:0] 		data1_i,data2_i;
output				data_o;

reg 		r;

assign data_o=r;

always@(data1_i or data2_i)begin
	if(data1_i==data2_i)begin
		r <= 1;
	end
	else begin
		r <= 0;
	end
end

endmodule
