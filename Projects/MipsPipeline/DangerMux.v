`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:57:29 11/22/2014 
// Design Name: 
// Module Name:    DangerMux 
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
module DangerMux(DangerSel, ALUOp, Lsel, Ssel, RegDst, RegWrite, MemtoReg, MemWrite, MemRead, Branch, Jump, ALUSrc, WriteDataSel,
						DangerALUOp, DangerLsel, DangerSsel, DangerRegDst, DangerRegWrite, DangerMemtoReg, DangerMemWrite, DangerMemRead, DangerBranch, DangerJump, DangerALUSrc, DangerWriteDataSel);
	input DangerSel;
	input [5:0] ALUOp;
	input [2:0] Lsel;
	input [1:0] Ssel, RegDst;
	input RegWrite, MemtoReg, MemWrite, MemRead, Branch, Jump, ALUSrc, WriteDataSel;
	
	output reg [5:0] DangerALUOp;
	output reg [2:0] DangerLsel;
	output reg [1:0] DangerSsel, DangerRegDst;
	output reg DangerRegWrite, DangerMemtoReg, DangerMemWrite, DangerMemRead, DangerBranch, DangerJump, DangerALUSrc, DangerWriteDataSel;
	
	always @(DangerSel, ALUOp, Lsel, Ssel, RegDst, RegWrite, MemtoReg, MemWrite, MemRead, Branch, Jump, ALUSrc, WriteDataSel) begin
		if(DangerSel) begin
			DangerALUOp <= 6'b0;
			DangerLsel <= 3'b0;
			DangerSsel <= 2'b0;
			DangerRegDst <= 2'b0;
			DangerRegWrite <= 1'b0;
			DangerMemtoReg <= 1'b0;
			DangerMemWrite <= 1'b0;
			DangerMemRead <= 1'b0;
			DangerBranch <= 1'b0;
			DangerJump <= 1'b0;
			DangerALUSrc <= 1'b0;
			DangerWriteDataSel <= 1'b0;
		end
		else begin
			DangerALUOp <= ALUOp;
			DangerLsel <= Lsel;
			DangerSsel <= Ssel;
			DangerRegDst <= RegDst;
			DangerRegWrite <= RegWrite;
			DangerMemtoReg <= MemtoReg;
			DangerMemWrite <= MemWrite;
			DangerMemRead <= MemRead;
			DangerBranch <= Branch;
			DangerJump <= Jump;
			DangerALUSrc <= ALUSrc;
			DangerWriteDataSel <= WriteDataSel;
		end
	end

endmodule
