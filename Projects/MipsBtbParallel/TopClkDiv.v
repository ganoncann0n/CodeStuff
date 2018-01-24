`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Shuai Chang
// 
// Create Date:    02:20:06 09/09/2013 
// Design Name: 
// Module Name:    TopClkDiv 
// Target Devices: 
// Description: A clock divider that divide the 50MHz Clock to 1Hz Clock input.
//////////////////////////////////////////////////////////////////////////////////
module TopClkDiv(Clk, Rst, ClkOut);

   input Clk, Rst;
   output reg ClkOut;
  
   parameter DivVal = 1;
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