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
module MEM_WB(Rst, Clk, MemoryToRegisterMux, EX_MEM_RegDst, EX_MEM_RegWrite, EX_MEM_Super, EX_MEM_Update, 

					 MEM_WB_MemoryToRegisterMux, MEM_WB_RegDst, MEM_WB_RegWrite, MEM_WB_Super, MEM_WB_Update);
	input Clk, Rst;
	
	input [31:0] MemoryToRegisterMux;
	input [4:0] EX_MEM_RegDst;
	input EX_MEM_RegWrite;
	input EX_MEM_Super;
	input [31:0] EX_MEM_Update;
	
	
	output reg [31:0] MEM_WB_MemoryToRegisterMux;
	output reg [4:0] MEM_WB_RegDst;
	output reg MEM_WB_RegWrite;
	output reg MEM_WB_Super;
	output reg [31:0] MEM_WB_Update;
	
	always @(posedge Clk)begin

		if(Rst) begin
			MEM_WB_MemoryToRegisterMux <= 32'b0;
			MEM_WB_RegDst <= 5'b0;
			MEM_WB_RegWrite <= 1'b0;
			MEM_WB_Super <= 1'b0;
			MEM_WB_Update <= 32'b0;
		end
		else begin
			MEM_WB_MemoryToRegisterMux <= MemoryToRegisterMux;
			MEM_WB_RegDst <= EX_MEM_RegDst;
			MEM_WB_RegWrite <= EX_MEM_RegWrite;
			MEM_WB_Super <= EX_MEM_Super;
			MEM_WB_Update <= EX_MEM_Update;
	
		end
	end

endmodule
