module CPU
(
    clk_i, 
    start_i
);

// Ports
input               clk_i;
input               start_i;

wire 	[31:0] 	inst_addr,inst,mux1,ctrlBit,Add_PC_data;
wire	[31:0]	ID_EX_jumpAddr,EX_MEM_ALUdata,Registers_RSdata,Registers_RTdata;
wire	[31:0]	Mux5_data,Mux7_data,Signed_Extend_data;
wire	[4:0]	ID_EX_RTaddr,EX_MEM_RDaddr,MEM_WB_RDaddr;
wire	 		And_Branch_data,MEM_WB_RegWrite,Control_jump;


Control Control(
    .Op_i       (inst[31:26]),
	.jump_o		(Control_jump),
	.branch_o	(And_Branch.data1_i),
	.data_o		(Mux8.data1_i)
);

Adder Add_PC(
    .data1_i	(inst_addr),
    .data2_i   	(32'd4),
    .data_o     (Add_PC_data)
);

Adder Add(
	.data1_i	(IF_ID.addr_o),
	.data2_i	(Shift2.data_o),
	.data_o		(Mux1.data2_i)
);

Or_gate Or_Flush(
	.data1_i	(Control_jump),
	.data2_i	(And_Branch_data),
	.data_o		(IF_ID.flush_i)
);

And_gate And_Branch(
	.data1_i	(Control.branch_o),
	.data2_i	(Equal.data_o),
	.data_o		(And_Branch_data)
);

Equal Equal(
	.data1_i	(Registers_RSdata),
	.data2_i	(Registers_RTdata),
	.data_o		(And_Branch.data2_i)
);

IF_ID IF_ID(
	.clk_i		(clk_i),
	.hd_i		(HD.if_id_o),
	.adder_i	(Add_PC_data),
	.instr_i	(Instruction_Memory.instr_o),
	.flush_i	(Or_Flush.data_o),
	.instr_o	(inst),
	.addr_o		(Add.data1_i)//ID_EX.nextAddr_i
);

ID_EX ID_EX(
	.clk_i		(clk_i),
	.WB_i		(ctrlBit[7:6]),
	.M_i		(ctrlBit[5:4]),
	.EX_i		(ctrlBit[3:0]),
	.RSaddr_i	(inst[25:21]),
	.RTaddr_i	(inst[20:16]),
	.RDaddr_i	(inst[15:11]),
	.RSdata_i	(Registers_RSdata),
	.RTdata_i	(Registers_RTdata),
	.jumpAddr_i	(Signed_Extend_data),
	//.nextAddr_i	(IF_ID.addr_o),
	.RTaddr_o	(ID_EX_RTaddr),
	.RSaddr_o	(FW.ID_EX_RSaddr_i),
	.RDaddr_o	(Mux9.data2_i),
	.jumpAddr_o	(ID_EX_jumpAddr),
	.RSdata_o	(Mux6.data1_i),
	.RTdata_o	(Mux7.data1_i),
	.WB_o		(EX_MEM.WB_i),
	.M_o		(EX_MEM.M_i),
	.HD_o		(HD.MEM_i),
	.ALUSrc_o	(Mux4.flag_i),
	.ALUOp_o	(ALU_Control.ALUOp_i),
	.RegDst_o	(Mux9.flag_i)
);

EX_MEM EX_MEM(
	.clk_i		(clk_i),
	.WB_i		(ID_EX.WB_o),
	.M_i		(ID_EX.M_o),
	.RDaddr_i	(Mux9.data_o),
	.ALUdata_i	(ALU.data_o),
	.mux7_i		(Mux7_data),
	.WB_o		(MEM_WB.WB_i),
	.FW_o		(FW.EX_MEM_WB_i),
	.MemWrite_o	(Data_Memory.MemWrite_i),
	.MemRead_o	(Data_Memory.MemRead_i),
	.RDaddr_o	(EX_MEM_RDaddr),
	.data_o		(Data_Memory.data_i),
	.ALUdata_o	(EX_MEM_ALUdata)
);

MEM_WB MEM_WB(
	.clk_i		(clk_i),
	.WB_i		(EX_MEM.WB_o),
	.RDaddr_i	(EX_MEM_RDaddr),
	.ALUdata_i	(EX_MEM_ALUdata),
	.DataMem_i	(Data_Memory.data_o),
	.MemToReg_o	(Mux5.flag_i),
	.RegWrite_o	(MEM_WB_RegWrite),
	.RDaddr_o	(MEM_WB_RDaddr),
	.ALUdata_o	(Mux5.data1_i),
	.DataMem_o	(Mux5.data2_i)
);

PC PC(
    .clk_i      (clk_i),
    .start_i    (start_i),
	.hd_i		(HD.pc_o),
    .pc_i       (Mux2.data_o),
    .pc_o       (inst_addr)
);

HD HD(
	.addr1_i	(inst[25:21]),
	.addr2_i	(inst[20:16]),
	.RTaddr_i	(ID_EX_RTaddr),
	.MEM_i		(ID_EX.HD_o),
	.if_id_o	(IF_ID.hd_i),
	.pc_o		(PC.hd_i),
	.mux8_o		(Mux8.flag_i)
);

FW FW(
	.ID_EX_RTaddr_i		(ID_EX_RTaddr),
	.ID_EX_RSaddr_i		(ID_EX.RSaddr_o),
	.EX_MEM_RDaddr_i	(EX_MEM_RDaddr),
	.MEM_WB_RDaddr_i	(MEM_WB_RDaddr),
	.EX_MEM_WB_i		(EX_MEM.FW_o),
	.MEM_WB_WB_i		(MEM_WB_RegWrite),
	.mux6_o				(Mux6.sel_i),
	.mux7_o				(Mux7.sel_i)
);

Instruction_Memory Instruction_Memory(
    .addr_i     (inst_addr), 
    .instr_o    (IF_ID.instr_i)
);

Data_Memory Data_Memory(
	.MemWrite_i	(EX_MEM.MemWrite_o),
	.MemRead_i	(EX_MEM.MemRead_o),
	.data_i		(EX_MEM.data_o),
	.addr_i		(EX_MEM_ALUdata),
	.data_o		(MEM_WB.DataMem_i)
);

Registers Registers(
    .clk_i      (clk_i),
    .RSaddr_i   (inst[25:21]),
    .RTaddr_i   (inst[20:16]),
    .RDaddr_i   (MEM_WB_RDaddr), 
    .RDdata_i   (Mux5_data),
    .RegWrite_i (MEM_WB_RegWrite), 
    .RSdata_o   (Registers_RSdata), 
    .RTdata_o   (Registers_RTdata) 
);

MUX32 Mux1(
	.flag_i		(And_Branch_data),
	.data1_i	(Add_PC_data),
	.data2_i	(Add.data_o),
	.data_o		(mux1)
);

MUX32 Mux2(
	.flag_i		(Control_jump),
	.data1_i	(mux1),
	.data2_i	(Concat1.data_o),
	.data_o		(PC.pc_i)
);

MUX32 Mux4(
	.flag_i		(ID_EX.ALUSrc_o),
    .data1_i    (Mux7_data),
    .data2_i    (ID_EX_jumpAddr),
    .data_o     (ALU.data2_i)
);

MUX32 Mux5(
	.flag_i		(MEM_WB.MemToReg_o),
	.data1_i	(MEM_WB.ALUdata_o),
	.data2_i	(MEM_WB.DataMem_o),
	.data_o		(Mux5_data)
);

MUX32_3 Mux6(
	.sel_i		(FW.mux6_o),
	.data1_i	(ID_EX.RSdata_o),
	.data2_i	(Mux5_data),
	.data3_i	(EX_MEM_ALUdata),
	.data_o		(ALU.data1_i)
);

MUX32_3 Mux7(
	.sel_i		(FW.mux7_o),
	.data1_i	(ID_EX.RTdata_o),
	.data2_i	(Mux5_data),
	.data3_i	(EX_MEM_ALUdata),
	.data_o		(Mux7_data)
);

MUX32 Mux8(
	.flag_i		(HD.mux8_o),
	.data1_i	(Control.data_o),
	.data2_i	(32'b0),
	.data_o		(ctrlBit)
);

MUX5 Mux9(
	.flag_i		(ID_EX.RegDst_o),
	.data1_i	(ID_EX_RTaddr),
	.data2_i	(ID_EX.RDaddr_o),
	.data_o		(EX_MEM.RDaddr_i)
);

Shift2 Shift1(
	.data_i		(inst),
	.data_o		(Concat1.data28_i)
);

Shift2 Shift2(
	.data_i		(Signed_Extend_data),
	.data_o		(Add.data2_i)	
);

Signed_Extend Signed_Extend(
    .data_i     (inst[15:0]),
    .data_o     (Signed_Extend_data)
);

Concatenate_28_4 Concat1(
	.data28_i	(Shift1.data_o),
	.data4_i	(mux1[31:28]),
	.data_o		(Mux2.data2_i)
);

ALU ALU(
    .data1_i    (Mux6.data_o),
    .data2_i    (Mux4.data_o),
    .ALUCtrl_i  (ALU_Control.ALUCtrl_o),
    .data_o     (EX_MEM.ALUdata_i),
    .Zero_o     ()
);

ALU_Control ALU_Control(
    .funct_i    (ID_EX_jumpAddr),
    .ALUOp_i    (ID_EX.ALUOp_o),
    .ALUCtrl_o  (ALU.ALUCtrl_i)
);

endmodule
