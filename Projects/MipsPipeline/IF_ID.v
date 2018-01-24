`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:03:03 11/22/2014 
// Design Name: 
// Module Name:    IF_ID 
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
module IF_ID(Rst, Clk, IF_ID_Flush, IF_ID_Write_Disable, Instruction, PCPlus4, IF_ID_Instruction, IF_ID_PCPlus4);
	
	input Clk, Rst;
	//HazardInput
	input IF_ID_Flush, IF_ID_Write_Disable;
	
	//EverythingElse
	input [31:0] Instruction, PCPlus4;
	
	output reg [31:0] IF_ID_Instruction, IF_ID_PCPlus4;
	
	wire asyn_rst;
	
	assign asyn_rst = Rst || IF_ID_Flush;
	
	always @(posedge Clk) begin
		if(asyn_rst == 1'b1) begin
			IF_ID_Instruction <= 32'b0;
			IF_ID_PCPlus4 <= 32'b0;
		end
		else if(IF_ID_Write_Disable == 1'b1) begin
			//Do nothing
		end
		else begin
			IF_ID_Instruction <= Instruction;
			IF_ID_PCPlus4 <= PCPlus4;
		end
	end
	

endmodule
