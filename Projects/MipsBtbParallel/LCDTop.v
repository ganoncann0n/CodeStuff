`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:45:02 08/30/2013 
// Design Name: 
// Module Name:    LCDTop 
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
module LCDTop(Clk, Rst, DataIn_X, DataIn_Y, LCD_Data, LCD_E, LCD_RS, LCD_RW);

    input Clk, Rst;
  
    input [31:0] DataIn_X, DataIn_Y;
    
    wire ClkOut;
    wire LCDUpdate, LCDAck;
    wire [9:0] DataOut_X, DataOut_Y;
    // LCD Interface
    output [11:8] LCD_Data;
    output LCD_E, LCD_RS, LCD_RW;

    LCDClkDiv LCD_CLK_DIV(
        .Clk(Clk), 
        .Rst(Rst), 
        .ClkOut(ClkOut)
    );

    LCDUpdater LCD_UPDATER(
        .Clk(Clk), 
        .Rst(Rst),
        .LCDAck(LCDAck),
        .DataIn1(DataIn_X[9:0]),
        .DataIn2(DataIn_Y[9:0]),     
        .DataOut1(DataOut_X),
        .DataOut2(DataOut_Y),        
        .LCDUpdate(LCDUpdate));

    LCDDisplay LCD_DISPLAY(
        .Clk(ClkOut), 
        .Rst(Rst),
        .DataIn_X(DataOut_X),
        .DataIn_Y(DataOut_Y),
        .LCDUpdate(LCDUpdate),
        .LCDAck(LCDAck), 
        .LCD_Data(LCD_Data), 
        .LCD_E(LCD_E), 
        .LCD_RS(LCD_RS), 
        .LCD_RW(LCD_RW)
    );

endmodule
