`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:21:10 10/24/2014 
// Design Name: 
// Module Name:    DataMemorySMux 
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
module LoadMux(outLoad, ReadData, sel, Address);

input [31:0] ReadData;
input [2:0] sel;
input [1:0] Address;
output reg [31:0] outLoad;

always@(ReadData, sel, Address) begin
	case(sel)
		//lw
		3'b000 : begin
			outLoad <= ReadData;
		end
		//lh
		3'b001 : begin
			outLoad <= {{16{ReadData[15]}}, ReadData[15:0]}; 
		end
		//lb
		3'b010 : begin
			if(Address == 2'b00) begin
				outLoad <= {{24{ReadData[7]}}, ReadData[7:0]};
			end
			else if(Address == 2'b01) begin
				outLoad <= {{24{ReadData[15]}}, ReadData[15:8]};
			end	
			else if(Address == 2'b10) begin
				outLoad <= {{24{ReadData[23]}}, ReadData[23:16]};
			end
			else begin
				outLoad <= {{24{ReadData[31]}}, ReadData[31:24]};
			end
		end
		//lhu
		3'b011 : begin
			outLoad <= {16'b0, ReadData[15:0]}; 
		end
		//lbu
		3'b100 : begin
			outLoad <= {24'b0, ReadData[7:0]};
		end
		
		default outLoad <= ReadData;
	endcase
end
endmodule
