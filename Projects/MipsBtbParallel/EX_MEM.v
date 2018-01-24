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
module EX_MEM(Rst, Clk,  ID_EX_RegWrite, ID_EX_MemtoReg,  ID_EX_MemWrite, ID_EX_MemRead, 
				   ALUResult, ForwardMuxB, RegDst, ID_EX_Branch, ID_EX_Super, update,
					
					EX_MEM_RegWrite, EX_MEM_MemtoReg, EX_MEM_MemWrite, EX_MEM_MemRead, 
					EX_MEM_ALUResult, EX_MEM_ForwardMuxB, EX_MEM_RegDst, EX_MEM_Branch, EX_MEM_Super, EX_MEM_Update);
	input Clk, Rst;
	input ID_EX_Super;
	//WB
	input ID_EX_RegWrite, ID_EX_MemtoReg;
	//Mem
	input ID_EX_Branch;
	input ID_EX_MemWrite, ID_EX_MemRead;
	//Everything Else
	input [31:0]  ALUResult, ForwardMuxB;
	input [4:0] RegDst;
	input [31:0] update;
	
	
	output reg EX_MEM_RegWrite, EX_MEM_MemtoReg;
	output reg EX_MEM_Branch;
	output reg EX_MEM_MemWrite, EX_MEM_MemRead;
	output reg [31:0]  EX_MEM_ALUResult, EX_MEM_ForwardMuxB;
	output reg [4:0] EX_MEM_RegDst;
	output reg EX_MEM_Super;
	output reg [31:0] EX_MEM_Update;

	
	always @(posedge Clk) begin
		if(Rst)begin
			EX_MEM_RegWrite <= 1'b0;
			EX_MEM_MemtoReg <= 1'b0;
			EX_MEM_Super <= 1'b0;
			EX_MEM_MemWrite <= 1'b0;
			EX_MEM_MemRead <= 1'b0;
			EX_MEM_ALUResult <= 32'b0;
			EX_MEM_ForwardMuxB <= 32'b0;
			EX_MEM_RegDst <= 5'b0;
			EX_MEM_Branch <= 1'b0;
			EX_MEM_Update <= 32'b0;

		end
		else begin
	
			EX_MEM_RegWrite <= ID_EX_RegWrite;
			EX_MEM_MemtoReg <= ID_EX_MemtoReg;
			EX_MEM_Super <= ID_EX_Super;
			EX_MEM_MemWrite <= ID_EX_MemWrite;
			EX_MEM_MemRead <= ID_EX_MemRead;
			EX_MEM_ALUResult <= ALUResult;
			EX_MEM_ForwardMuxB <= ForwardMuxB;
			EX_MEM_RegDst <= RegDst;
			EX_MEM_Branch <= ID_EX_Branch;
			EX_MEM_Update <= update;

		end
	end

endmodule
