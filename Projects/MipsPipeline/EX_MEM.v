`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:03:21 11/22/2014 
// Design Name: 
// Module Name:    EX_MEM 
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
module EX_MEM(Rst, Clk,  ID_EX_RegWrite, ID_EX_MemtoReg, ID_EX_Lsel, ID_EX_Ssel, ID_EX_MemWrite, ID_EX_MemRead, 
					ID_EX_WriteDataSel, ID_EX_PCPlus4,
				   ALUResult, ForwardMuxB, RegDst, WriteEnable,
					
					EX_MEM_RegWrite, EX_MEM_MemtoReg, EX_MEM_Lsel, EX_MEM_Ssel, EX_MEM_MemWrite, EX_MEM_MemRead, 
					EX_MEM_ALUResult, EX_MEM_ForwardMuxB, EX_MEM_RegDst, EX_MEM_WriteEnable, 
					EX_MEM_WriteDataSel, EX_MEM_PCPlus4);
	input Clk, Rst;
	
	//WB
	input ID_EX_RegWrite, ID_EX_MemtoReg, ID_EX_WriteDataSel;
	//Mem
	input [2:0] ID_EX_Lsel;
	input [1:0] ID_EX_Ssel;
	input ID_EX_MemWrite, ID_EX_MemRead;
	//Everything Else
	input [31:0] ID_EX_PCPlus4;
	input [31:0]  ALUResult, ForwardMuxB;
	input [4:0] RegDst;
	input WriteEnable;
	
	
	output reg EX_MEM_RegWrite, EX_MEM_MemtoReg;
	output reg [2:0] EX_MEM_Lsel;
	output reg [1:0] EX_MEM_Ssel;
	output reg EX_MEM_MemWrite, EX_MEM_MemRead;
	output reg [31:0]  EX_MEM_ALUResult, EX_MEM_ForwardMuxB;
	output reg [4:0] EX_MEM_RegDst;
	output reg EX_MEM_WriteEnable;
	output reg EX_MEM_WriteDataSel;
	output reg [31:0] EX_MEM_PCPlus4;

	
	always @(posedge Clk) begin
		if(Rst)begin
			EX_MEM_RegWrite <= 1'b0;
			EX_MEM_MemtoReg <= 1'b0;
			EX_MEM_Lsel <= 3'b0;
			EX_MEM_Ssel <= 2'b0;
			EX_MEM_MemWrite <= 1'b0;
			EX_MEM_MemRead <= 1'b0;
			EX_MEM_ALUResult <= 32'b0;
			EX_MEM_ForwardMuxB <= 32'b0;
			EX_MEM_RegDst <= 5'b0;
			EX_MEM_WriteEnable <= 1'b0;
			EX_MEM_WriteDataSel <= 1'b0;
			EX_MEM_PCPlus4 <= 32'b0;
		end
		else begin
	
			EX_MEM_RegWrite <= ID_EX_RegWrite;
			EX_MEM_MemtoReg <= ID_EX_MemtoReg;
			EX_MEM_Lsel <= ID_EX_Lsel;
			EX_MEM_Ssel <= ID_EX_Ssel;
			EX_MEM_MemWrite <= ID_EX_MemWrite;
			EX_MEM_MemRead <= ID_EX_MemRead;
			EX_MEM_ALUResult <= ALUResult;
			EX_MEM_ForwardMuxB <= ForwardMuxB;
			EX_MEM_RegDst <= RegDst;
			EX_MEM_WriteEnable <= WriteEnable;
			EX_MEM_WriteDataSel <= ID_EX_WriteDataSel;
			EX_MEM_PCPlus4 <= ID_EX_PCPlus4;

		end
	end

endmodule
