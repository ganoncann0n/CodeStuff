`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:22:24 12/06/2014 
// Design Name: 
// Module Name:    OptimizedTop 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module OptimizedTop(Clk, Rst, v0, v1);
	input Clk, Rst;
	output [31:0] v0, v1;
	

	
	
	//PCSrcMuxWire
	wire [31:0] PCSrcMux;
	//ProgramCounterWire
	wire [31:0] PCResult;
	//PCAdderWire
	wire [31:0] PCPlus4;
	//InstuctionMemoryWire
	wire [31:0] Instruction;
	//IFIDWire
	wire [31:0] IF_ID_Instruction;
	wire [31:0] IF_ID_PCPlus4;
	//ControlWire
	wire  RegDst;
	wire [5:0] ALUOp;
	wire Jump;
	wire Branch;
	wire MemRead;
	wire MemtoReg;
	wire MemWrite;
	wire ALUSrc;
	wire RegWrite;
	wire Jal;
	wire Jr;
	wire BranchOp;
	//RegisterFileWire
	wire [31:0] ReadData1, ReadData2, ReadData3;
	//SignExtensionWire
	wire [31:0] SignExtension;
	//IDEXWire
	wire ID_EX_RegWrite;
	wire ID_EX_MemtoReg;
	wire ID_EX_MemWrite;
	wire ID_EX_MemRead;


	wire [5:0] ID_EX_ALUOp;
	wire  ID_EX_RegDst;
	wire ID_EX_ALUSrc;
	wire [31:0] ID_EX_ReadData1;
	wire [31:0] ID_EX_ReadData2;
	wire [31:0] ID_EX_ReadData3;
	wire [31:0] ID_EX_SignExtension;
	wire [5:0] ID_EX_ALUFunction;
	wire [4:0] ID_EX_ShiftAmount;
	wire [4:0] ID_EX_RegisterRs;
	wire [4:0] ID_EX_RegisterRt;
	wire [4:0] ID_EX_RegisterRd;
	//ShiftMuxMuxWire
	wire [31:0] ShiftMux;
	//HazardDetectionWire
	wire PCWrite_Disable;
	wire IF_ID_Write_Disable;
	wire IF_ID_Flush;
	//ForwardingWire
	wire [1:0] ForwardMuxASel;
	wire [1:0] ForwardMuxBSel;
	//ALUControlWire
	wire [5:0] ALUControlInput;
	wire SelShift;
	//ForwardMuxA and B Wire
	wire [31:0] ForwardMuxAOut, ForwardMuxBOut;
	//RegDstMuxWire
	wire [4:0] RegDstMux;
	//ALUSrcMuxWire
	wire [31:0] ALUSrcMux;
	//ALUWire
	wire [31:0] ALUResult;

	//EXMEMWire	
	wire EX_MEM_RegWrite;
	wire EX_MEM_MemtoReg;
	wire EX_MEM_MemWrite;
	wire EX_MEM_MemRead;
	wire [31:0] EX_MEM_ALUResult;
	wire [31:0] EX_MEM_ForwardMuxB;
	wire [4:0] EX_MEM_RegDst;
	//DataMemoryWire
	wire [31:0] MemoryData;
	//MEMWBWire
	wire [4:0] MEM_WB_RegDst;
	wire MEM_WB_RegWrite;
	wire [31:0] MEM_WB_MemoryToRegisterMux;
	//MemoryToRegisterWire
	wire [31:0] MemoryToRegisterMux;
	//ShiftLeftV2
	wire [31:0] JumpAddress;
	//ShiftLeft2
	wire [31:0] BranchShift;
	//BranchAdd
	wire [31:0] BranchAddress;
	
	//BranchCompWire
	wire BranchResult;
	//AndgateWire
	wire BranchGate;
	//New ForwardingWire
	wire [1:0] IFIDForwardASel, IFIDForwardBSel;
	wire [31:0] IFIDForwardMuxA, IFIDForwardMuxB;
	//QuestionablWires
	wire ID_EX_Branch;
	wire EX_MEM_Branch;
	
	////////
	wire we;
	wire [31:0]  bFetchBTBInstruction, PredictMuxOut;
	wire [1:0] FSMOut;
	wire [1:0] bFetchBP;
	wire [31:0] BIPCFetchOut;
	wire[31:0] BAFetchOut;
	wire [1:0] BPFetchOut;
	wire [31:0] bFetchAddress;
	wire recoverySel;
	wire b;
	wire hitclean;
	wire Super;
	wire ID_EX_Super;
	wire EX_MEM_Super;
	wire MEM_WB_Super;

	wire [31:0] SuperData;
	wire [31:0] SuperMuxOut;
	wire [31:0] update;
	wire [31:0] EX_MEM_Update, MEM_WB_Update;

	
	ShiftLeft2v2 _JumpShift(.in(IF_ID_Instruction[25:0]), .out(JumpAddress));
	ShiftLeft2 _BranchShift(.in(SignExtension), .out(BranchShift));
	ALU_Add _BranchAdd(.A(BranchShift), .B(IF_ID_PCPlus4), .Result(BranchAddress));
	BranchComparater _BranchComparater(.ReadA(IFIDForwardMuxA), .ReadB(IFIDForwardMuxB), .BranchOp(BranchOp), .BranchResult(BranchResult));
	ANDGate _BranchGate(.A(BranchResult), .B(Branch), .Out(BranchGate));
	
	/////////////////////////
	ANDGate _b(.A(BranchGate), .B(!bFetchBP[1]), .Out(b));
	/////////////////////////
	
	
	PCSrcMux _PCSrcMux(.PCAdder(PCPlus4), .JumpAddress(JumpAddress), .BranchAddress(BranchAddress), .JrAddress(IFIDForwardMuxA), 
				.Branch(b), .Jr(Jr), .Jump(Jump), .PCSrc(PCSrcMux));
	ProgramCounter _ProgramCounter(.Address(PredictMuxOut), .PCResult(PCResult), .Reset(Rst), .Clk(Clk), .PCWrite_Disable(PCWrite_Disable));
	PCAdder _PCAdder(.PCResult(PCResult), .PCAddResult(PCPlus4));
	InstructionMemory _InstructionMemory(.Address(PCResult), .Instruction(Instruction)); 
	
	//IFID
	IF_ID _IF_ID(.Rst(Rst), .Clk(Clk), .IF_ID_Flush(IF_ID_Flush), .IF_ID_Write_Disable(IF_ID_Write_Disable), .Instruction(Instruction), 
				.PCPlus4(PCPlus4), .IF_ID_Instruction(IF_ID_Instruction), .IF_ID_PCPlus4(IF_ID_PCPlus4));
				
	Control _Control(.InstructionOp(IF_ID_Instruction[31:26]), .Function(IF_ID_Instruction[5:0]), .RegDst(RegDst), .Jump(Jump), .Branch(Branch), .MemRead(MemRead), .MemtoReg(MemtoReg), 
						.ALUOp(ALUOp), .MemWrite(MemWrite), .ALUSrc(ALUSrc), .RegWrite(RegWrite), .Jal(Jal), .BranchOp(BranchOp), .Jr(Jr), .Super(Super));			
	
	RegisterFile _RegisterFile(.ReadRegister1(IF_ID_Instruction[25:21]), .ReadRegister2(IF_ID_Instruction[20:16]), .ReadRegister3(IF_ID_Instruction[10:6]), .WriteRegister(MEM_WB_RegDst), .WriteData(SuperMuxOut), 
						.RegWrite(MEM_WB_RegWrite), .Clk(Clk), .ReadData1(ReadData1), .ReadData2(ReadData2), .ReadData3(ReadData3), .v0(v0), .v1(v1), .Rst(Rst), .Jal(Jal), .PCPlus4(IF_ID_PCPlus4));
	
	SignExtension _SignExtension(.in(IF_ID_Instruction[15:0]), .out(SignExtension));
	
	//IDEX
	ID_EX _ID_EX(.Rst(Rst), .Clk(Clk), .ID_EX_Flush(ID_EX_Flush), .RegWrite(RegWrite), .MemtoReg(MemtoReg),  .MemWrite(MemWrite), .MemRead(MemRead), 
					.ALUOp(ALUOp), .RegDst(RegDst), .ALUSrc(ALUSrc), 
					.ReadData1(ReadData1), .ReadData2(ReadData2), .ReadData3(ReadData3), .SignExtension(SignExtension), 
					.IF_ID_ShiftAmount(IF_ID_Instruction[10:6]), .IF_ID_ALUFunction(IF_ID_Instruction[5:0]), .IF_ID_RegisterRs(IF_ID_Instruction[25:21]),
					.IF_ID_RegisterRt(IF_ID_Instruction[20:16]), .IF_ID_RegisterRd(IF_ID_Instruction[15:11]), .Branch(Branch), .Super(Super),
					
					.ID_EX_RegWrite(ID_EX_RegWrite), .ID_EX_MemtoReg(ID_EX_MemtoReg), .ID_EX_MemWrite(ID_EX_MemWrite), 
					.ID_EX_MemRead(ID_EX_MemRead), 
					.ID_EX_ALUOp(ID_EX_ALUOp), .ID_EX_RegDst(ID_EX_RegDst), .ID_EX_ALUSrc(ID_EX_ALUSrc),
					.ID_EX_ReadData1(ID_EX_ReadData1), .ID_EX_ReadData2(ID_EX_ReadData2), .ID_EX_ReadData3(ID_EX_ReadData3), .ID_EX_SignExtension(ID_EX_SignExtension),
					.ID_EX_ShiftAmount(ID_EX_ShiftAmount), .ID_EX_ALUFunction(ID_EX_ALUFunction), 
					.ID_EX_RegisterRs(ID_EX_RegisterRs), .ID_EX_RegisterRt(ID_EX_RegisterRt), .ID_EX_RegisterRd(ID_EX_RegisterRd), .ID_EX_Branch(ID_EX_Branch), .ID_EX_Super(ID_EX_Super));
					
	ShiftMux _ShiftMux(.ReadData(ID_EX_ReadData1), .ShiftAmount(ID_EX_ShiftAmount), .SelShift(SelShift), .ShiftMux(ShiftMux));
	Forward_Mux _ForwardMuxA(.Forward_Mux_sel(ForwardMuxASel), .Forward_Mux_A(ShiftMux), .Forward_Mux_B(MEM_WB_MemoryToRegisterMux), 
					.Forward_Mux_C(EX_MEM_ALUResult), .Forward_Mux_F(ForwardMuxAOut));
	Forward_Mux _ForwardMuxB(.Forward_Mux_sel(ForwardMuxBSel), .Forward_Mux_A(ID_EX_ReadData2), .Forward_Mux_B(EX_MEM_ALUResult), 
					.Forward_Mux_C(MEM_WB_MemoryToRegisterMux), .Forward_Mux_F(ForwardMuxBOut));
	Mux32Bit2To1 _ALUSrcMux(.out(ALUSrcMux), .inA(ForwardMuxBOut), .inB(ID_EX_SignExtension), .sel(ID_EX_ALUSrc));
	ALUControl _ALUControl(.ALUOp(ID_EX_ALUOp), .Function(ID_EX_ALUFunction), 
					.ALUControlInput(ALUControlInput), .SelShift(SelShift));
	RegDstMux _RegDstMux(.A(ID_EX_RegisterRt), .B(ID_EX_RegisterRd), .Sel(ID_EX_RegDst), .F(RegDstMux));
	
	ALU32Bit _ALU32Bit(.ALUControl(ALUControlInput), .A(ForwardMuxAOut), .B(ALUSrcMux), .ALUResult(ALUResult));
	
	ParallelAddCompare _ParallelAddCompare(.registerTop(ID_EX_ReadData1), .registerMiddle(ID_EX_ReadData2), .registerBottom(ID_EX_ReadData3), .update(update));
	
	//EXMEM
	EX_MEM _EX_MEM(.Rst(Rst), .Clk(Clk),  .ID_EX_RegWrite(ID_EX_RegWrite), .ID_EX_MemtoReg(ID_EX_MemtoReg),  
					.ID_EX_MemWrite(ID_EX_MemWrite), .ID_EX_MemRead(ID_EX_MemRead), 
					.ALUResult(ALUResult), .ForwardMuxB(ForwardMuxBOut), .RegDst(RegDstMux), .ID_EX_Branch(ID_EX_Branch), .ID_EX_Super(ID_EX_Super), .update(update),
					
					.EX_MEM_RegWrite(EX_MEM_RegWrite), .EX_MEM_MemtoReg(EX_MEM_MemtoReg), 
					.EX_MEM_MemWrite(EX_MEM_MemWrite), .EX_MEM_MemRead(EX_MEM_MemRead), 
					.EX_MEM_ALUResult(EX_MEM_ALUResult), .EX_MEM_ForwardMuxB(EX_MEM_ForwardMuxB), .EX_MEM_RegDst(EX_MEM_RegDst), 
					.EX_MEM_Branch(EX_MEM_Branch), .EX_MEM_Super(EX_MEM_Super), .EX_MEM_Update(EX_MEM_Update));
					
	DataMemory _DataMemory(.Address(EX_MEM_ALUResult), .WriteData(EX_MEM_ForwardMuxB), .Clk(Clk),
						.MemWrite(EX_MEM_MemWrite), .MemRead(EX_MEM_MemRead), .ReadData(MemoryData)); 
	Mux32Bit2To1 _MemoryToRegisterMux(.out(MemoryToRegisterMux), .inA(EX_MEM_ALUResult), 
						.inB(MemoryData), .sel(EX_MEM_MemtoReg));
	
	//MEMWB
	MEM_WB _MEM_WB(.Rst(Rst), .Clk(Clk), .MemoryToRegisterMux(MemoryToRegisterMux), 
					.EX_MEM_RegDst(EX_MEM_RegDst), .EX_MEM_RegWrite(EX_MEM_RegWrite), .EX_MEM_Super(EX_MEM_Super), .EX_MEM_Update(EX_MEM_Update),

					 .MEM_WB_MemoryToRegisterMux(MEM_WB_MemoryToRegisterMux), 
					 .MEM_WB_RegDst(MEM_WB_RegDst), .MEM_WB_RegWrite(MEM_WB_RegWrite), .MEM_WB_Super(MEM_WB_Super), .MEM_WB_Update(MEM_WB_Update));
	
	SuperMux _SuperMux(.RegularData(MEM_WB_MemoryToRegisterMux), .SuperData(MEM_WB_Update), .SuperSel(MEM_WB_Super), .Out(SuperMuxOut));
	
		
	
	////////////////////////
	
	
	
	///////////////////////
	Hazard_Detection_Unit _Hazard_Detection_Unit(.IF_ID_RegisterRs(IF_ID_Instruction[25:21]), .IF_ID_RegisterRt(IF_ID_Instruction[20:16]), 
						.ID_EX_RegisterRt(ID_EX_RegisterRt), .ID_EX_MemRead(ID_EX_MemRead), .BranchGate(BranchGate),
						.PCWrite_Disable(PCWrite_Disable), .IF_ID_Write_Disable(IF_ID_Write_Disable), 
						.IF_ID_Flush(IF_ID_Flush), .ID_EX_Flush(ID_EX_Flush), .Jump(Jump), .branchPredict(bFetchBP), .Branch(Branch), .recoverySel(recoverySel));
						
	Forward_Unit _Forwarding(.ID_EX_RegisterRs(ID_EX_RegisterRs), .ID_EX_RegisterRt(ID_EX_RegisterRt), 
							.EX_MEM_RegDst(EX_MEM_RegDst), .MEM_WB_RegDst(MEM_WB_RegDst), 
							.MEM_WB_RegWrite(MEM_WB_RegWrite), .EX_MEM_RegWrite(EX_MEM_RegWrite),
							.ForwardMuxASel(ForwardMuxASel), .ForwardMuxBSel(ForwardMuxBSel));
							
	IFIDForwardUnit _IFIDForwardUnit(.IF_ID_RegisterRs(IF_ID_Instruction[25:21]), .IF_ID_RegisterRt(IF_ID_Instruction[20:16]), 
							.ID_EX_RegDst(RegDstMux), .EX_MEM_RegDst(EX_MEM_RegDst),
							.Branch(Branch), .Jr(Jr), .IFIDForwardA(IFIDForwardASel), .IFIDForwardB(IFIDForwardBSel), .ID_EX_Branch(ID_EX_Branch), .EX_MEM_Branch(EX_MEM_Branch));
	
	Forward_Mux _IFIDForwardMuxA(.Forward_Mux_sel(IFIDForwardASel), .Forward_Mux_A(ReadData1), .Forward_Mux_B(ALUResult), 
					.Forward_Mux_C(MemoryToRegisterMux), .Forward_Mux_F(IFIDForwardMuxA));
					
	Forward_Mux _IFIDForwardMuxB(.Forward_Mux_sel(IFIDForwardBSel), .Forward_Mux_A(ReadData2), .Forward_Mux_B(ALUResult), 
					.Forward_Mux_C(MemoryToRegisterMux), .Forward_Mux_F(IFIDForwardMuxB));
	
	////////////////////////////////////////

	BTB _BTB(.Clk(Clk), .we(we), .Address1(PCResult), .Address2(bFetchAddress), .BranchAddress(BranchAddress), .FSMResult(FSMOut), 
			.BIPCFetchOut(BIPCFetchOut), .BAFetchOut(BAFetchOut), .BPFetchOut(BPFetchOut));

	
	b2bitfsm _FSM(.Clk(Clk), .Rst(Rst), .Prediction(bFetchBP), .taken(BranchGate), .POut(FSMOut));
	
	minibuffer _minibuffer(.Clk(Clk), .Rst(Rst), .FetchBP(BPFetchOut),  .FetchAddress(PCResult), .FetchBTBInstruction(BIPCFetchOut), 
			.bFetchBP(bFetchBP), .bFetchAddress(bFetchAddress),  .bFetchBTBInstruction(bFetchBTBInstruction));
	 
	GateCombo _Gatecombo(.Branch(Branch), .BTBInstructionFetch(bFetchBTBInstruction), .we(we));
	//PCCompare _PCCompare(.PC(PCResult), .BTBPC(BIPCFetchOut), .equals(equals));					//We don't want to rewrite the Branch after already written in

	Mux32bit3To1 branchPredictorMux(.PredictorA(BAFetchOut), .Default(PCSrcMux), .Recovery(IF_ID_PCPlus4), .hit(hitclean), .r(recoverySel), .PredictMuxOut(PredictMuxOut));	
	
	hitclean _hitclean(.A(BPFetchOut[1]), .B(IF_ID_Flush), .F(hitclean));
endmodule
