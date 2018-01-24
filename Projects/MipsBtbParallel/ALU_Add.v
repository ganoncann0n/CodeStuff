`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:27:22 10/20/2014 
// Design Name: 
// Module Name:    ALU_Add 
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
module ALU_Add(A, B, Result);

	input [31:0] A,B;
	output[31:0] Result;
	
	
	
	assign Result = A + B;


endmodule
