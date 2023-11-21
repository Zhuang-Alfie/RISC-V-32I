`timescale 1ns / 1ps

module Data_memory(
    input [31:0] A,
    input [31:0] WD,
    
    input clk,
    input WE,
    
    output logic [31:0] RD 
    );
    
    logic [31:0] RAM [61:0];
    
    assign RD = RAM[A[31:2]];
    
    always_ff @(posedge clk)
        if(WE) RAM[A[31:2]] <= WD;
        
    initial begin
        for (int i=0; i < 63; i++)
            RAM[i] <= 0;
    end

endmodule