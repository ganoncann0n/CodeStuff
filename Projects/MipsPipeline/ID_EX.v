`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:03:14 11/22/2014 
// Design Name: 
// Module Name:    ID_EX 
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
module ID_EX(Rst, Clk, ID_EX_Flush, RegWrite, MemtoReg, Lsel, Ssel, MemWrite, MemRead, Branch, Jump, ALUOp, RegDst, ALUSrc, IF_ID_PCPlus4, ReadData1, ReadData2, SignExtension,
					IF_ID_ShiftAmount, IF_ID_ALUFunction, IF_ID_RegisterRs, IF_ID_RegisterRt, IF_ID_RegisterRd, WriteDataSel, JumpAddress,
					
					ID_EX_RegWrite, ID_EX_MemtoReg, ID_EX_Lsel, ID_EX_Ssel, ID_EX_MemWrite, ID_EX_MemRead, ID_EX_Branch, ID_EX_Jump,
					ID_EX_ALUOp, ID_EX_RegDst, ID_EX_ALUSrc, ID_EX_PCPlus4, ID_EX_ReadData1, ID_EX_ReadData2, ID_EX_SignExtension,
					ID_EX_ShiftAmount, ID_EX_ALUFunction, ID_EX_RegisterRs, ID_EX_RegisterRt, ID_EX_RegisterRd, ID_EX_WriteDataSel, ID_EX_JumpAddress);
	input Clk, Rst;
	//HazardInput
	input ID_EX_Flush;
	//WB
	input RegWrite, MemtoReg, WriteDataSel;
	//Mem
	input [2:0] Lsel;
	input [1:0] Ssel;
	input MemWrite, MemRead, Branch, Jump;
	//Ex
	input [5:0] ALUOp;
	input [1:0] RegDst;
	input ALUSrc;
	//Everything Else;
	input [31:0] IF_ID_PCPlus4, ReadData1, ReadData2, SignExtension;
	input [4:0] IF_ID_ShiftAmount;
	input [5:0] IF_ID_ALUFunction;
	input [4:0] IF_ID_RegisterRs, IF_ID_RegisterRt, IF_ID_RegisterRd;
	input [31:0] JumpAddress;
	//WBOutput
	output reg ID_EX_RegWrite, ID_EX_MemtoReg, ID_EX_WriteDataSel;
	//MemOutput
	output reg [2:0] ID_EX_Lsel;
	output reg [1:0] ID_EX_Ssel;
	output reg ID_EX_MemWrite, ID_EX_MemRead, ID_EX_Branch, ID_EX_Jump;
	//ExOutput
	output reg [5:0] ID_EX_ALUOp;
	output reg [1:0] ID_EX_RegDst;
	output reg ID_EX_ALUSrc;
	//EverthingElse Output;
	output reg [31:0] ID_EX_PCPlus4, ID_EX_ReadData1, ID_EX_ReadData2, ID_EX_SignExtension;
	output reg [4:0] ID_EX_ShiftAmount;
	output reg [5:0] ID_EX_ALUFunction;
	output reg [4:0] ID_EX_RegisterRs, ID_EX_RegisterRt, ID_EX_RegisterRd;
	output reg [31:0] ID_EX_JumpAddress;
	
	wire asyn_rst;
	
	assign asyn_rst = Rst || ID_EX_Flush;
	
	always @(posedge Clk) begin
		if(asyn_rst) begin
			ID_EX_RegWrite <= 1'b0;
			ID_EX_MemtoReg <= 1'b0;
			ID_EX_Lsel <= 3'b0;
			ID_EX_Ssel <= 2'b0;
			ID_EX_MemWrite <= 1'b0;
			ID_EX_MemRead <= 1'b0;
			ID_EX_Branch <= 1'b0;
			ID_EX_Jump <= 1'b0;
			ID_EX_ALUOp <= 6'b0;
			ID_EX_RegDst <= 2'b0;
			ID_EX_ALUSrc <= 1'b0;
			ID_EX_PCPlus4 <= 32'b0;
			ID_EX_ReadData1 <= 32'b0;
			ID_EX_ReadData2 <= 32'b0;
			ID_EX_SignExtension <= 32'b0;
			ID_EX_ShiftAmount <= 5'b0;
			ID_EX_ALUFunction <= 6'b0;
			ID_EX_RegisterRs <= 5'b0;
			ID_EX_RegisterRt <= 5'b0;
			ID_EX_RegisterRd <= 5'b0;
			ID_EX_WriteDataSel <= 1'b0;
			ID_EX_JumpAddress <= 32'b0;
		end
		else begin
			ID_EX_RegWrite <= RegWrite;
			ID_EX_MemtoReg <= MemtoReg;
			ID_EX_Lsel <= Lsel;
			ID_EX_Ssel <= Ssel;
			ID_EX_MemWrite <= MemWrite;
			ID_EX_MemRead <= MemRead;
			ID_EX_Branch <= Branch;
			ID_EX_Jump <= Jump;
			ID_EX_ALUOp <= ALUOp;
			ID_EX_RegDst <= RegDst;
			ID_EX_ALUSrc <= ALUSrc;
			ID_EX_PCPlus4 <= IF_ID_PCPlus4;
			ID_EX_ReadData1 <= ReadData1;
			ID_EX_ReadData2 <= ReadData2;
			ID_EX_SignExtension <= SignExtension;
			ID_EX_ShiftAmount <= IF_ID_ShiftAmount;
			ID_EX_ALUFunction <= IF_ID_ALUFunction;
			ID_EX_RegisterRs <= IF_ID_RegisterRs;
			ID_EX_RegisterRt <= IF_ID_RegisterRt;
			ID_EX_RegisterRd <= IF_ID_RegisterRd;
			ID_EX_WriteDataSel <= WriteDataSel;
			ID_EX_JumpAddress <= JumpAddress;
		end
	end
endmodule
