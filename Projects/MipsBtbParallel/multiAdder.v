`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:40:53 12/09/2014 
// Design Name: 
// Module Name:    multiAdder 
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
module multiAdder(
    input [31:0] r1,
    input [31:0] r2,
    input [31:0] r3,
    output [3:0] o1,
    output [3:0] o2,
    output [3:0] o3,
    output [3:0] o4,
    output [3:0] o5,
    output [3:0] o6,
    output [3:0] o7,
    output [3:0] o8,
    output [3:0] o9,
    output [3:0] o10,
    output [3:0] o11,
    output [3:0] o12,
    output [3:0] o13,
    output [3:0] o14,
    output [3:0] o15,
    output [3:0] o16,
    output [3:0] o17,
    output [3:0] o18,
    output [3:0] o19,
    output [3:0] o20,
    output [3:0] o21,
    output [3:0] o22,
    output [3:0] o23,
    output [3:0] o24,
    output [3:0] o25,
    output [3:0] o26,
    output [3:0] o27,
    output [3:0] o28,
    output [3:0] o29,
    output [3:0] o30
    );
	 
	 wire [1:0] a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16, a17, a18, a19, a20, a21, a22, a23, a24, a25, a26, a27, a28, a29, a30;
	 wire [1:0] b1, b2, b3, b4, b5, b6, b7, b8, b9, b10, b11, b12, b13, b14, b15, b16, b17, b18, b19, b20, b21, b22, b23, b24, b25, b26, b27, b28, b29, b30;
	 wire [1:0] c1, c2, c3, c4, c5, c6, c7, c8, c9, c10, c11, c12, c13, c14, c15, c16, c17, c18, c19, c20, c21, c22, c23, c24, c25, c26, c27, c28, c29, c30;
	 
	 
	 ParallelAdd _registerA(r1, a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16, a17, a18, a19, a20, a21, a22, a23, a24, a25, a26, a27, a28, a29, a30);
	 MidParallelAdd _registerB(r2, b1, b2, b3, b4, b5, b6, b7, b8, b9, b10, b11, b12, b13, b14, b15, b16, b17, b18, b19, b20, b21, b22, b23, b24, b25, b26, b27, b28, b29, b30);
	 ParallelAdd _registerC(r3, c1, c2, c3, c4, c5, c6, c7, c8, c9, c10, c11, c12, c13, c14, c15, c16, c17, c18, c19, c20, c21, c22, c23, c24, c25, c26, c27, c28, c29, c30);
	 
	 SecondParallelAdd SecondPA1(a1, b1, c1, o1);
	SecondParallelAdd SecondPA2(a2, b2, c2, o2);
	SecondParallelAdd SecondPA3(a3, b3, c3, o3);
	SecondParallelAdd SecondPA4(a4, b4, c4, o4);
	SecondParallelAdd SecondPA5(a5, b5, c5, o5);
	SecondParallelAdd SecondPA6(a6, b6, c6, o6);
	SecondParallelAdd SecondPA7(a7, b7, c7, o7);
	SecondParallelAdd SecondPA8(a8, b8, c8, o8);
	SecondParallelAdd SecondPA9(a9, b9, c9, o9);
	SecondParallelAdd SecondPA10(a10, b10, c10, o10);
	SecondParallelAdd SecondPA11(a11, b11, c11, o11);
	SecondParallelAdd SecondPA12(a12, b12, c12, o12);
	SecondParallelAdd SecondPA13(a13, b13, c13, o13);
	SecondParallelAdd SecondPA14(a14, b14, c14, o14);
	SecondParallelAdd SecondPA15(a15, b15, c15, o15);
	SecondParallelAdd SecondPA16(a16, b16, c16, o16);
	SecondParallelAdd SecondPA17(a17, b17, c17, o17);
	SecondParallelAdd SecondPA18(a18, b18, c18, o18);
	SecondParallelAdd SecondPA19(a19, b19, c19, o19);
	SecondParallelAdd SecondPA20(a20, b20, c20, o20);
	SecondParallelAdd SecondPA21(a21, b21, c21, o21);
	SecondParallelAdd SecondPA22(a22, b22, c22, o22);
	SecondParallelAdd SecondPA23(a23, b23, c23, o23);
	SecondParallelAdd SecondPA24(a24, b24, c24, o24);
	SecondParallelAdd SecondPA25(a25, b25, c25, o25);
	SecondParallelAdd SecondPA26(a26, b26, c26, o26);
	SecondParallelAdd SecondPA27(a27, b27, c27, o27);
	SecondParallelAdd SecondPA28(a28, b28, c28, o28);
	SecondParallelAdd SecondPA29(a29, b29, c29, o29);
	SecondParallelAdd SecondPA30(a30, b30, c30, o30);
	 
	 
	 
	 /*
	 ParallelAdd _register1(.register(), .r1(), .r2(), .r3(), .r4(), .r5(), .r6(), .r7(), .r8(), .r9(), .r10(),
													 .r11(), .r12(), .r13(), .r14(), .r15(), .r16(), .r17(), .r18(), .r19(), .r20(),
													 .r21(), .r22(), .r23(), .r24(), .r25(), .r26(), .r27(), .r28(), .r29(), .r30());
	 MidParallelAdd _register2(.register(), .r1(), .r2(), .r3(), .r4(), .r5(), .r6(), .r7(), .r8(), .r9(), .r10(),
													 .r11(), .r12(), .r13(), .r14(), .r15(), .r16(), .r17(), .r18(), .r19(), .r20(),
													 .r21(), .r22(), .r23(), .r24(), .r25(), .r26(), .r27(), .r28(), .r29(), .r30());
	 ParallelAdd _register3(.register(), .r1(), .r2(), .r3(), .r4(), .r5(), .r6(), .r7(), .r8(), .r9(), .r10(),
													 .r11(), .r12(), .r13(), .r14(), .r15(), .r16(), .r17(), .r18(), .r19(), .r20(),
													 .r21(), .r22(), .r23(), .r24(), .r25(), .r26(), .r27(), .r28(), .r29(), .r30());
	 */
	 
	 


endmodule
