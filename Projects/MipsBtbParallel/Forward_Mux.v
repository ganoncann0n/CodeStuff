`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:31:40 11/17/2014 
// Design Name: 
// Module Name:    Forward_Mux 
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
module Forward_Mux(Forward_Mux_sel, Forward_Mux_A, Forward_Mux_B, Forward_Mux_C, Forward_Mux_F);
	input [1:0] Forward_Mux_sel;
	input [31:0] Forward_Mux_A, Forward_Mux_B, Forward_Mux_C;
	output reg [31:0] Forward_Mux_F;
	
	always@(Forward_Mux_sel, Forward_Mux_A, Forward_Mux_B, Forward_Mux_C) begin
		case(Forward_Mux_sel) 
			2'b00 : begin
				Forward_Mux_F <= Forward_Mux_A;
			end
			2'b01 : begin
				Forward_Mux_F <= Forward_Mux_B;
			end
			2'b10 : begin
				Forward_Mux_F <= Forward_Mux_C;
			end
			default Forward_Mux_F <= 0;
		
		endcase
	end

endmodule
