

module ALUControl (ALUOp, Function, ALUControlInput);

	input [5:0] Function;
	input [5:0] ALUOp;
	
	
	output reg [5:0] ALUControlInput;
	
	always @(Function, ALUOp, ALUControlInput) begin
		case(ALUOp)
			//Load/Store
			6'b000000 : begin
				ALUControlInput <= 3'b010;//(add)
			end
			// Branching		
			6'b000001 : begin
				ALUControlInput <= 3'b110;//(sub)
			end
			//Arithmetic.. opcode = 000000
			6'b000010 : begin
				case(Function)
					6'b100000 : begin
						ALUControlInput <= 6'b0010; //(add)
					end
					6'b100010 : begin
						ALUControlInput <= 6'b0110;	//(sub)
					end
					6'b100100 : begin
						ALUControlInput <= 6'b0000; //(and)
					end
					6'b100101 : begin
						ALUControlInput <= 6'b0001; //(or)
					end
					6'b101010 : begin
						ALUControlInput <= 6'b0111; //(slt)
					end
					6'b100111 : begin
						ALUControlInput <= 6'b1110 ; //(nor)
					end
					6'b100001 : begin
						ALUControlInput <= 6'b10011; //(addu)
					end
					6'b101011 : begin
						ALUControlInput <= 6'b10100; //sltu
					end
					6'b000000 : begin
						ALUControlInput <= 6'b1000; //sll
					end			
					6'b001011 : begin
						ALUControlInput <= 6'b1111; //moveN
					end	
					6'b001010 : begin
						ALUControlInput <= 6'b1010; //moveZ
					end
					6'b000011 : begin
						ALUControlInput <= 6'b1011; //sra
					end						
					6'b100110 : begin
						ALUControlInput <= 6'b1101; //xor
					end					
					6'b000100 : begin
						ALUControlInput <= 6'b10000; //sllv
					end
					6'b000110: begin
						ALUControlInput <= 6'b10001; //srlv
					end
					6'b000111: begin
						ALUControlInput <= 6'b10010; //srav
					end
					6'b000010: begin
						ALUControlInput <= 6'b01001; //SRL
					end
					6'b001000: begin
						ALUControlInput <= 6'b100000; 		//Jr
					end
					default ALUControlInput <= 6'b0010;
				endcase
			end
			//addi
			6'b000100 : begin
				ALUControlInput <= 6'b0010; 
			end
			//addiu
			6'b001000 : begin
				ALUControlInput <= 6'b10011; 
			end
			//mul, clo, clz
			6'b000101 : begin
				case(Function) 
					6'b000010 : begin
						ALUControlInput <= 6'b0011; //mul
					end
					6'b100001 : begin
						ALUControlInput <= 6'b0100; //clo
					end
					6'b100000 : begin
						ALUControlInput <= 6'b0101; //clz
					end
					default ALUControlInput <= 6'b0;
				endcase
			end
			//slti
			6'b000110 : begin
				ALUControlInput <= 6'b0111; 
			end
			//xori
			6'b000111 : begin
				ALUControlInput <= 6'b1101; 
			end
			//ori
			6'b001011 : begin
				ALUControlInput <= 6'b0001; 
			end
			//andi
			6'b001001 : begin
				ALUControlInput <= 6'b0000; 
			end
			//sltiu
			6'b01010 : begin
				ALUControlInput <= 6'b10100;
			end
			//BGEZ, BLTZ
			6'b100001 : begin
				ALUControlInput <= 6'b100001;
			end
			//beq
			6'b100010 : begin
				ALUControlInput <= 6'b100010;
			end
			//bne
			6'b100011: begin
				ALUControlInput <= 6'b100011;
			end
			//blez
			6'b100100 : begin
				ALUControlInput <= 6'b100100;
			end
			//bgtz
			6'b100101 : begin
				ALUControlInput <= 6'b100101;
			end
			//lui
			6'b100110 : begin
				ALUControlInput <= 6'b100110;
			end
			default : begin
				ALUControlInput <= 6'b000000;
			end
		endcase
	end
endmodule
