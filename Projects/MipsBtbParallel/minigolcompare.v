`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:13:44 12/10/2014 
// Design Name: 
// Module Name:    minigolcompare 
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
module minigolcompare(life, lifecount, update);
	input life;
	input [3:0] lifecount;
	output reg update;
	
	always@(life or lifecount) begin
		if(life) begin
			if((lifecount == 3) || (lifecount == 2)) begin
				update <= 1'b0;
			end
			else begin
				update <= 1'b1;
			end
		end
		else begin
			if(lifecount == 3) begin
				update <= 1'b1;
			end
			else begin
				update <= 1'b0;
			end
		end
	end


endmodule
