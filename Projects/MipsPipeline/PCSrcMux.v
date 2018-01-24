`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:55:26 11/22/2014 
// Design Name: 
// Module Name:    PCSrcMux 
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
module PCSrcMux(PCAdder, JumpAddress, EX_MEM_BranchAddress, EX_MEM_JrAddress, BranchGate, JrGate, EX_MEM_Jump,
					PCSrc);
	
	input [31:0] PCAdder, JumpAddress, EX_MEM_BranchAddress, EX_MEM_JrAddress; //JrAddress comes from ALUResult
	input BranchGate, JrGate, EX_MEM_Jump;
	
	output reg [31:0] PCSrc;
	
	always @(BranchGate, JrGate, EX_MEM_Jump, PCAdder, JumpAddress, EX_MEM_BranchAddress, EX_MEM_JrAddress) begin
		if(BranchGate) begin
			PCSrc <= EX_MEM_BranchAddress;
		end
		else if(JrGate) begin
			PCSrc <= EX_MEM_JrAddress;
		end
		else if(EX_MEM_Jump) begin
			PCSrc <= JumpAddress;
		end
		else begin
			PCSrc <= PCAdder;
		end
	end

endmodule
