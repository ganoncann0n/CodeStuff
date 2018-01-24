`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:47:07 12/09/2014 
// Design Name: 
// Module Name:    minibuffer 
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
module minibuffer(Clk, Rst, FetchBP,  FetchAddress, FetchBTBInstruction, 
			bFetchBP,  bFetchAddress, bFetchBTBInstruction);
	input Clk, Rst;
	input [1:0] FetchBP;
	input [31:0] FetchAddress;
	input [31:0]FetchBTBInstruction;
	
	
	output reg [1:0] bFetchBP;
	output reg [31:0] bFetchAddress;
	output reg [31:0] bFetchBTBInstruction;

	
	always@(posedge Clk) begin
		if(Rst) begin
			bFetchBP <= 2'b0;
			bFetchAddress <= 32'b0;
			bFetchBTBInstruction <= 32'b0;
		end
		else begin
			bFetchBP <= FetchBP;
		
			bFetchAddress <= FetchAddress;
			bFetchBTBInstruction <= FetchBTBInstruction;
		end
	end
endmodule
