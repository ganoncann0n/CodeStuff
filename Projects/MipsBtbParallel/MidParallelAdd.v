`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:27:53 12/09/2014 
// Design Name: 
// Module Name:    ParallelAdd 
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
module MidParallelAdd(
    input [31:0] register,
    output [1:0] r1,
    output [1:0] r2,
    output [1:0] r3,
    output [1:0] r4,
    output [1:0] r5,
    output [1:0] r6,
    output [1:0] r7,
    output [1:0] r8,
    output [1:0] r9,
    output [1:0] r10,
    output [1:0] r11,
    output [1:0] r12,
    output [1:0] r13,
    output [1:0] r14,
    output [1:0] r15,
    output [1:0] r16,
    output [1:0] r17,
    output [1:0] r18,
    output [1:0] r19,
    output [1:0] r20,
    output [1:0] r21,
    output [1:0] r22,
    output [1:0] r23,
    output [1:0] r24,
    output [1:0] r25,
    output [1:0] r26,
    output [1:0] r27,
    output [1:0] r28,
    output [1:0] r29,
    output [1:0] r30
    );
	 
	assign r1 = register[31] +  register[29];
	assign r2 = register[30] +  register[28];
	assign r3 = register[29] + register[27];
	assign r4 = register[28] + register[26];
	assign r5 = register[27] + register[25];
	assign r6 = register[26] +  register[24];
	assign r7 = register[25] +  register[23];
	assign r8 = register[24] +  register[22];
	assign r9 = register[23] +  register[21];
	assign r10 = register[22] +  register[20];
	assign r11 = register[21] +  register[19];
	assign r12 = register[20] +  register[18];
	assign r13 = register[19] +  register[17];
	assign r14 = register[18] +  register[16];
	assign r15 = register[17] +  register[15];
	assign r16 = register[16] +  register[14];
	assign r17 = register[15] +  register[13];
	assign r18 = register[14] +  register[12];
	assign r19 = register[13] +  register[11];
	assign r20 = register[12] +  register[10];
	assign r21 = register[11] +  register[9];
	assign r22 = register[10] +  register[8];
	assign r23 = register[9] + register[7];
	assign r24 = register[8] + register[6];
	assign r25 = register[7] +  register[5];
	assign r26 = register[6] +  register[4];
	assign r27 = register[5] +  register[3];
	assign r28 = register[4] + register[2];
	assign r29 = register[3] +  register[1];
	assign r30 = register[2] +  register[0];
	

endmodule
