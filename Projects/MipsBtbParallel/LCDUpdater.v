`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:07:02 08/30/2013 
// Design Name: 
// Module Name:    LCDUpdater 
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
module LCDUpdater(Clk, Rst, LCDAck, DataIn1, DataIn2, DataOut1, DataOut2, LCDUpdate);

    input Clk, Rst;
    input LCDAck;
    input [9:0] DataIn1, DataIn2;
    
    output reg LCDUpdate;
    output reg [9:0] DataOut1, DataOut2;
    
    reg [1:0] State; 
    
    parameter S_INIT = 0, S_UPDATE = 1, S_WAIT_ACK = 2;
    
    initial begin
        State <= S_INIT;
    end
    
    always @ (posedge Clk, posedge Rst) begin
        if (Rst == 1) begin
            LCDUpdate <= 0;
            DataOut1 <= 0;
            DataOut2 <= 0;
        end
        else begin
            case (State)
                S_INIT: begin
                    LCDUpdate <= 0;
                    DataOut1 <= 0;
                    DataOut2 <= 0;
                    State <= S_UPDATE;
                end
                
                S_UPDATE: begin
                    DataOut1 <= DataIn1;
                    DataOut2 <= DataIn2;
                    LCDUpdate <= 1;
                    
                    if (LCDAck == 1) begin
                        State <= S_WAIT_ACK;
                    end
                    else begin
                        State <= S_UPDATE;
                    end
                    
                end
                
                S_WAIT_ACK: begin
                    LCDUpdate <= 0;
                    DataOut1 <= DataOut1;
                    DataOut2 <= DataOut2;
                    
                    if (LCDAck == 0) begin
                        State <= S_UPDATE;
                    end
                    else begin
                        State <= S_WAIT_ACK;
                    end
                end
            endcase
        end
    end

endmodule
