`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Shuai Chang
// 
// Create Date:    02:17:58 09/09/2013 
// Module Name:    Top 
// Description: TOP module for LAB3 POST LAB, we use a clock divider to make the input Clk to the
// 				InstructionFetchUnit module to be 1Hz, therefore, you should expect the Instruction output
//				change every 1 second. 
//				Instruction output of the InstructionFetchUnit was feed into the LCD data, which keeps updating
//				the value displayed on the LCD screen.
//
//////////////////////////////////////////////////////////////////////////////////
module Top(Clk, Rst, LCD_Data, LCD_E, LCD_RS, LCD_RW);

    input Clk, Rst;
    
    output [3:0] LCD_Data;
    output LCD_E, LCD_RS, LCD_RW;
    
    wire ClkOut;
    wire [31:0] v0, v1;
    
    TopClkDiv TOP_CLK_DIV(
        .Clk(Clk), 
        .Rst(Rst), 
        .ClkOut(ClkOut)
    );
    
    LCDTop LCD_TOP(
        .Clk(Clk), 
        .Rst(Rst), 
        .DataIn_X(v0), 
        .DataIn_Y(v1), 
        .LCD_Data(LCD_Data), 
        .LCD_E(LCD_E), 
        .LCD_RS(LCD_RS), 
        .LCD_RW(LCD_RW)
    );
	
OptimizedTop mipspipeline(.Clk(ClkOut), .Rst(Rst), .v0(v0), .v1(v1));
	// Instantiate your InstructionFetchUnit here.
	// The Clk input of InstructionFetchUnit instance is the output of the TopClkDiv, (ClkOut)
	// The Instruction output of InstructionFetchUnit instance is the input of LCD_TOP, (DataIn_X and DataIn_Y)
endmodule
