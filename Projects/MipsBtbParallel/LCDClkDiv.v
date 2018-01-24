/*
 * Design: ECE 274 - Clock Divider generating 20 kHz clock output from 
                     50 MHz input clock needed for LCD Display Driver
 * Author: Roman Lysecky 
 * Copyright 2008, All Rights Reserved
 *
 * Date: August 19, 2008
 *
 */
 
`timescale 1ns / 1ns
module LCDClkDiv(Clk, Rst, ClkOut);

   input Clk, Rst;
   output reg ClkOut;
  
   parameter DivVal = 1250;
   reg[24:0] DivCnt;
   reg ClkInt;
	
   always @(posedge Clk) begin
      if( Rst == 1 )begin
         DivCnt <= 0;
         ClkOut <= 0;
         ClkInt <= 0;
      end
      else begin
         if( DivCnt == (DivVal-1) ) begin
            ClkOut <= ~ClkInt;
            ClkInt <= ~ClkInt;
            DivCnt <= 0;
         end
         else begin
            ClkOut <= ClkInt;
            ClkInt <= ClkInt;
            DivCnt <= DivCnt + 1;
         end
      end
   end
endmodule
