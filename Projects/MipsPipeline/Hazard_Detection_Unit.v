`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:23:43 11/12/2014 
// Design Name: 
// Module Name:    Hazard_Detection_Unit 
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
module Hazard_Detection_Unit(IF_ID_RegisterRs, IF_ID_RegisterRt, ID_EX_RegisterRt, ID_EX_MemRead, BranchGate,
						PCWrite_Disable, IF_ID_Write_Disable, IF_ID_Flush, ID_EX_Flush, DangerSel, Jump);

	input [4:0] IF_ID_RegisterRs, IF_ID_RegisterRt, ID_EX_RegisterRt;
	input ID_EX_MemRead, BranchGate;
	input Jump;
	
	output reg PCWrite_Disable, IF_ID_Write_Disable;
	output reg IF_ID_Flush, ID_EX_Flush, DangerSel;
	
	
	
	always @(IF_ID_RegisterRs, IF_ID_RegisterRt, ID_EX_RegisterRt, ID_EX_MemRead, BranchGate, Jump) begin
		if(ID_EX_MemRead && (ID_EX_RegisterRt == IF_ID_RegisterRs || ID_EX_RegisterRt == IF_ID_RegisterRt)) begin
			PCWrite_Disable <= 1'b1;
			IF_ID_Write_Disable <= 1'b1;
			DangerSel <= 1'b1;
		end
		else begin
			PCWrite_Disable <= 1'b0;
			IF_ID_Write_Disable <= 1'b0;
			DangerSel <= 1'b0;
		end
		
		if(BranchGate || Jump) begin
			IF_ID_Flush <= 1'b1;
			ID_EX_Flush <= 1'b1;
		end
		else begin
			IF_ID_Flush <= 1'b0;
			ID_EX_Flush <= 1'b0;
		end
		
		
	end
endmodule
