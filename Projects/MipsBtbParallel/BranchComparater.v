`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:14:49 12/07/2014 
// Design Name: 
// Module Name:    BranchComparater 
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
module BranchComparater(ReadA, ReadB, BranchOp, BranchResult);
	input [31:0] ReadA;
	input [31:0] ReadB;
	input BranchOp;
	
	output reg BranchResult;
	
	always@(ReadA or ReadB or BranchOp) begin
		case(BranchOp)
			1'b0 : begin //Beq
				if(ReadA == ReadB) begin
					BranchResult <= 1'b1;
				end
				else begin
					BranchResult <= 1'b0;
				end
			end
			1'b1 : begin //Bne
				if(ReadA != ReadB) begin
					BranchResult <= 1'b1;
				end
				else begin
					BranchResult <= 1'b0;
				end
			end
			default BranchResult <= 1'b0;
		endcase
	end
	

endmodule
