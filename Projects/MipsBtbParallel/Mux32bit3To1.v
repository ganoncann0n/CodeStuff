`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:48:04 12/09/2014 
// Design Name: 
// Module Name:    Mux32bit3To1 
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
module Mux32bit3To1(PredictorA, Default, Recovery, hit, r, PredictMuxOut);

input [31:0] PredictorA, Default, Recovery;
input hit, r;
output reg [31:0] PredictMuxOut;

always@(PredictorA, Default, Recovery, hit, r) begin

	if(hit)
		PredictMuxOut <= PredictorA;
	else if(r)
		PredictMuxOut <=Recovery;
	else
		PredictMuxOut <= Default;	//brings back old pc+4 from before miss jump
end
endmodule
