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

module ALU32Bit(ALUControl, A, B, ALUResult, Zero, ShiftAmount, WriteEnable, OverFlow, JrSel);

	input [5:0] ALUControl; // control bits for ALU operation
	input [31:0] A, B;	    // inputs
	input [4:0] ShiftAmount;

	output reg [31:0] ALUResult;	// answer
	output reg Zero;	    // Zero=1 if ALUResult == 0
	output reg WriteEnable;
	output reg OverFlow, JrSel;
	
	wire [31:0] ALUR;
	
	assign ALUR = ALUResult;
always@(ALUControl, A, B, ShiftAmount, ALUR) begin
		WriteEnable <= 1'b1;
		JrSel <= 1'b0;
		OverFlow <= 1'b0;
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
			if($signed(A) > 0 && $signed(B) > 0)begin
				ALUResult <= A+B;
				if(ALUResult[31] == 1'b1)begin
					OverFlow <= 1'b1;
					WriteEnable <= 1'b0;
				end
				else begin
					OverFlow <= 1'b0;
					WriteEnable <= 1'b1;
				end
			end
			else if($signed(A) < 0 && $signed(B) < 0)begin
				ALUResult <= A+B;
				if(ALUResult[31] == 1'b0)begin
					OverFlow <= 1'b1;
					WriteEnable <= 1'b0;
				end
				else begin
					OverFlow <= 1'b0;
					WriteEnable <= 1'b1;
				end
			end
			else begin
				ALUResult <= A+B;
			end
			
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
		//CLO
		6'b00100 : begin
			case(1'b0)
				A[31] : ALUResult <= 32'd0; // No leading ones
				A[30] : ALUResult <= 32'd1; //One leading 1 
				A[29] : ALUResult <= 32'd2;
				A[28] : ALUResult <= 32'd3;
				A[27] : ALUResult <= 32'd4;
				A[26] : ALUResult <= 32'd5;
				A[25] : ALUResult <= 32'd6;
				A[24] : ALUResult <= 32'd7;
				A[23] : ALUResult <= 32'd8;
				A[22] : ALUResult <= 32'd9;
				A[21] : ALUResult <= 32'd10;
				A[20] : ALUResult <= 32'd11;
				A[19] : ALUResult <= 32'd12;
				A[18] : ALUResult <= 32'd13;
				A[17] : ALUResult <= 32'd14;
				A[16] : ALUResult <= 32'd15;
				A[15] : ALUResult <= 32'd16;
				A[14] : ALUResult <= 32'd17;
				A[13] : ALUResult <= 32'd18;
				A[12] : ALUResult <= 32'd19;
				A[11] : ALUResult <= 32'd20;
				A[10] : ALUResult <= 32'd21;
				A[9] : ALUResult <= 32'd22;
				A[8] : ALUResult <= 32'd23;
				A[7] : ALUResult <= 32'd24;
				A[6] : ALUResult <= 32'd25;
				A[5] : ALUResult <= 32'd26;
				A[4] : ALUResult <= 32'd27;
				A[3] : ALUResult <= 32'd28;
				A[2] : ALUResult <= 32'd29;
				A[1] : ALUResult <= 32'd30;
				A[0] : ALUResult <= 32'd31;
				default: ALUResult <= 32'd32;
			endcase
		end
		//CLZ
		6'b00101 : begin
			case(1'b1)
				A[31] : ALUResult <= 32'd0; // No leading Zeros
				A[30] : ALUResult <= 32'd1; //One leading Zero 
				A[29] : ALUResult <= 32'd2;
				A[28] : ALUResult <= 32'd3;
				A[27] : ALUResult <= 32'd4;
				A[26] : ALUResult <= 32'd5;
				A[25] : ALUResult <= 32'd6;
				A[24] : ALUResult <= 32'd7;
				A[23] : ALUResult <= 32'd8;
				A[22] : ALUResult <= 32'd9;
				A[21] : ALUResult <= 32'd10;
				A[20] : ALUResult <= 32'd11;
				A[19] : ALUResult <= 32'd12;
				A[18] : ALUResult <= 32'd13;
				A[17] : ALUResult <= 32'd14;
				A[16] : ALUResult <= 32'd15;
				A[15] : ALUResult <= 32'd16;
				A[14] : ALUResult <= 32'd17;
				A[13] : ALUResult <= 32'd18;
				A[12] : ALUResult <= 32'd19;
				A[11] : ALUResult <= 32'd20;
				A[10] : ALUResult <= 32'd21;
				A[9] : ALUResult <= 32'd22;
				A[8] : ALUResult <= 32'd23;
				A[7] : ALUResult <= 32'd24;
				A[6] : ALUResult <= 32'd25;
				A[5] : ALUResult <= 32'd26;
				A[4] : ALUResult <= 32'd27;
				A[3] : ALUResult <= 32'd28;
				A[2] : ALUResult <= 32'd29;
				A[1] : ALUResult <= 32'd30;
				A[0] : ALUResult <= 32'd31;
				default: ALUResult <= 32'd32;
				
			endcase
				
		end
		//SUB
		6'b0110 : begin
			if($signed(A) > 0 && $signed(B) < 0)begin
				ALUResult <= A-B;
				if(ALUResult[31] == 1'b1)begin
					OverFlow <= 1'b1;
					WriteEnable <= 1'b0;
				end
				else begin
					OverFlow <= 1'b0;
					WriteEnable <= 1'b1;
				end
			end
			else if($signed(A) < 0 && $signed(B) > 0)begin
				ALUResult <= A-B;
				if(ALUResult[31] == 1'b0)begin
					OverFlow <= 1'b1;
					WriteEnable <= 1'b0;
				end
				else begin
					OverFlow <= 1'b0;
					WriteEnable <= 1'b1;
				end
			end
			else begin
				ALUResult <= A-B;
			end
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
			ALUResult <= ( B << ShiftAmount);
		end
		// SRL  | 1001
		6'b1001 : begin
			ALUResult <= (B >> ShiftAmount);
		end
		
		// MOVN | 1111
		6'b1111 : begin
			if(B != 32'b0)begin
				ALUResult <= A;
	
			end
			else begin
				WriteEnable <= 1'b0;
			end
		end
		// MOVZ | 1010	
		6'b1010 : begin
			if(B == 32'b0)begin
				ALUResult <= A;
	
			end
			else begin
				WriteEnable <= 1'b0;
			end			
		end

		// SRA  | 1011
		6'b1011 : begin
			ALUResult <= ($signed(B) >>> ShiftAmount);
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
		//Jr
		6'b100000 : begin
			WriteEnable <= 1'b0;
			JrSel <= 1'b1;
			ALUResult <= A;
		end
		//Bltz, BGEZ
		6'b100001 : begin
			//Bltz
			if(B == 5'b00000)begin
				if($signed(A) < 0)begin
					ALUResult <= 32'b0;
				end
				else begin
					ALUResult <= 32'hFFFFFFFF;
				end
			end
			//BGEZ
			else begin
				if($signed(A) >= 0)begin
					ALUResult <= 32'b0;
				end
				else begin
					ALUResult <= 32'hFFFFFFFF;
				end
			end
		end
		//beq
		6'b100010 : begin
			if($signed(A) == $signed(B))begin
				ALUResult <= 32'b0;
			end
			else begin
				ALUResult <= 32'hFFFFFFFF;
			end
		end
		//bne
		6'b100011 : begin
			if($signed(A) != $signed(B))begin
				ALUResult <= 32'b0;
			end
			else begin
				ALUResult <= 32'hFFFFFFFF;
			end
		end
		//blez
		6'b100100 : begin
			if($signed(A) <= $signed(B))begin
				ALUResult <= 32'b0;
			end
			else begin
				ALUResult <= 32'hFFFFFFFF;
			end
		end
		//bgtz
		6'b100101 : begin
			if($signed(A) > $signed(B))begin
				ALUResult <= 32'b0;
			end
			else begin
				ALUResult <= 32'hFFFFFFFF;
			end
		end
		//lui
		6'b100110 : begin
			ALUResult <= B << 16;
		end
		
		default : ALUResult <= -32'd1;
	 
	 endcase
	 //ZeroCheck
	 
	 if(ALUR == 32'b0) begin
		 Zero <= 1'b1;
	 end
	 else begin
		 Zero <= 1'b0;
	 end
end
	 

endmodule

