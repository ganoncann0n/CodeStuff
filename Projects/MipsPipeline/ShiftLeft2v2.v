`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:37:02 10/24/2014 
// Design Name: 
// Module Name:    ShiftLeft2v2 
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
module ShiftLeft2v2(in, in2, out);
	input[25:0] in;
	input[31:0] in2;
	output reg [31:0] out;
	

	
	always@(in, in2) begin
		out[31:28] <= in2[31:28];
		out[27:0] <= in << 2;
	end


endmodule
