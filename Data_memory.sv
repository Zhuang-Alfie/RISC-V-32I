`timescale 1ns / 1ps

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
