module Control
(
	Op_i,
    RegDst_o,
    ALUOp_o,
    ALUSrc_o,
    RegWrite_o
);

input [5:0] Op_i;
output RegDst_o,ALUSrc_o,RegWrite_o;
output [1:0] ALUOp_o;
reg [4:0] r;

assign RegDst_o=r[4];
assign ALUSrc_o=r[3];
assign RegWrite_o=r[2];
assign ALUOp_o=r[1:0];

always@(Op_i)begin
	case(Op_i)
		6'b001000:r<=5'b01100;//addi
		default:r<=5'b10110;
	endcase
end

endmodule
