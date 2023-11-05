`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.11.2023 15:20:41
// Design Name: 
// Module Name: Data_memory
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Data_memory(
    input [31:0] A,
    input [31:0] WD,
    
    input clk,
    input WE,
    
    output logic [31:0] RD 
    );
    
    always_ff @(posedge clk)
        if(WE) RD <= WD;
    
endmodule
