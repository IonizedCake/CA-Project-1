module Control
(
    Op_i,
    RegDst_o,
    Jump_o,
    Branch_o,
    MemRead_o,
    MemtoReg_o,
    ALUOp_o,
    MemWrite_o,
    ALUSrc_o,
    RegWrite_o,
);

input  [5:0] Op_i;
output       RegDst_o;
output       Jump_o;
output       Branch_o;
output       MemRead_o;
output       MemtoReg_o;
output [1:0] ALUOp_o;
output       MemWrite_o;
output       ALUSrc_o;
output       RegWrite_o;
reg    [9:0] out;

assign RegDst_o = out[9];
assign Jump_o = out[8];
assign Branch_o = out[7];
assign MemRead_o = out[6];
assign MemtoReg_o = out[5];
assign ALUOp_o = out[4:3];
assign MemWrite_o = out[2];
assign ALUSrc_o = out[1];
assign RegWrite_o = out[0];

// assume "don't care" is 0
always@(Op_i) begin
    case(Op_i)
        6'b000000: // R-type: and, or, add, sub, mul
            out <= 10'b1000010001;
        6'b001000: // addi
            out <= 10'b0000000011;
        6'b100011: //lw
            out <= 10'b0001100011;
        6'b101011: //sw
            out <= 10'b0000000110;
        6'b000100: //beq
            out <= 10'b0010001000;
        6'b000010: //jump
            out <= 10'b0100000000;
    endcase
end

endmodule
