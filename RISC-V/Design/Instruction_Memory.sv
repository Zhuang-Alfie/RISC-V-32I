`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// University: Dublin City University 
// Supervisor: Xiaojun Wang
// Student Name: Zhuang Miao 
// Module Name: Instruction_Memory
// Project Name: Implementation and Performance Analysis of the RSIC-V RV32I Architecture
// Description: Instruction Memory is responsible for holding the binary instructions that make up a program. 
//                          When the processor is running a program, it sequentially reads instructions from this memory
//////////////////////////////////////////////////////////////////////////////////

module Instruction_Memory(
    input [31:0] A,             // 32-bit address
    output logic [31:0] RD      // 32-bit binary instruction
    );
    
    logic [31:0] memory [100:0];
    
    // Resize A to satisfiy when the address is increasing by "1"
    // Last two bits of word address are always zero. Because RISC-V byte addressable.
    assign RD = memory[A[31:2]];
    
    initial $readmemh("SimpleTest.mem", memory);
    
endmodule
