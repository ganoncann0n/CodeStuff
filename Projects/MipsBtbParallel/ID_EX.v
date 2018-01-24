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
module ID_EX(Rst, Clk, ID_EX_Flush, RegWrite, MemtoReg,  MemWrite, MemRead,  ALUOp, RegDst, ALUSrc,  ReadData1, ReadData2, ReadData3, SignExtension,
					IF_ID_ShiftAmount, IF_ID_ALUFunction, IF_ID_RegisterRs, IF_ID_RegisterRt, IF_ID_RegisterRd, Branch, Super,
					
					ID_EX_RegWrite, ID_EX_MemtoReg, ID_EX_MemWrite, ID_EX_MemRead, 
					ID_EX_ALUOp, ID_EX_RegDst, ID_EX_ALUSrc,  ID_EX_ReadData1, ID_EX_ReadData2, ID_EX_ReadData3, ID_EX_SignExtension,
					ID_EX_ShiftAmount, ID_EX_ALUFunction, ID_EX_RegisterRs, ID_EX_RegisterRt, ID_EX_RegisterRd, ID_EX_Branch, ID_EX_Super);
	input Clk, Rst;
	//HazardInput
	input ID_EX_Flush;
	//WB
	input RegWrite, MemtoReg;
	input Super;
	//Mem
	input Branch;
	input MemWrite, MemRead;
	//Ex
	input [5:0] ALUOp;
	input  RegDst;
	input ALUSrc;
	//Everything Else;
	input [31:0] ReadData1, ReadData2, ReadData3, SignExtension;
	input [4:0] IF_ID_ShiftAmount;
	input [5:0] IF_ID_ALUFunction;
	input [4:0] IF_ID_RegisterRs, IF_ID_RegisterRt, IF_ID_RegisterRd;
	
	//WBOutput
	output reg ID_EX_RegWrite, ID_EX_MemtoReg;
	//MemOutput
	output reg ID_EX_Branch;
	output reg ID_EX_MemWrite, ID_EX_MemRead;
	//ExOutput
	output reg [5:0] ID_EX_ALUOp;
	output reg  ID_EX_RegDst;
	output reg ID_EX_ALUSrc;
	//EverthingElse Output;
	output reg [31:0]  ID_EX_ReadData1, ID_EX_ReadData2, ID_EX_SignExtension;
	output reg [4:0] ID_EX_ShiftAmount;
	output reg [5:0] ID_EX_ALUFunction;
	output reg [4:0] ID_EX_RegisterRs, ID_EX_RegisterRt, ID_EX_RegisterRd;
	output reg [31:0] ID_EX_ReadData3;
	output reg ID_EX_Super;
	
	wire asyn_rst;
	
	assign asyn_rst = Rst || ID_EX_Flush;
	
	always @(posedge Clk) begin
		if(asyn_rst) begin
			ID_EX_RegWrite <= 1'b0;
			ID_EX_MemtoReg <= 1'b0;
		
			ID_EX_MemWrite <= 1'b0;
			ID_EX_MemRead <= 1'b0;
			ID_EX_ReadData3 <= 32'b0;
			ID_EX_Super <= 1'b0;
			ID_EX_ALUOp <= 6'b0;
			ID_EX_RegDst <= 1'b0;
			ID_EX_ALUSrc <= 1'b0;
			
			ID_EX_ReadData1 <= 32'b0;
			ID_EX_ReadData2 <= 32'b0;
			ID_EX_SignExtension <= 32'b0;
			ID_EX_ShiftAmount <= 5'b0;
			ID_EX_ALUFunction <= 6'b0;
			ID_EX_RegisterRs <= 5'b0;
			ID_EX_RegisterRt <= 5'b0;
			ID_EX_RegisterRd <= 5'b0;
			ID_EX_Branch <= 1'b0;
		
		
		end
		else begin
			ID_EX_RegWrite <= RegWrite;
			ID_EX_MemtoReg <= MemtoReg;
			ID_EX_ReadData3 <= ReadData3;
			ID_EX_MemWrite <= MemWrite;
			ID_EX_MemRead <= MemRead;
			ID_EX_Super <= Super;

			ID_EX_ALUOp <= ALUOp;
			ID_EX_RegDst <= RegDst;
			ID_EX_ALUSrc <= ALUSrc;
	
			ID_EX_ReadData1 <= ReadData1;
			ID_EX_ReadData2 <= ReadData2;
			ID_EX_SignExtension <= SignExtension;
			ID_EX_ShiftAmount <= IF_ID_ShiftAmount;
			ID_EX_ALUFunction <= IF_ID_ALUFunction;
			ID_EX_RegisterRs <= IF_ID_RegisterRs;
			ID_EX_RegisterRt <= IF_ID_RegisterRt;
			ID_EX_RegisterRd <= IF_ID_RegisterRd;
			ID_EX_Branch <= Branch;
		

		end
	end
endmodule
