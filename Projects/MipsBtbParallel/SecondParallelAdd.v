`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:29:31 12/09/2014 
// Design Name: 
// Module Name:    SecondParallelAdd 
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
module SecondParallelAdd(
    input [1:0] r1,
    input [1:0] r2,
    input [1:0] r3,
    output [3:0] life
    );
	
	assign life = r1 + r2 + r3;

endmodule
