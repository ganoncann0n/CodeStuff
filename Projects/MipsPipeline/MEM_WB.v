`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:03:58 11/22/2014 
// Design Name: 
// Module Name:    MEM_WB 
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
module MEM_WB(Rst, Clk, LoadMux, EX_MEM_ALUResult, EX_MEM_RegDst, EX_MEM_RegWrite, EX_MEM_MemtoReg, EX_MEM_WriteEnable, EX_MEM_WriteDataSel, EX_MEM_PCPlus4,

					MEM_WB_LoadMux, MEM_WB_ALUResult, MEM_WB_RegDst, MEM_WB_RegWrite, MEM_WB_MemtoReg, MEM_WB_WriteEnable, MEM_WB_WriteDataSel, MEM_WB_PCPlus4);
	input Clk, Rst;
	
	input EX_MEM_WriteDataSel;
	input [31:0] EX_MEM_PCPlus4;
	input [31:0] LoadMux, EX_MEM_ALUResult;
	input [4:0] EX_MEM_RegDst;
	input EX_MEM_RegWrite, EX_MEM_MemtoReg, EX_MEM_WriteEnable;
	
	output reg [31:0] MEM_WB_LoadMux, MEM_WB_ALUResult;
	output reg [4:0] MEM_WB_RegDst;
	output reg MEM_WB_RegWrite, MEM_WB_MemtoReg, MEM_WB_WriteEnable;
	output reg MEM_WB_WriteDataSel;
	output reg [31:0] MEM_WB_PCPlus4;
	
	always @(posedge Clk)begin

		if(Rst) begin
			MEM_WB_LoadMux <= 32'b0;
			MEM_WB_ALUResult <= 32'b0;
			MEM_WB_RegDst <= 5'b0;
			MEM_WB_RegWrite <= 1'b0;
			MEM_WB_MemtoReg <= 1'b0;
			MEM_WB_WriteEnable <= 1'b0;
			MEM_WB_WriteDataSel <= 1'b0;
			MEM_WB_PCPlus4 <= 32'b0;
		end
		else begin
			MEM_WB_LoadMux <= LoadMux;
			MEM_WB_ALUResult <= EX_MEM_ALUResult;
			MEM_WB_RegDst <= EX_MEM_RegDst;
			MEM_WB_RegWrite <= EX_MEM_RegWrite;
			MEM_WB_MemtoReg <= EX_MEM_MemtoReg;
			MEM_WB_WriteEnable <= EX_MEM_WriteEnable;
			MEM_WB_WriteDataSel <= EX_MEM_WriteDataSel;
			MEM_WB_PCPlus4 <= EX_MEM_PCPlus4;
		end
	end

endmodule
