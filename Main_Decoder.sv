`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// University: Dublin City University 
// Supervisor: Xiaojun Wang
// Student Name: Zhuang Miao 
// Module Name: Main_Decoder
// Project Name: Implementation and Performance Analysis of the RSIC-V RV32I Architecture
// Description: This component is essential for the functioning of the processor, as it 
//              translates the binary instruction codes into a set of actionable commands 
//              that control the data path and the operation of the processor's various 
//              elements, such as the ALU, multiplexers, register file, and memory access units.
//////////////////////////////////////////////////////////////////////////////////


module Main_Decoder(
    input [6:0] op,
    
    output logic Reg_write,
    output logic [1:0] Imm_src,
    output logic ALU_src,
    output logic Mem_Write,
    output logic [1:0] Result_src,
    output logic Branch,
    output logic [1:0] ALU_op,
    output logic Jump
    );
    
    always_comb begin
        case(op)
            7'b0000011 : {Reg_write,Imm_src,ALU_src,Mem_Write,Result_src,Branch,ALU_op,Jump} = 11'b1_00_1_0_01_0_00_0;      // lw
            7'b0100011 : {Reg_write,Imm_src,ALU_src,Mem_Write,Result_src,Branch,ALU_op,Jump} = 11'b0_01_1_1_xx_0_00_0;      // sw
            7'b0110011 : {Reg_write,Imm_src,ALU_src,Mem_Write,Result_src,Branch,ALU_op,Jump} = 11'b1_xx_0_0_00_0_10_0;      // R-type
            7'b1100011 : {Reg_write,Imm_src,ALU_src,Mem_Write,Result_src,Branch,ALU_op,Jump} = 11'b0_10_0_0_xx_1_01_0;      // beq
            7'b0010011 : {Reg_write,Imm_src,ALU_src,Mem_Write,Result_src,Branch,ALU_op,Jump} = 11'b1_00_1_0_00_0_10_0;      // I-type ALU
            7'b1101111 : {Reg_write,Imm_src,ALU_src,Mem_Write,Result_src,Branch,ALU_op,Jump} = 11'b1_11_x_0_10_0_xx_1;      // jal
            default : {Reg_write,Imm_src,ALU_src,Mem_Write,Result_src,Branch,ALU_op,Jump} = 11'bx;
        endcase
    end
    
endmodule
