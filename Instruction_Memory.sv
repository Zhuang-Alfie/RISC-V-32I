`timescale 1ns / 1ps

module Instruction_Memory(
    input [31:0] A,         // 32-bit processor
    output logic [31:0] RD
    );
    
    logic [31:0] memory [63:0]; 
    
    // Resize A to satisfiy increase by 1 (original by 4)
    assign RD = memory[A[31:2]];
    
    initial begin
        for (int i=0; i < 64; i++)
            memory[i] = 0;
        $readmemh("risctest.mem", memory);
    end
    
endmodule
