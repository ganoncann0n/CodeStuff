`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:15:41 10/24/2014 
// Design Name: 
// Module Name:    SWMUX 
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
module StoreMux(RT, Ssel, RTOut);

	input [31:0] RT;
	input [1:0] Ssel;
	output reg [31:0] RTOut;
	
	always@(RT, Ssel, RTOut) begin
		case(Ssel)
			//sw
			2'b00 : begin
				RTOut <= RT;
			end
			//sh
			2'b01 : begin
				RTOut <= {16'b0, RT[15:0]};
			end
			//sb
			2'b10 : begin
				RTOut <= {24'b0, RT[7:0]};
			end
			
			default RTOut <= RT;
		
		endcase
		
	end


endmodule
