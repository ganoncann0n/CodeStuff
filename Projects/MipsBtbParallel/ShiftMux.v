`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:42:14 12/06/2014 
// Design Name: 
// Module Name:    ShiftMux 
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
module ShiftMux(ReadData, ShiftAmount, SelShift, ShiftMux);
	input [31:0] ReadData;
	input [4:0] ShiftAmount;
	input SelShift;
	
	output reg[31:0] ShiftMux;
	
	always@(ReadData, ShiftAmount, SelShift)begin
		if(SelShift) begin
			ShiftMux <= {27'b0, ShiftAmount};
		end
		else begin
			ShiftMux <= ReadData;
		end
	end

endmodule
