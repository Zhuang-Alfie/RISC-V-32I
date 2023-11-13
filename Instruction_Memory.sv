`timescale 1ns / 1ps

module Instruction_Memory(
    input [31:0] A,         // 32-bit processor
    output logic [31:0] RD
    );
    
    logic [31:0] memory [63:0]; 
    
    
    assign RD = memory[A];
    
endmodule
