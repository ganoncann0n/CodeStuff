`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:59:23 12/07/2014 
// Design Name: 
// Module Name:    BTB 
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
module BTB(Clk, we, Address1, Address2, BranchAddress, FSMResult, BIPCFetchOut, BAFetchOut, BPFetchOut);
	input Clk;
	input we;
	input [31:0] Address1;
	input [31:0] Address2; //Branch Instructino PC
	input [31:0] BranchAddress;
	input [1:0] FSMResult;
	
	reg [31:0] bipc[0:303];
	reg [31:0] ba[0:303];
	reg [1:0] bp[0:303];
	
	reg [8:0] read_a;
	
	output [31:0] BIPCFetchOut;
	output [31:0] BAFetchOut;
	output [1:0] BPFetchOut;
	
	wire nClk;
	assign nClk = Clk;
	
	integer i;
	initial begin
		for(i=0; i<=303;i=i+1) begin
			bipc[i] <= 32'b0;
			ba[i] <= 32'b0;
			bp[i] <= 2'b0;
		end
	end
	
	always@(posedge Clk) begin
		if(we) begin
			bipc[Address2[31:2]] <= Address2;
			ba[Address2[31:2]] <= BranchAddress;
			bp[Address2[31:2]] <= FSMResult;
		end
	end
	always@(negedge nClk) begin
		read_a <= Address1[31:2];
	end
	assign BIPCFetchOut = bipc[read_a];
	assign BAFetchOut = ba[read_a];
	assign BPFetchOut = bp[read_a];
	
endmodule
