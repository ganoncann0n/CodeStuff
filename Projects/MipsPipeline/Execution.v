`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:37:32 11/22/2014 
// Design Name: 
// Module Name:    Execution 
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
module Execution(ID_EX_SignExtensionIn, ID_EX_ReadData1In, ID_EX_ReadData2In, MemtoRegMuxIn, EX_MEM_ALUResultIn, ID_EX_PCPlus4In,
						ID_EX_ALUOpIn, ID_EX_ALUFunctionIn, ID_EX_RegisterRtIn, ID_EX_RegisterRdIn, ID_EX_ShiftAmountIn, 
						ForwardAIn, ForwardBIn, ID_EX_RegDstIn,
						ID_EX_ALUSrcIn,
						
						BranchAddressOut, ALUResultOut, RegDstOut, ZeroOut, WriteEnableOut, OverFlowOut, JrSelOut, ForwardMuxBOut);
	
	input [31:0] ID_EX_SignExtensionIn, ID_EX_ReadData1In, ID_EX_ReadData2In, MemtoRegMuxIn, EX_MEM_ALUResultIn, ID_EX_PCPlus4In;
	input [5:0] ID_EX_ALUOpIn, ID_EX_ALUFunctionIn;
	input [4:0] ID_EX_RegisterRtIn, ID_EX_RegisterRdIn, ID_EX_ShiftAmountIn;
	input [1:0] ForwardAIn, ForwardBIn, ID_EX_RegDstIn;
	input ID_EX_ALUSrcIn;
	
	output [31:0] BranchAddressOut, ALUResultOut, ForwardMuxBOut;
	output [4:0] RegDstOut;
	output ZeroOut, WriteEnableOut, OverFlowOut, JrSelOut;
	
	
	wire [31:0] BranchShiftWire, ForwardMuxAWire, ALUSrcMuxWire;
	wire [5:0] ALUControlWire;
	
	ShiftLeft2 _BranchShift(ID_EX_SignExtensionIn, BranchShiftWire);
	
	Forward_Mux _ForwardMuxA(ForwardAIn, ID_EX_ReadData1In, MemtoRegMuxIn, EX_MEM_ALUResultIn, ForwardMuxAWire);
	
	Forward_Mux _ForwardMuxB(ForwardBIn, ID_EX_ReadData2In, EX_MEM_ALUResultIn, MemtoRegMuxIn, ForwardMuxBOut);
	
	Mux5Bit3To1 _RegDstMux(ID_EX_RegisterRtIn, ID_EX_RegisterRdIn, 5'b11111, ID_EX_RegDstIn, RegDstOut);
	
	Mux32Bit2To1 _ALUSrcMux(ALUSrcMuxWire, ForwardMuxBOut, ID_EX_SignExtensionIn, ID_EX_ALUSrcIn);
	
	ALUControl _ALUControl(ID_EX_ALUOpIn, ID_EX_ALUFunctionIn, ALUControlWire);
	
	ALU_Add _ALU_ADD(ID_EX_PCPlus4In, BranchShiftWire, BranchAddressOut);
	
	ALU32Bit _ALUMain(ALUControlWire, ForwardMuxAWire, ALUSrcMuxWire, ALUResultOut, ZeroOut, ID_EX_ShiftAmountIn, WriteEnableOut, OverFlowOut, JrSelOut);
	

endmodule
