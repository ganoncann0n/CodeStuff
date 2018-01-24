`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:59:32 10/14/2014 
// Design Name: 
// Module Name:    tb 
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
module tb();

reg Clk, Rst;



wire [31:0] v0, v1;

OptimizedTop toppy(.Clk(Clk), .Rst(Rst), .v0(v0), .v1(v1));



initial begin
Rst <= 1'b1;
Clk <= 1'b1;
forever #20 Clk <= ~Clk;

end
initial begin
		
		
		
		
		
		#70 Rst <=1'b0;
		//$monitor("%d ", tb.T.InstructionFetch_0.PC_0.PCResult);
	
		
		
	//	$display("%b", tb.T.RegisterFile_0.registers[31:0]);
		
end




//#20;
	// forever begin 
	//	#20 $display(" %d :\n", tb.T.DM.); //Fix to match top
		/*	$display("\tRegister 0 - %h", tb.T.RegisterFile_0.registers[0]);
			$display("\tRegister 1 - %h", tb.T.RegisterFile_0.registers[1]);
			$display("\tRegister 2 - %h", tb.T.RegisterFile_0.registers[2]);
			$display("\tRegister 3 - %h", tb.T.RegisterFile_0.registers[3]);
			$display("\tRegister 4 - %h", tb.T.RegisterFile_0.registers[4]);
			$display("\tRegister 5 - %h", tb.T.RegisterFile_0.registers[5]);
			$display("\tRegister 6 - %h", tb.T.RegisterFile_0.registers[6]);
			$display("\tRegister 7 - %h", tb.T.RegisterFile_0.registers[7]);
			*/
			//$display("\t$t0: %d", $signed(tb.T.RegisterFile_0.registers[8]));
		//	$display("\t$t1: %d", $signed(tb.T.RegisterFile_0.registers[9]));
		//	$display("\t$t2: %d", $signed(tb.T.RegisterFile_0.registers[10]));
		//	$display("\t$t3: %d", $signed(tb.T.RegisterFile_0.registers[11]));
		//	$display("\t$t4: %d", $signed(tb.T.RegisterFile_0.registers[12]));
		//	$display("\t$t5: %d", $signed(tb.T.RegisterFile_0.registers[13]));
		//	$display("\t$t6: %d\n", $signed(tb.T.RegisterFile_0.registers[14]));
		//	$display("\t$t7: %d", tb.T.RegisterFile_0.registers[15]);
		//	$display("\t$s0: %d", $signed(tb.T.RegisterFile_0.registers[16]));
		//	$display("\t$s1: %d", $signed(tb.T.RegisterFile_0.registers[17]));
		//	$display("\t$s2: %d", $signed(tb.T.RegisterFile_0.registers[18]));
		//	$display("\t$s3: %d", $signed(tb.T.RegisterFile_0.registers[19]));
			
	//end
	
	 


/*initial begin
	#30;
	forever #10 $display("%d \n", tb.T.RegisterFile_0.registers[0]);
		forever #10 $display("%d \n", tb.T.RegisterFile_0.registers[1]);
		forever #10 $display("%d \n", tb.T.RegisterFile_0.registers[2]);
		forever #10 $display("%d \n", tb.T.RegisterFile_0.registers[3]);
		forever #10 $display("%d \n", tb.T.RegisterFile_0.registers[4]);
		forever #10 $display("%d \n", tb.T.RegisterFile_0.registers[5]);
		forever #10 $display("%d \n", tb.T.RegisterFile_0.registers[6]);
		forever #10 $display("%d \n", tb.T.RegisterFile_0.registers[7]);
		forever #10 $display("%d \n", tb.T.RegisterFile_0.registers[8]);
		forever #10 $display("%d \n", tb.T.RegisterFile_0.registers[9]);
		forever #10 $display("%d \n", tb.T.RegisterFile_0.registers[10]);
		forever #10 $display("%d \n", tb.T.RegisterFile_0.registers[11]);
		forever #10 $display("%d \n", tb.T.RegisterFile_0.registers[12]);
		forever #10 $display("%d \n", tb.T.RegisterFile_0.registers[13]);
		forever #10 $display("%d \n", tb.T.RegisterFile_0.registers[14]);
		forever #10 $display("%d \n", tb.T.RegisterFile_0.registers[15]);
		forever #10 $display("%d \n", tb.T.RegisterFile_0.registers[16]);
		forever #10 $display("%d \n", tb.T.RegisterFile_0.registers[17]);
		forever #10 $display("%d \n", tb.T.RegisterFile_0.registers[18]);
		forever #10 $display("%d \n", tb.T.RegisterFile_0.registers[19]);
		forever #10 $display("%d \n", tb.T.RegisterFile_0.registers[20]);
		forever #10 $display("%d \n", tb.T.RegisterFile_0.registers[21]);
		forever #10 $display("%d \n", tb.T.RegisterFile_0.registers[22]);
		forever #10 $display("%d \n", tb.T.RegisterFile_0.registers[23]);
		forever #10 $display("%d \n", tb.T.RegisterFile_0.registers[24]);
		forever #10 $display("%d \n", tb.T.RegisterFile_0.registers[25]);
		forever #10 $display("%d \n", tb.T.RegisterFile_0.registers[26]);
		forever #10 $display("%d \n", tb.T.RegisterFile_0.registers[27]);
		forever #10 $display("%d \n", tb.T.RegisterFile_0.registers[28]);
		forever #10 $display("%d \n", tb.T.RegisterFile_0.registers[29]);
		forever #10 $display("%d \n", tb.T.RegisterFile_0.registers[30]);
		forever #10 $display("%d \n", tb.T.RegisterFile_0.registers[31]);
end


*/
endmodule
