`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// University: Dublin City University 
// Supervisor: Xiaojun Wang
// Student Name: Zhuang Miao 
// Module Name: Extend
// Project Name: Implementation and Performance Analysis of the RSIC-V RV32I Architecture
// Description: The immediate value extender is a key component in a RISC-V RV32I based 
//              single-cycle processor, ensuring that immediate values embedded within 
//              instructions are correctly sign-extended to 32 bits.
//////////////////////////////////////////////////////////////////////////////////

module Extend(
    input [31:0] inst,
    
    input [1:0] Imm_src,
    
    output logic [31:0] Imm_ext
    );
    
    always_comb begin
        Imm_ext = 32'b0;
        case(Imm_src)
            2'b00: Imm_ext = { {21{inst[31]}}, inst[31:20] };                                              // I
            2'b01: Imm_ext = { {21{inst[31]}}, inst[30:25], inst[11:7] };                                  // S
            2'b10: Imm_ext = { {20{inst[31]}}, inst[7], inst[30:25], inst[11:8], 1'b0 };                   // B
            2'b11: Imm_ext = { {12{inst[31]}}, inst[19:12], inst[20], inst[30:25], inst[24:21], 1'b0 };    // J
            default: Imm_ext = 32'b0;
        endcase
    end
    
endmodule
