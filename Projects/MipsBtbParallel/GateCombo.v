`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    08:29:31 12/09/2014 
// Design Name: 
// Module Name:    GateCombo 
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
module GateCombo(Branch, BTBInstructionFetch, we);
	input Branch;
	input [31:0] BTBInstructionFetch;
	
	output reg we;
	
	always@(Branch or BTBInstructionFetch) begin
		if(BTBInstructionFetch == 32'b0 && Branch) begin
			we <= 1'b1;
		end
		else if(BTBInstructionFetch != 32'b0 && Branch) begin
			we <= 1'b1;
		end
		else begin
			we <= 1'b0;
		end
	
	end
	
	

endmodule
