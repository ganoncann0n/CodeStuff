`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:06:46 12/07/2014 
// Design Name: 
// Module Name:    b2bitfsm 
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
module b2bitfsm(Clk, Rst, Prediction, taken, POut);
	input Clk, Rst;
	input [1:0] Prediction;
	input taken;
	
	output reg [1:0] POut;
	parameter SNT = 2'b00, NT = 2'b01, T = 2'b10, ST = 2'b11;
	
	always@(negedge Clk) begin
		if(Rst) begin
			POut <= 2'b00;
		end
		else begin
			case(Prediction)
				SNT : begin
					if(taken) begin
						POut <= 2'b01;
					end
					else begin
						POut <= 2'b00;
					end
				end
				NT : begin
					if(taken) begin
						POut <= 2'b10;
					end
					else begin
						POut <= 2'b00;
					end
				end
				T : begin
					if(taken) begin
						POut <= 2'b11;
					end
					else begin
						POut <= 2'b01;
					end
				end
				ST : begin
					if(taken) begin
						POut <= 2'b11;
					end
					else begin
						POut <= 2'b10;
					end
				end
				default POut <= 2'b00;
			endcase
		end
	end

endmodule
