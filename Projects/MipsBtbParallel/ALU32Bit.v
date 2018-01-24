`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// Laboratory 3 (PreLab)
// Module - ALU32Bit.v
// Description - 32-Bit wide arithmetic logic unit (ALU).
//
// INPUTS:-
// ALUControl: 4-Bit input control bits to select an ALU operation.
// A: 32-Bit input port A.
// B: 32-Bit input port B.
//
// OUTPUTS:-
// ALUResult: 32-Bit ALU result output.
// ZERO: 1-Bit output flag. 
//
// FUNCTIONALITY:-
// Design a 32-Bit ALU behaviorally, so that it supports addition,  subtraction,
// AND, OR, and set on less than (SLT). The 'ALUResult' will output the 
// corresponding result of the operation based on the 32-Bit inputs, 'A', and 
// 'B'. The 'Zero' flag is high when 'ALUResult' is '0'. The 'ALUControl' signal 
// should determine the function of the ALU based on the table below:-
// Op   | 'ALUControl' value
// ==========================
// AND  | 0000
// OR   | 0001
// ADD  | 0010
// MUL  | 0011
// CLO  | 0100
// CLZ  | 0101
// SUB  | 0110
// SLT  | 0111
// SLL  | 1000
// SRL  | 1001
// MOVN | 1010
// /////////MOVZ | 1010
// SRA  | 1011
// XOR  | 1101
// NOR  | 1110
// 
//
// NOTE:-
// SLT (i.e., set on less than): ALUResult is '32'h000000001' if A < B.
// 
////////////////////////////////////////////////////////////////////////////////

module ALU32Bit(ALUControl, A, B, ALUResult);

	input [5:0] ALUControl; // control bits for ALU operation
	input [31:0] A, B;	    // inputs


	output reg [31:0] ALUResult;	// answer
  


	


always@(ALUControl, A, B) begin

	ALUResult <= 32'b0;



    case(ALUControl)
		//AND
		6'b0000 : begin
			ALUResult <= A & B;

	
			
		end
		//OR
		6'b0001 : begin
			ALUResult <= A | B;
	
	
		end
		//ADD
		6'b0010 : begin		

			ALUResult <= A+B;
	
		end
		//ADDU //Need to add to ALUop
		6'b10011 : begin
			ALUResult <= A + B;
		

		end
		//SLTU
		6'b10100 : begin
			
	
			
			if(A < B)begin
				ALUResult <= 32'd1;
			end
			else begin
				ALUResult <= 32'd0;
			end
		end
		//MUL
		6'b0011 : begin
			ALUResult <= A * B;
		end
		
				
	
		//SUB
		6'b0110 : begin
			ALUResult <= A-B;
		end
		//SLT
		6'b0111 : begin
			if($signed(A) < $signed(B)) begin
				ALUResult <= 32'd1;
			end
			else begin
				ALUResult <= 32'd0;
			end
		end
		// SLL  | 1000
		6'b01000 : begin
			ALUResult <= ( B << A);
		end
		// SRL  | 1001
		6'b1001 : begin
			ALUResult <= (B >> A);
		end
		

		// SRA  | 1011
		6'b1011 : begin
			ALUResult <= ($signed(B) >>> A);
		end
		// XOR  | 1101
		6'b1101 : begin
			ALUResult <= A ^ B;
		end
		// NOR  | 1110
		6'b1110 : begin
			ALUResult <= ~(A | B);
		end
		//sllv
		6'b10000 : begin
			ALUResult <= (B << A);
		end
		//srlv
		6'b10001 : begin
			ALUResult <= (B >> A);
		end
		//srav
		6'b10010 : begin
			ALUResult <= ($signed(B) >>> A);
		end
		//lui
		6'b100110 : begin
	
			ALUResult <= B << 16;
		end
		default : ALUResult <= -32'd1;
	 
	 endcase
end



endmodule

