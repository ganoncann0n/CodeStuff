`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:51:28 11/22/2014 
// Design Name: 
// Module Name:    InstructionFetch 
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
module InstructionFetch(Rst, Clk, BranchGateIn, JrGateIn,  EX_MEM_JumpIn, PCWrite_DisableIn, JumpAddressIn, BranchAddressIn, JrAddressIn, 
								InstructionOut, PCAdderOut);
	
	input Rst, Clk;
	input BranchGateIn, JrGateIn, PCWrite_DisableIn, EX_MEM_JumpIn;
	input [31:0] JumpAddressIn, BranchAddressIn, JrAddressIn;
	
	output [31:0] InstructionOut, PCAdderOut;
	
	wire [31:0] PCSrcWire, PCWire;

	PCSrcMux _PCSrcMux(.PCAdder(PCAdderOut), .JumpAddress(JumpAddressIn), .EX_MEM_BranchAddress(BranchAddressIn), .EX_MEM_JrAddress(JrAddressIn), 
					.BranchGate(BranchGateIn), .JrGate(JrGateIn), .EX_MEM_Jump(EX_MEM_JumpIn), .PCSrc(PCSrcWire));
					
	ProgramCounter _ProgramCounter(.Address(PCSrcWire), .PCResult(PCWire), .Reset(Rst), .Clk(Clk), .PCWrite_Disable(PCWrite_DisableIn));
	
	InstructionMemory _InstructionMemory(.Address(PCWire), .Instruction(InstructionOut)); 
	
	PCAdder _PCAdder(.PCResult(PCWire), .PCAddResult(PCAdderOut));
	


endmodule
