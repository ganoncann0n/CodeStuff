module MipsPipelineTop(Rst, Clk, v0, v1);

	input Rst, Clk;
	output [31:0] v0, v1;
	
	//From Hazard
	wire PCWrite_Disable, IF_ID_Write_Disable;
	wire IF_ID_Flush, ID_EX_Flush, DangerSel;
	//From Forward
	wire [1:0] ForwardMuxASel, ForwardMuxBSel;
	//From Instruction Fetch
	wire [31:0] Instruction, PCPlus4;
	//From IF_ID
	wire [31:0] IF_ID_Instruction, IF_ID_PCPlus4;
	//From InstructionDecode
	wire [31:0] ReadData1, ReadData2, SignExtension, JumpAddress;
	wire [5:0] DangerALUOp;
	wire [2:0] DangerLsel;
	wire [1:0] DangerSsel;
	wire [1:0] DangerRegDst;
	wire DangerRegWrite, DangerMemtoReg, DangerMemRead, DangerMemWrite, DangerBranch, DangerJump, DangerALUSrc, DangerWriteDataSel;
	//wire Jump;
	//From ID_EX
	
	wire ID_EX_RegWrite, ID_EX_MemtoReg;

	wire [2:0] ID_EX_Lsel;
	wire [1:0] ID_EX_Ssel;
	wire ID_EX_MemWrite, ID_EX_MemRead, ID_EX_Branch, ID_EX_Jump;

	wire [5:0] ID_EX_ALUOp;
	wire [1:0] ID_EX_RegDst;
	wire ID_EX_ALUSrc;

	wire [31:0] ID_EX_PCPlus4, ID_EX_ReadData1, ID_EX_ReadData2, ID_EX_SignExtension;
	wire [4:0] ID_EX_ShiftAmount;
	wire [5:0] ID_EX_ALUFunction;
	wire [4:0] ID_EX_RegisterRs, ID_EX_RegisterRt, ID_EX_RegisterRd;
	wire ID_EX_WriteDataSel;
	wire [31:0] ID_EX_JumpAddress;
	//From Execution
	wire [31:0] BranchAddress, ALUResult, ForwardMuxB;
	wire [4:0] RegDst;
	wire Zero, WriteEnable, OverFlow, JrSel;
	//From EX_MEM
	wire EX_MEM_RegWrite, EX_MEM_MemtoReg;
	wire [2:0] EX_MEM_Lsel;
	wire [1:0] EX_MEM_Ssel;
	wire EX_MEM_MemWrite, EX_MEM_MemRead;
	wire [31:0]  EX_MEM_ALUResult, EX_MEM_ForwardMuxB, EX_MEM_PCPlus4;
	wire [4:0] EX_MEM_RegDst;
	wire EX_MEM_WriteEnable, EX_MEM_WriteDataSel;

	//From Memory
	wire [31:0] LoadMux;
	wire  BranchGate;
	//From MEM_WB
	wire [31:0] MEM_WB_LoadMux, MEM_WB_ALUResult;
	wire [4:0] MEM_WB_RegDst;
	wire MEM_WB_RegWrite, MEM_WB_MemtoReg, MEM_WB_WriteEnable;
	wire[31:0] MEM_WB_PCPlus4; //newstuff here
	wire MEM_WB_WriteDataSel;
	//From WriteBack
	wire [31:0] MemtoRegMux;
	wire RFWriteEnable;
	
	ANDGate _BranchGate(ID_EX_Branch, Zero, BranchGate);
	
	InstructionFetch _InstructionFetch(Rst, Clk, BranchGate, JrSel, ID_EX_Jump, PCWrite_Disable, ID_EX_JumpAddress, BranchAddress, ALUResult, 
								Instruction, PCPlus4);
								
	IF_ID _IF_ID(Rst, Clk, IF_ID_Flush, IF_ID_Write_Disable, Instruction, PCPlus4, IF_ID_Instruction, IF_ID_PCPlus4);

	InstructionDecode _InstructionDecode(Clk, Rst, MemtoRegMux, IF_ID_Instruction, RFWriteEnable, DangerSel, MEM_WB_RegDst,
								MEM_WB_WriteDataSel, MEM_WB_PCPlus4,
								
								DangerRegWrite, DangerMemtoReg, DangerLsel, DangerSsel, DangerMemWrite, DangerMemRead,
								DangerBranch, DangerJump, DangerWriteDataSel, DangerALUSrc, DangerALUOp, DangerRegDst,
								ReadData1, ReadData2, SignExtension,  v0, v1);
	
	ShiftLeft2v2 _wow(IF_ID_Instruction[25:0], IF_ID_PCPlus4, JumpAddress);
	
	ID_EX _ID_EX(Rst, Clk, ID_EX_Flush, DangerRegWrite, DangerMemtoReg, DangerLsel, DangerSsel, DangerMemWrite, DangerMemRead, DangerBranch, DangerJump, DangerALUOp, DangerRegDst, DangerALUSrc, IF_ID_PCPlus4, ReadData1, ReadData2, SignExtension,
					IF_ID_Instruction[10:6], IF_ID_Instruction[5:0], IF_ID_Instruction[25:21], IF_ID_Instruction[20:16], IF_ID_Instruction[15:11], DangerWriteDataSel, 
					JumpAddress,
					
					ID_EX_RegWrite, ID_EX_MemtoReg, ID_EX_Lsel, ID_EX_Ssel, ID_EX_MemWrite, ID_EX_MemRead, ID_EX_Branch, ID_EX_Jump,
					ID_EX_ALUOp, ID_EX_RegDst, ID_EX_ALUSrc, ID_EX_PCPlus4, ID_EX_ReadData1, ID_EX_ReadData2, ID_EX_SignExtension,
					ID_EX_ShiftAmount, ID_EX_ALUFunction, ID_EX_RegisterRs, ID_EX_RegisterRt, ID_EX_RegisterRd, ID_EX_WriteDataSel, ID_EX_JumpAddress);
					
					
	Execution _Execution(ID_EX_SignExtension, ID_EX_ReadData1, ID_EX_ReadData2, MemtoRegMux, EX_MEM_ALUResult, ID_EX_PCPlus4,
						ID_EX_ALUOp, ID_EX_ALUFunction, ID_EX_RegisterRt, ID_EX_RegisterRd, ID_EX_ShiftAmount, 
						ForwardMuxASel, ForwardMuxBSel, ID_EX_RegDst,
						ID_EX_ALUSrc,
						
						BranchAddress, ALUResult, RegDst, Zero, WriteEnable, OverFlow, JrSel, ForwardMuxB);

	EX_MEM _EX_MEM(Rst, Clk,  ID_EX_RegWrite, ID_EX_MemtoReg, ID_EX_Lsel, ID_EX_Ssel, ID_EX_MemWrite, ID_EX_MemRead, 
					ID_EX_WriteDataSel, ID_EX_PCPlus4,
				   ALUResult, ForwardMuxB, RegDst, WriteEnable,
					
					EX_MEM_RegWrite, EX_MEM_MemtoReg, EX_MEM_Lsel, EX_MEM_Ssel, EX_MEM_MemWrite, EX_MEM_MemRead, 
					EX_MEM_ALUResult, EX_MEM_ForwardMuxB, EX_MEM_RegDst, EX_MEM_WriteEnable, 
					EX_MEM_WriteDataSel, EX_MEM_PCPlus4);

	Memory _Memory(Clk, EX_MEM_ForwardMuxB, EX_MEM_ALUResult, EX_MEM_Lsel, EX_MEM_Ssel,
					EX_MEM_MemWrite, EX_MEM_MemRead,
					
					LoadMux);

	MEM_WB _MEM_WB(Rst, Clk, LoadMux, EX_MEM_ALUResult, EX_MEM_RegDst, EX_MEM_RegWrite, EX_MEM_MemtoReg, EX_MEM_WriteEnable, EX_MEM_WriteDataSel, EX_MEM_PCPlus4,

					MEM_WB_LoadMux, MEM_WB_ALUResult, MEM_WB_RegDst, MEM_WB_RegWrite, MEM_WB_MemtoReg, MEM_WB_WriteEnable, MEM_WB_WriteDataSel, MEM_WB_PCPlus4);

	WriteBack _WriteBack(MEM_WB_LoadMux, MEM_WB_ALUResult, MEM_WB_MemtoReg, MemtoRegMux);
	
	Forward_Unit _Forward_Unit(ID_EX_RegisterRs, ID_EX_RegisterRt, EX_MEM_RegDst, MEM_WB_RegDst, MEM_WB_RegWrite, EX_MEM_RegWrite,
							ForwardMuxASel, ForwardMuxBSel);
							
							
	Hazard_Detection_Unit _Hazard_Detection_Unit(IF_ID_Instruction[25:21], IF_ID_Instruction[20:16], ID_EX_RegisterRt, ID_EX_MemRead, BranchGate,
						PCWrite_Disable, IF_ID_Write_Disable, IF_ID_Flush, ID_EX_Flush, DangerSel, ID_EX_Jump);
						
	ANDGate _RFWriteEnableGate(MEM_WB_RegWrite, MEM_WB_WriteEnable, RFWriteEnable);
					
endmodule