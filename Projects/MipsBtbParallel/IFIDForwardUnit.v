`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:31:48 12/07/2014 
// Design Name: 
// Module Name:    IFIDForwardUnit 
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
module IFIDForwardUnit(IF_ID_RegisterRs, IF_ID_RegisterRt, ID_EX_RegDst, EX_MEM_RegDst, Branch, Jr, IFIDForwardA, IFIDForwardB, ID_EX_Branch, EX_MEM_Branch);
	input [4:0] IF_ID_RegisterRs;
	input [4:0] IF_ID_RegisterRt;
	input [4:0] ID_EX_RegDst;
	input [4:0] EX_MEM_RegDst;
	input Branch;
	input Jr;
	input ID_EX_Branch;
	input EX_MEM_Branch;
	
	output reg [1:0] IFIDForwardA;
	output reg [1:0] IFIDForwardB;
	
	always@(IF_ID_RegisterRs or IF_ID_RegisterRt or ID_EX_RegDst or EX_MEM_RegDst or Branch or Jr or ID_EX_Branch or EX_MEM_Branch) begin
		if((ID_EX_RegDst == IF_ID_RegisterRs) && (Branch || Jr) && (!ID_EX_Branch)) begin
			IFIDForwardA <= 2'b01;
		end
		else if((EX_MEM_RegDst == IF_ID_RegisterRs) && (Branch || Jr) && (!EX_MEM_Branch)) begin
			IFIDForwardA <= 2'b10;
		end
		else begin
			IFIDForwardA <= 2'b00;
		end
		if((ID_EX_RegDst == IF_ID_RegisterRt) && (Branch) && (!ID_EX_Branch)) begin
			IFIDForwardB <= 2'b01;
		end
		else if((EX_MEM_RegDst == IF_ID_RegisterRt) && (Branch) && (!EX_MEM_Branch)) begin
			IFIDForwardB <= 2'b10;
		end
		else begin
			IFIDForwardB <= 2'b00;
		end
	end	

endmodule
