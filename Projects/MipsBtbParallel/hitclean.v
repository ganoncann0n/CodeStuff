`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:39:17 12/09/2014 
// Design Name: 
// Module Name:    hitclean 
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
module hitclean(A, B, F);
	input A;
	input B;
	
	output reg F;
	
	always@(A or B) begin
		if(A && !B) begin
			F <= 1'b1;
		end
		else begin
			F <= 1'b0;
		end
	end

endmodule
