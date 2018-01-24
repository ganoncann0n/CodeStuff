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
module ShiftLeft2v2(in, out);
	input[25:0] in;

	output reg [31:0] out;
	

	
	always@(in) begin
		out[31:28] <= 4'b0;
		out[27:2] <= in;
		out[1:0] <= 2'b00;
	end


endmodule
