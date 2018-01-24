`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:49:54 11/17/2014 
// Design Name: 
// Module Name:    Forward_Unit 
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
module Forward_Unit(ID_EX_RegisterRs, ID_EX_RegisterRt, EX_MEM_RegDst, MEM_WB_RegDst, MEM_WB_RegWrite, EX_MEM_RegWrite,
							ForwardMuxASel, ForwardMuxBSel);
	
	input [4:0] ID_EX_RegisterRs, ID_EX_RegisterRt, EX_MEM_RegDst, MEM_WB_RegDst;
	input MEM_WB_RegWrite, EX_MEM_RegWrite;
	
	output reg [1:0] ForwardMuxASel, ForwardMuxBSel;


	always @(ID_EX_RegisterRs, ID_EX_RegisterRt, EX_MEM_RegDst, MEM_WB_RegDst, MEM_WB_RegWrite, EX_MEM_RegWrite) begin
		ForwardMuxASel <= 2'b00;
		ForwardMuxBSel <= 2'b00;
		//MEM_WB Forward //Might be broken? who knows
		if(MEM_WB_RegWrite && MEM_WB_RegDst != 5'b0) begin
			if(MEM_WB_RegDst == ID_EX_RegisterRs) begin
				ForwardMuxASel <= 2'b01;		
			end
			if(MEM_WB_RegDst == ID_EX_RegisterRt) begin
				ForwardMuxBSel <= 2'b10;
			end
			else begin 
			end
		end
		else begin 
		end
		//EX_MEM forward
		if(EX_MEM_RegWrite && EX_MEM_RegDst != 5'b0)begin
			if(EX_MEM_RegDst == ID_EX_RegisterRs)begin
				ForwardMuxASel <= 2'b10;
			end
			if(EX_MEM_RegDst == ID_EX_RegisterRt) begin
				ForwardMuxBSel <= 2'b01;
			end
			else begin 
			end
		end
		else begin 
		end
	
		
	end
		
	
endmodule
