`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// Laboratory 3 (PreLab)
// Module - data_memory.v
// Description - 32-Bit wide data memory.
// Author - Stephen Nguyen and Sheldon Ruiz
//
// INPUTS:-
// Address: 32-Bit address input port.
// Clk: 1-Bit Input clock signal.
// WriteData: 32-Bit input port.
// MemWrite: 1-Bit control signal for memory write.
// MemRead: 1-Bit control signal for memory read.
//
// OUTPUTS:-
// ReadData: 32-Bit registered output port.
//
// FUNCTIONALITY:-
// Design the above memory similar to the 'RegisterFile' model in the previous 
// assignment.  Create a 1K memory, for which we need 10 bits.  In order to 
// implement byte addressing, we will use bits Address[11:2] to index the 
// memory location. The 'WriteData' value is written into the address 
// corresponding to Address[11:2] in the positive clock edge if 'MemWrite' 
// signal is 1. 'ReadData' is the value of memory location Address[11:2] if 
// 'MemRead' is 1, otherwise, it is 0x00000000. The reading of memory is not 
// clocked.
////////////////////////////////////////////////////////////////////////////////

module DataMemory(Address, WriteData, Clk, MemWrite, MemRead, ReadData, StoreX); 

	input [31:0] Address; 	// Input Address 
	input [31:0] WriteData; // Data that needs to be written into the address 
	input Clk;
	input MemWrite; 		// Control signal for memory write 
	input MemRead; 			// Control signal for memory read 
	input [1:0] StoreX;
	
	output reg[31:0] ReadData; // Contents of memory location at Address
	reg [31:0] memoryin;
	reg [31:0] memory[0:100];
	
	integer i;
	initial begin

		for(i = 0; i <=100; i = i + 1)begin
				memory[i] = 32'b0;
		end

		// memory[1] = 32'h00000001;
		//memory[2] = 32'hffffffff;

//test case	

memory[0] = 32'd8;

memory[1] = 32'd128;

memory[2] = 32'd20;

memory[3] = 32'd8;

memory[4] = 32'd64;

//data 21, 1 => 8, 7

memory[5] = 32'hbbbb000;

memory[6] = 32'h927332;

memory[7] = 32'h1234abc;

memory[8] = 32'h56765;

memory[9] = 32'h345abc;

memory[10] = 32'h2345;

memory[11] = 32'h20203030;

memory[12] = 32'h1122;

memory[13] = 32'h5feef51;

memory[14] = 32'h5432;

memory[15] = 32'hdddd00;

memory[16] = 32'h909090;

memory[17] = 32'hdddd00;

memory[18] = 32'h4536abc;

memory[19] = 32'h445533;

memory[20] = 32'h5e5f0000;

memory[21] = 32'h12032d;

memory[22] = 32'h787878;

memory[23] = 32'h54543233;

memory[24] = 32'h1111ff00;

memory[25] = 32'ha0a0a0;

memory[26] = 32'h20203030;

memory[27] = 32'h2223338;

memory[28] = 32'h1111ff00;

memory[29] = 32'h12032d;

memory[30] = 32'h2223338;

memory[31] = 32'h1111ff00;

memory[32] = 32'hdddd00;

memory[33] = 32'h445533;

memory[34] = 32'h4536abc;

memory[35] = 32'h20203030;

memory[36] = 32'h20203030;

	end
	
	
	always@(WriteData, StoreX, Address) begin
		memoryin <= memory[Address[31:2]];
		if(StoreX == 2'b10) begin
			if(Address[1:0] == 2'b00)
				memoryin[7:0] <= WriteData;
			if(Address[1:0] == 2'b01)
				memoryin[15:8] <= WriteData;
			if(Address[1:0] == 2'b10)
				memoryin[23:16] <= WriteData;
			if(Address[1:0] == 2'b11)
				memoryin[31:24] <= WriteData;
		end
		else memoryin <= WriteData;
	end
	
	always @ (posedge Clk) begin
		if(MemWrite == 1'b1) begin
			memory[Address[31:2]] <= memoryin;
		end
		else begin end
			
	
	end
	
	always @(negedge Clk) begin
		if(MemRead == 1'b1) begin
			ReadData <= memory[Address[31:2]];
		end
		else begin end
			
		
	end
	


endmodule
