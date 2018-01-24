`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:32:40 11/24/2014 
// Design Name: 
// Module Name:    Mux5Bit3To1 
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
module Mux5Bit3To1(A, B, C, Sel, F);
	input [4:0] A, B, C;
	input [1:0] Sel;
	
	output reg [4:0] F;
	
	always@(A, B, C, Sel)begin
		case(Sel)
			2'b00 : begin
				F <= A;
			end
			2'b01 : begin
				F <= B;
			end
			2'b10 : begin
				F <= C;
			end
			default F <= 5'b0;
		
		endcase
	end
	

endmodule
