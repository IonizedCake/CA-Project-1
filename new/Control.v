module Control
(
	Op_i,
	jump_o,
	branch_o,
	data_o
);

input 	[5:0] 	Op_i;
output 			jump_o,branch_o;
output	[31:0]	data_o;
reg 	[31:0] 	r;

/*r[0]=ALUSrc
r[2:1]=ALUOp
r[3]=RegDst
r[4]=MemRead
r[5]=MemWrite
r[6]=RegWrite
r[7]=MemToReg
r[8]=jump_o
r[9]=branch_o*/

assign data_o={{22{1'b0}},r};
assign branch_o=r[9];
assign jump_o=r[8];

initial begin
	r=10'b0;
end

always@(Op_i)begin
	case(Op_i)
		6'b000010:r <= 10'b0100000000;//jump
		6'b000100:r <= 10'b1000000010;//beq
		6'b001000:r <= 10'b0001000001;//addi
		6'b100011:r <= 10'b0011010001;//lw
		6'b101011:r <= 10'b0000100001;//sw
		default:r <= 10'b0001001101;
	endcase
end

endmodule
