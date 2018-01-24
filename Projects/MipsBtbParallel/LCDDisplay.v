/*
 * Design: ECE 274 - Top Level LCD Display Module  
 * Author: Roman Lysecky 
 * Copyright 2007, All Rights Reserved
 *
 * Date: Oct 11, 2007
 *
 */
 
`timescale 1ns / 1ns
module LCDDisplay(Clk, Rst, DataIn_X, DataIn_Y, LCDUpdate, LCDAck, LCD_Data, LCD_E, LCD_RS, LCD_RW);

    input Clk, Rst;

    input [9:0] DataIn_X, DataIn_Y;
    input LCDUpdate;
    output reg LCDAck;

    // LCD Interface
    output [11:8] LCD_Data;
    output LCD_E, LCD_RS, LCD_RW;

    parameter   S_INIT = 0, 
                S_WAIT = 1, 
                S_UPDATE = 2, 
                S_LCDACK = 3;
   
    reg [8*16:1] Display;
    wire [15:0] BCD_X, BCD_Y;
    reg [3:0] State;
    reg GO;
   
    LcdInterface LcdInterface_0 (Rst, Clk, GO, Display, LCD_Data, LCD_E, LCD_RS, LCD_RW);
    Bin2BCD Bin2BCD_X (DataIn_X, BCD_X);
    Bin2BCD Bin2BCD_Y (DataIn_Y, BCD_Y);
   
    initial begin
        State <= S_INIT;
    end
    always @(posedge Clk) begin
        if( Rst == 1 ) begin
            State <= S_INIT;
            LCDAck <= 0;
            GO <= 0;
            Display <= " ";
        end
        else begin
            
            case( State )
                S_INIT: begin
                    LCDAck <= 0;
                    Display <= "";
                    GO <= 1;
                    State <= S_WAIT;
                end

                S_WAIT: begin
                    GO <= 0;
                    LCDAck <= 0;

                    if (LCDUpdate == 1) begin
                        State <= S_UPDATE;
                    end
                    else begin
                        State <= S_WAIT;
                    end
                end

                S_UPDATE: begin
                    LCDAck <= 0;
                    GO <= 1;
                    Display[128:121] <= "v";
                    Display[120:113] <= "0";
                    Display[112:105] <= "=";
                    Display[104:97] <= 8'h30 + BCD_X[11:8];
                    Display[96:89] <= 8'h30 + BCD_X[7:4];
                    Display[88:81] <= 8'h30 + BCD_X[3:0];
                    Display[80:73] <= " ";
                    Display[72:65] <= "v";
                    Display[64:57] <= "1";
                    Display[56:49] <= "=";
                    Display[48:41] <= 8'h30 + BCD_Y[11:8];
                    Display[40:33] <= 8'h30 + BCD_Y[7:4];
                    Display[32:25] <= 8'h30 + BCD_Y[3:0];
                    Display[24:17] <= " ";   
                    Display[16:9] <= " ";  
                    Display[8:1] <= " ";
                   
                    State <= S_LCDACK;
                end

                S_LCDACK: begin
                   LCDAck <= 1;
                   if (LCDUpdate == 1) begin
                      State <= S_LCDACK;
                   end
                   else begin
                      State <= S_WAIT;
                   end
                end
         endcase
      end
   end
endmodule










