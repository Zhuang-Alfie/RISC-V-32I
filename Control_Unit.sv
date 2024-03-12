`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// University: Dublin City University 
// Supervisor: Xiaojun Wang
// Student Name: Zhuang Miao 
// Module Name: Control_Unit
// Project Name: Implementation and Performance Analysis of the RSIC-V RV32I Architecture
// Description: This module contains and connects two sub-modules which are ALU decoder and main decoder.
//              It allocated the Instruction data to those two modules, generate result to further control
//              other modules such as ALU, PC_src etc base on the instruction.
//              More details of those modules can be seen in the their description
//////////////////////////////////////////////////////////////////////////////////

module Control_Unit(
    input [31:0] instr,
    input zero,
    
    output logic PC_src,
    output logic Reg_write,
    output logic [1:0] Imm_src,
    output logic ALU_src,
    output logic [2:0] ALU_control,
    output logic Mem_Write,
    output logic [1:0] Result_src
    );
    
    wire [1:0] ALU_op;
    wire branch;
    wire jump;
    
//    assign PC_src = (zero & branch) | jump;
    
    always_comb
        case(instr[14:12])
            3'b100 : PC_src = (!zero & branch) | jump;
            default : PC_src = (zero & branch) | jump;
        endcase
    
    ALU_Decoder alu_de (.funct3(instr[14:12]), .funct7(instr[30]), .op5(instr[5]), .ALU_op(ALU_op), .ALU_control(ALU_control));
    
    Main_Decoder main_de(.op(instr[6:0]), .Reg_write(Reg_write), .Imm_src(Imm_src), .ALU_src(ALU_src), .Mem_Write(Mem_Write), .Result_src(Result_src), .Branch(branch), .ALU_op(ALU_op), .Jump(jump));
    
endmodule
