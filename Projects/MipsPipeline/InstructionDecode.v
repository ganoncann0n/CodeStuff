`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:44:40 11/22/2014 
// Design Name: 
// Module Name:    InstructionDecode 
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
module InstructionDecode(Clk, Rst, MemtoRegMuxIn, IF_ID_InstructionIn, RFWriteEnableIn, DangerSelIn, MEM_WB_RegDstIn,
								MEM_WB_WriteDataSelIn, MEM_WB_PCPlus4In,
								
								DangerRegWriteOut, DangerMemtoRegOut, DangerLselOut, DangerSselOut, DangerMemWriteOut, DangerMemReadOut,
								DangerBranchOut, DangerJumpOut, DangerWriteDataSelOut, DangerALUSrcOut, DangerALUOpOut, DangerRegDstOut,
								ReadData1Out, ReadData2Out, SignExtensionOut, v0, v1);
	input Clk, Rst;
	input [31:0] MemtoRegMuxIn;
	input [31:0] IF_ID_InstructionIn;
	//ControlInput
	input RFWriteEnableIn, DangerSelIn;
	input [4:0] MEM_WB_RegDstIn;
	//ControlOutput
		//WB
		wire RegWriteWire;
		wire MemtoRegWire;
		wire WriteDataSelWire;
		output DangerRegWriteOut;
		output DangerMemtoRegOut;
		output DangerWriteDataSelOut;
		//Mem
		wire [2:0] LselWire;
		wire [1:0] SselWire;
		wire MemWriteWire, MemReadWire, BranchWire; //JumpWire;
		output [2:0] DangerLselOut;
		output [1:0] DangerSselOut;
		output DangerMemWriteOut, DangerMemReadOut, DangerBranchOut, DangerJumpOut;
		//Ex
		wire ALUSrcWire;
		wire [5:0] ALUOpWire;
		wire [1:0] RegDstWire;
		output DangerALUSrcOut;
		output [5:0] DangerALUOpOut;
		output [1:0] DangerRegDstOut;
	output [31:0] ReadData1Out, ReadData2Out, SignExtensionOut;
	output [31:0] v0, v1;
	
	
	//From MEM_WB
	input [31:0] MEM_WB_PCPlus4In;
	input MEM_WB_WriteDataSelIn;
	
	
	
	
	//RegularWires
	wire JumpWire;
	wire [31:0] JalDataMWire;
	wire [27:0] JumpShiftWire;

	
	Control _Control(.InstructionOp(IF_ID_InstructionIn[31:26]), .RegDst(RegDstWire), .Jump(JumpWire), 
						.Branch(BranchWire), .MemRead(MemReadWire), .MemtoReg(MemtoRegWire), .ALUOp(ALUOpWire), .MemWrite(MemWriteWire), 
						.ALUSrc(ALUSrcWire), .RegWrite(RegWriteWire), .WriteDataSel(WriteDataSelWire), 
						.Lsel(LselWire), .Ssel(SselWire));
	
	SignExtension _SignExtension(.in(IF_ID_InstructionIn[15:0]), .out(SignExtensionOut));


	
	DangerMux _DangerMux(.DangerSel(DangerSelIn), .ALUOp(ALUOpWire), .Lsel(LselWire), .Ssel(SselWire), .RegDst(RegDstWire), 
						.RegWrite(RegWriteWire), .MemtoReg(MemtoRegWire), .MemWrite(MemWriteWire), .MemRead(MemReadWire), 
						.Branch(BranchWire), .Jump(JumpWire), .ALUSrc(ALUSrcWire), .WriteDataSel(WriteDataSelWire),
						.DangerALUOp(DangerALUOpOut), .DangerLsel(DangerLselOut), .DangerSsel(DangerSselOut), 
						.DangerRegDst(DangerRegDstOut), .DangerRegWrite(DangerRegWriteOut), .DangerMemtoReg(DangerMemtoRegOut), .DangerMemWrite(DangerMemWriteOut), 
						.DangerMemRead(DangerMemReadOut), .DangerBranch(DangerBranchOut), .DangerJump(DangerJumpOut), .DangerALUSrc(DangerALUSrcOut), .DangerWriteDataSel(DangerWriteDataSelOut));
	
	RegisterFile _RegisterFile(.ReadRegister1(IF_ID_InstructionIn[25:21]), .ReadRegister2(IF_ID_InstructionIn[20:16]), 
						.WriteRegister(MEM_WB_RegDstIn), .WriteData(JalDataMWire), .RegWrite(RFWriteEnableIn), .Clk(Clk), .ReadData1(ReadData1Out), .ReadData2(ReadData2Out), 
						.v0(v0), .v1(v1), .Rst(Rst));
	
	
	
	Mux32Bit2To1 _JalDataMux(.out(JalDataMWire), .inA(MemtoRegMuxIn), .inB(MEM_WB_PCPlus4In), .sel(MEM_WB_WriteDataSelIn));
	



endmodule
