module ALU_Control
(
	funct_i,
	ALUOp_i,
	ALUCtrl_o
);

input [31:0] funct_i;
input [1:0] ALUOp_i;
output [3:0] ALUCtrl_o;
wire [7:0] r;
reg [3:0] out;

assign r=funct_i[5:0];
assign ALUCtrl_o=out;

always@(ALUOp_i,funct_i)begin
	case(ALUOp_i)
		2'b10:
			case(r)
				6'b100000:out <= 4'b0010;//add
				6'b100010:out <= 4'b0110;//sub
				6'b100100:out <= 4'b0000;//and
				6'b100101:out <= 4'b0001;//or
				6'b011000:out <= 4'b0011;//mult
				default:out <= 4'b0010;
			endcase
		2'b00:
			out <= 4'b0010;//addi,lw,sw
		2'b01:
			out <= 4'b0110;//beq
		default:out <= 4'b0010;
	endcase
end

endmodule
