`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    02:30:03 09/09/2013 
// Design Name: 
// Module Name:    Top_tb 
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
module Top_tb();

    reg Clk, Rst;
    wire [3:0] LCD_Data;
    wire LCD_E, LCD_RS, LCD_RW;
    
    Top TOP_TEST(
        .Clk(Clk), 
        .Rst(Rst), 
        .LCD_Data(LCD_Data), 
        .LCD_E(LCD_E), 
        .LCD_RS(LCD_E), 
        .LCD_RW(LCD_RW)
    );
    
    always begin
        Clk <= 0;
        #10;
        Clk <= 1;
        #10;
    end
    
    initial begin
        #50;
        Rst <= 1;
        #100;
        Rst <= 0;
    end
endmodule
