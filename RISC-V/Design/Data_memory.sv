`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// University: Dublin City University 
// Supervisor: Xiaojun Wang
// Student Name: Zhuang Miao 
// Module Name: Data_memory
// Project Name: Implementation and Performance Analysis of the RSIC-V RV32I Architecture
// Description: The Data Memory component serves as the primary storage area for data 
//              used and produced by the program being executed.
//////////////////////////////////////////////////////////////////////////////////

module Data_memory(
    input [31:0] A,         // Reading address
    input [31:0] WD,        // Writing address
    input clk,
    input WE,               // Writing enable
    output logic [31:0] RD  // Reading data
    );
    
    logic [31:0] RAM [100:0];
    
    assign RD = RAM[A[31:2]];
    
    //Synchronous write, synchronous read
    always_ff @(posedge clk) begin
        // Last two bits of word address are always zero. Because RISC-V byte addressable.
        if(WE) RAM[A[31:2]] <= WD;
    end
    
    // Initial RAM memory with S-box table, permutation layer table, key, state
    initial $readmemh("RAM_Memory.mem", RAM);

endmodule
