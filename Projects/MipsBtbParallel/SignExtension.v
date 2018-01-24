`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// Laboratory 1
// Module - SignExtension.v
// Description - Sign extension module.
// Author: Stephen Nguyen
////////////////////////////////////////////////////////////////////////////////
module SignExtension(in, out);

    /* A 16-Bit input word */
    input [15:0] in;

    /* A 32-Bit output word */
    output [31:0] out;
 

	assign out[31:16] = {16{in[15]}};
	assign out[15:0] = in[15:0];

		
	  
		
	 
endmodule
