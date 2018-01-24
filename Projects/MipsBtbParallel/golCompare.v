`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:09:49 12/10/2014 
// Design Name: 
// Module Name:    golCompare 
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
module golCompare(i1, i2, i3, i4, i5, i6, i7, i8, i9, i10, i11, i12, i13, i14, i15, i16, i17, i18, i19, i20, i21, i22, i23, i24, i25, i26, i27, i28, i29, i30, uregister, midUpdate);
	input [31:0] uregister;
	input [3:0] i1, i2, i3, i4, i5, i6, i7, i8, i9, i10, i11, i12, i13, i14, i15, i16, i17, i18, i19, i20, i21, i22, i23, i24, i25, i26, i27, i28, i29, i30;
	wire a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16, a17, a18, a19, a20, a21, a22, a23, a24, a25, a26, a27, a28, a29, a30;
	output [31:0] midUpdate;
	
	minigolcompare c1(uregister[30], i1, a1);
	minigolcompare c2(uregister[29], i2, a2);
	minigolcompare c3(uregister[28], i3, a3);
	minigolcompare c4(uregister[27], i4, a4);
	minigolcompare c5(uregister[26], i5, a5);
	minigolcompare c6(uregister[25], i6, a6);
	minigolcompare c7(uregister[24], i7, a7);
	minigolcompare c8(uregister[23], i8, a8);
	minigolcompare c9(uregister[22], i9, a9);
	minigolcompare c10(uregister[21], i10, a10);
	minigolcompare c11(uregister[20], i11, a11);
	minigolcompare c12(uregister[19], i12, a12);
	minigolcompare c13(uregister[18], i13, a13);
	minigolcompare c14(uregister[17], i14, a14);
	minigolcompare c15(uregister[16], i15, a15);
	minigolcompare c16(uregister[15], i16, a16);
	minigolcompare c17(uregister[14], i17, a17);
	minigolcompare c18(uregister[13], i18, a18);
	minigolcompare c19(uregister[12], i19, a19);
	minigolcompare c20(uregister[11], i20, a20);
	minigolcompare c21(uregister[10], i21, a21);
	minigolcompare c22(uregister[9], i22, a22);
	minigolcompare c23(uregister[8], i23, a23);
	minigolcompare c24(uregister[7], i24, a24);
	minigolcompare c25(uregister[6], i25, a25);
	minigolcompare c26(uregister[5], i26, a26);
	minigolcompare c27(uregister[4], i27, a27);
	minigolcompare c28(uregister[3], i28, a28);
	minigolcompare c29(uregister[2], i29, a29);
	minigolcompare c30(uregister[1], i30, a30);
	
	
	assign midUpdate = {2'b0, a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16, a17, a18, a19, a20, a21, a22, a23, a24, a25, a26, a27, a28, a29, a30};
	

endmodule
