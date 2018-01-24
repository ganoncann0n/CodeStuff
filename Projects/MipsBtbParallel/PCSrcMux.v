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
module PCSrcMux(PCAdder, JumpAddress, BranchAddress, JrAddress, Branch, Jr, Jump, PCSrc);
	
	input [31:0] PCAdder, JumpAddress, BranchAddress, JrAddress; //JrAddress comes from ALUResult
	input Branch, Jr, Jump;
	
	output reg [31:0] PCSrc;
	
	always @(Branch, Jr, Jump, PCAdder, JumpAddress, BranchAddress, JrAddress) begin
		if(Branch) begin
			PCSrc <= BranchAddress;
		end
		else if(Jr) begin
			PCSrc <= JrAddress;
		end
		else if(Jump) begin
			PCSrc <= JumpAddress;
		end
		else begin
			PCSrc <= PCAdder;
		end
	end

endmodule
