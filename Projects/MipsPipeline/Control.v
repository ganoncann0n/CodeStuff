



module Control(InstructionOp, RegDst, Jump, Branch, MemRead, MemtoReg, ALUOp, MemWrite, ALUSrc, RegWrite, WriteDataSel, Lsel, Ssel);
	input [5:0] InstructionOp;
	output reg [5:0] ALUOp;
	output reg [2:0] Lsel;
	output reg [1:0] RegDst, Ssel;
	output reg Jump, Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite, WriteDataSel;
	
	
	always@(InstructionOp) begin
		
			//defaults
			WriteDataSel <= 1'b0;
			Lsel <= 3'b0;
			Ssel <= 2'b0;
		case(InstructionOp)
			//R-Type
			6'b000000 : begin
				RegDst <= 1'b1;
				ALUSrc <= 1'b0;
				MemtoReg <= 1'b0;
				RegWrite <= 1'b1;
				MemRead <= 1'b0;
				MemWrite <= 1'b0;
				Branch <= 1'b0;
				Jump <= 1'b0;
				ALUOp <= 6'b000010;
			end
			//bgez and bltz
			6'b000001 : begin
				RegDst <= 1'b0;
				Jump <= 1'b0;
				Branch <= 1'b1;
				MemRead <= 1'b0;
				MemtoReg <= 1'b0;
				ALUOp <= 6'b100001; //Something
				MemWrite <= 1'b0;
				ALUSrc <= 1'b0;
				RegWrite <= 1'b0;
			end
			//J
			6'b000010 : begin
				RegDst <= 1'b0;
				Jump <= 1'b1;
				Branch <= 1'b0;
				MemRead <= 1'b0;
				MemtoReg <= 1'b0;
				ALUOp <= 6'b000000; //Something
				MemWrite <= 1'b0;
				ALUSrc <= 1'b0;
				RegWrite <= 1'b0;
			end
			//jal
			6'b000011 : begin
				RegDst <= 2'b10;
				Jump <= 1'b1;
				Branch <= 1'b0;
				MemRead <= 1'b0;
				MemtoReg <= 1'b0;
				ALUOp <= 6'b000000; //Something can add more to make these jump work
				MemWrite <= 1'b0;
				ALUSrc <= 1'b0;
				RegWrite <= 1'b1;
				WriteDataSel <= 1'b1;
				
			end
			//beq
			6'b000100 : begin
				RegDst <= 1'b0;
				Jump <= 1'b0;
				Branch <= 1'b1;
				MemRead <= 1'b0;
				MemtoReg <= 1'b0;
				ALUOp <= 6'b100010; //Subtraction
				MemWrite <= 1'b0;
				ALUSrc <= 1'b0;
				RegWrite <= 1'b0;
			end
			//bne
			6'b000101 : begin
				RegDst <= 1'b0;
				Jump <= 1'b0;
				Branch <= 1'b1;
				MemRead <= 1'b0;
				MemtoReg <= 1'b0;
				ALUOp <= 6'b100011;
				MemWrite <= 1'b0;
				ALUSrc <= 1'b0;
				RegWrite <= 1'b0;
			end
			//blez
			6'b000110 : begin
				RegDst <= 1'b0;
				Jump <= 1'b0;
				Branch <= 1'b1;
				MemRead <= 1'b0;
				MemtoReg <= 1'b0;
				ALUOp <= 6'b100100; 
				MemWrite <= 1'b0;
				ALUSrc <= 1'b0;
				RegWrite <= 1'b0;
			end
			//bgtz
			6'b000111 : begin
				RegDst <= 1'b0;
				Jump <= 1'b0;
				Branch <= 1'b1;
				MemRead <= 1'b0;
				MemtoReg <= 1'b0;
				ALUOp <= 6'b100101; 
				MemWrite <= 1'b0;
				ALUSrc <= 1'b0;
				RegWrite <= 1'b0;
			end
			//lui
			6'b001111 : begin
				RegDst <= 1'b0;
				Jump <= 1'b0;
				Branch <= 1'b0;
				MemRead <= 1'b0;
				MemtoReg <= 1'b0;
				ALUOp <= 6'b100110; //Something
				MemWrite <= 1'b0;
				ALUSrc <= 1'b1;
				RegWrite <= 1'b1;
			end	
			//lb
			6'b100000 : begin
				RegDst <= 1'b0;
				Jump <= 1'b0;
				Branch <= 1'b0;
				MemRead <= 1'b1;
				MemtoReg <= 1'b1;
				ALUOp <= 6'b001000; //addiu
				MemWrite <= 1'b0;
				ALUSrc <= 1'b1;
				RegWrite <= 1'b1;
				Lsel <= 3'b010;
			end
			//lh
			6'b100001 : begin
				RegDst <= 1'b0;
				Jump <= 1'b0;
				Branch <= 1'b0;
				MemRead <= 1'b1;
				MemtoReg <= 1'b1;
				ALUOp <= 6'b001000; //addiu
				MemWrite <= 1'b0;
				ALUSrc <= 1'b1;
				RegWrite <= 1'b1;
				Lsel <= 3'b001;
			end
			//lw
			6'b100011 : begin
				RegDst <= 1'b0;
				Jump <= 1'b0;
				Branch <= 1'b0;
				MemRead <= 1'b1;
				MemtoReg <= 1'b1;
				ALUOp <= 6'b001000; //addiu
				MemWrite <= 1'b0;
				ALUSrc <= 1'b1;
				RegWrite <= 1'b1;
			end
			//lbu
			6'b100100 : begin
				RegDst <= 1'b0;
				Jump <= 1'b0;
				Branch <= 1'b0;
				MemRead <= 1'b1;
				MemtoReg <= 1'b1;
				ALUOp <= 6'b001000; //addiu
				MemWrite <= 1'b0;
				ALUSrc <= 1'b1;
				RegWrite <= 1'b1;
				Lsel <= 3'b100;
			end
			//lhu
			6'b100101 : begin
				RegDst <= 1'b0;
				Jump <= 1'b0;
				Branch <= 1'b0;
				MemRead <= 1'b1;
				MemtoReg <= 1'b1;
				ALUOp <= 6'b001000; //addiu
				MemWrite <= 1'b0;
				ALUSrc <= 1'b1;
				RegWrite <= 1'b1;
				Lsel <= 3'b011;
			end
			//sb
			6'b101000 : begin
				RegDst <= 1'b0;
				Jump <= 1'b0;
				Branch <= 1'b0;
				MemRead <= 1'b0;
				MemtoReg <= 1'b0;
				ALUOp <= 6'b001000; //addiu
				MemWrite <= 1'b1;
				ALUSrc <= 1'b1;
				RegWrite <= 1'b0;
				Ssel <= 2'b10;
			end
			//sh
			6'b101001 : begin
				RegDst <= 1'b0;
				Jump <= 1'b0;
				Branch <= 1'b0;
				MemRead <= 1'b0;
				MemtoReg <= 1'b0;
				ALUOp <= 6'b001000; //addiu
				MemWrite <= 1'b1;
				ALUSrc <= 1'b1;
				RegWrite <= 1'b0;
				Ssel <= 2'b01;
			end
			//sw
			6'b101011 : begin
				RegDst <= 1'b0;
				Jump <= 1'b0;
				Branch <= 1'b0;
				MemRead <= 1'b0;
				MemtoReg <= 1'b0;
				ALUOp <= 6'b001000; //addiu
				MemWrite <= 1'b1;
				ALUSrc <= 1'b1;
				RegWrite <= 1'b0;
			end
			
			//Addi
			6'b001000 : begin
				RegDst <= 1'b0;
				ALUSrc <= 1'b1;
				MemtoReg <= 1'b0;
				RegWrite <= 1'b1;
				MemRead <= 1'b0;
				MemWrite <= 1'b0;
				Branch <= 1'b0;
				Jump <= 1'b0;
				ALUOp <= 6'b000100;
			end
			//Addiu
			6'b001001 : begin
				RegDst <= 1'b0;
				ALUSrc <= 1'b1;
				MemtoReg <= 1'b0;
				RegWrite <= 1'b1;
				MemRead <= 1'b0;
				MemWrite <= 1'b0;
				Branch <= 1'b0;
				Jump <= 1'b0;
				ALUOp <= 6'b001000;
			end			
			// Mul, clo, clz
			6'b011100 : begin
				RegDst <= 1'b1;
				ALUSrc <= 1'b0;
				MemtoReg <= 1'b0;
				RegWrite <= 1'b1;
				MemRead <= 1'b0;
				MemWrite <= 1'b0;
				Branch <= 1'b0;
				Jump <= 1'b0;
				ALUOp <= 6'b000101;
			end
			// slti
			6'b001010 : begin
				RegDst <= 1'b0;
				Jump <= 1'b0;
				Branch <= 1'b0;
				MemRead <= 1'b0;
				MemtoReg <= 1'b0;
				ALUOp <= 6'b000110;
				MemWrite <= 1'b0;
				ALUSrc <= 1'b1;
				RegWrite <= 1'b1;
			end
			//Sltiu
			6'b001011 : begin
				RegDst <= 1'b0;
				Jump <= 1'b0;
				Branch <= 1'b0;
				MemRead <= 1'b0;
				MemtoReg <= 1'b0;
				ALUOp <= 6'b001010;
				MemWrite <= 1'b0;
				ALUSrc <= 1'b1;
				RegWrite <= 1'b1;
			end
			//andi
			6'b001100 : begin
				RegDst <= 1'b0;
				Jump <= 1'b0;
				Branch <= 1'b0;
				MemRead <= 1'b0;
				MemtoReg <= 1'b0;
				ALUOp <= 6'b001001;
				MemWrite <= 1'b0;
				ALUSrc <= 1'b1;
				RegWrite <= 1'b1;
			end
			//ori
			6'b001101 : begin
				RegDst <= 1'b0;
				Jump <= 1'b0;
				Branch <= 1'b0;
				MemRead <= 1'b0;
				MemtoReg <= 1'b0;
				ALUOp <= 6'b001011;
				MemWrite <= 1'b0;
				ALUSrc <= 1'b1;
				RegWrite <= 1'b1;
			end
			//xori
			6'b001110 : begin
				RegDst <= 1'b0;
				Jump <= 1'b0;
				Branch <= 1'b0;
				MemRead <= 1'b0;
				MemtoReg <= 1'b0;
				ALUOp <= 6'b000111;
				MemWrite <= 1'b0;
				ALUSrc <= 1'b1;
				RegWrite <= 1'b1;
			end
			default begin
				ALUOp <= 6'b0;
				Lsel <= 3'b0;
				RegDst <= 2'b0; 
				Ssel <= 2'b0;
				Jump <= 1'b0;
				Branch <= 1'b0;
				MemRead <= 1'b0;
				MemtoReg <= 1'b0;
				MemWrite <= 1'b0;
				ALUSrc <= 1'b0;
				RegWrite <= 1'b0; 
				WriteDataSel <= 1'b0;
			
			end
		endcase
	end
endmodule