`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:45:29 11/22/2014 
// Design Name: 
// Module Name:    Memory 
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
module Memory(Clk, EX_MEM_ForwardMuxBIn, EX_MEM_ALUResultIn, EX_MEM_LselIn, EX_MEM_SselIn, 
					EX_MEM_MemWriteIn, EX_MEM_MemReadIn,
					
					LoadMuxOut);
	
	input Clk;
	
	input [31:0] EX_MEM_ForwardMuxBIn, EX_MEM_ALUResultIn;
	input [2:0] EX_MEM_LselIn;
	input [1:0] EX_MEM_SselIn;
	input EX_MEM_MemWriteIn, EX_MEM_MemReadIn;
	
	output [31:0] LoadMuxOut;

	
	wire [31:0] StoreWire, ReadDataWire;
	

	
	
	

	
	StoreMux _StoreMux(EX_MEM_ForwardMuxBIn, EX_MEM_SselIn, StoreWire);
	DataMemory _DataMemory(EX_MEM_ALUResultIn, StoreWire, Clk, EX_MEM_MemWriteIn, EX_MEM_MemReadIn, ReadDataWire, EX_MEM_SselIn);
	LoadMux _LoadMux(LoadMuxOut, ReadDataWire, EX_MEM_LselIn, EX_MEM_ALUResultIn[1:0]);
	

endmodule
