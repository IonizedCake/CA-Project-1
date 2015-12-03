module ALU_Control
(
	funct_i,
	ALUOp_i,
	ALUCtrl_o
);

input [5:0] funct_i;
input [1:0] ALUOp_i;
output [2:0] ALUCtrl_o;
wire [7:0] r;
reg [2:0] out;

assign r={ALUOp_i,funct_i};
assign ALUCtrl_o=out;

always@(ALUOp_i,funct_i)begin
	case(r)
		8'b10100000:out<=3'b010;
		8'b10100010:out<=3'b110;
		8'b10100100:out<=3'b000;
		8'b10100101:out<=3'b001;
		8'b10011000:out<=3'b011;//mult
		8'b00100000:out<=3'b010;//addi
		default:out<=3'b010;
	endcase
end

endmodule
