module PC
(
    clk_i,
    start_i,
	hd_i,
    pc_i,
    pc_o
);

// Ports
input               clk_i;
input               start_i;
input 				hd_i;
input   [31:0]      pc_i;
output  [31:0]      pc_o;

// Wires & Registers
reg     [31:0]      pc_o;

initial begin
	pc_o = 32'b0;
end

always@(posedge clk_i or hd_i) begin
	if(hd_i) begin
		pc_o <= pc_o;
	end
    else begin
        if(start_i)
            pc_o <= pc_i;
        else
            pc_o <= pc_o;
    end
end

endmodule
