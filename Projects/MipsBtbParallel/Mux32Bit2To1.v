`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// Laboratory 1
// Module - Mux32Bit2To1.v
// Description - Performs signal multiplexing between 2 32-Bit words.
//	Author:Stephen Nguyen
////////////////////////////////////////////////////////////////////////////////

module Mux32Bit2To1(out, inA, inB, sel);

    output reg [31:0] out;
    
    input [31:0] inA;
    input [31:0] inB;
    input sel;

	 always @(inA, inB, sel)
	 begin
		if(sel == 1'b0)
			begin
				out <= inA;
			end
		else 
			begin
				out <= inB;
			end
	  
	 end
	  
	 

endmodule
