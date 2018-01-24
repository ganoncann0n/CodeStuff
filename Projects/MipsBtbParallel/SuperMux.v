`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    02:07:44 12/10/2014 
// Design Name: 
// Module Name:    SuperMux 
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
module SuperMux(RegularData, SuperData, SuperSel, Out);
	input [31:0] RegularData, SuperData;
	input SuperSel;
	
	output reg [31:0] Out;
	
	always@(RegularData or SuperData or SuperSel) begin
		if(SuperSel) begin
			Out <= SuperData;
		end
		else begin
			Out <= RegularData;
		end
	end


endmodule
