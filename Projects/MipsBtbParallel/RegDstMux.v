`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:42:51 12/02/2014 
// Design Name: 
// Module Name:    RegDstMux 
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
module RegDstMux(A, B, Sel, F);
	input [4:0] A, B;
	input  Sel;
	
	output [4:0] F;
	
	assign F = (Sel)?B:A;

endmodule
