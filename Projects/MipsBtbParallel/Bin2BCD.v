/*
 * Design: ECE 274 - Binary to BCD Converter 
 * Description: Converts 10-bit binary input to 4 digit Binary Coded Decimal 
 *
 * Author: Roman Lysecky 
 * Copyright 2007, All Rights Reserved
 *
 * Date: Oct 11, 2007
 *
 */
 
`timescale 1ns / 1ns
module Bin2BCD(Binary, BCD);

   input [9:0] Binary;
   output reg [15:0] BCD;
   
   reg [25:0] Temp;
   integer i;

   always @(Binary) begin
      Temp = {16'h0000, Binary};
      for(i=0; i<9; i=i+1) begin
         Temp = Temp << 1;
         if(Temp[13:10] > 4) Temp[13:10] = Temp[13:10] + 3;
         if(Temp[17:14] > 4) Temp[17:14] = Temp[17:14] + 3;
         if(Temp[21:18] > 4) Temp[21:18] = Temp[21:18] + 3;
         if(Temp[25:22] > 4) Temp[25:22] = Temp[25:22] + 3;
      end
      Temp = Temp << 1;
      BCD <= Temp[25:10];
   end
endmodule
