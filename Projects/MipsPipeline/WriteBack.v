`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:47:36 11/22/2014 
// Design Name: 
// Module Name:    WriteBack 
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
module WriteBack(MEM_WB_LoadMuxIn, MEM_WB_ALUResultIn, MEM_WB_MemtoRegIn, MemtoRegMuxOut);
	
	input [31:0] MEM_WB_LoadMuxIn, MEM_WB_ALUResultIn;
	input MEM_WB_MemtoRegIn;
	
	output [31:0] MemtoRegMuxOut;

	Mux32Bit2To1 _MemoryToRegisterMux(MemtoRegMuxOut, MEM_WB_ALUResultIn, MEM_WB_LoadMuxIn, MEM_WB_MemtoRegIn);

endmodule
