`timescale 1ns / 1ps

// structure in Reference/Enhence_control_unit(jal).png

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
    
    assign PC_src = (zero & branch) | jump;
    
    ALU_Decoder alu_de (.funct3(instr[14:12]), .funct7(instr[30]), .op(instr[6:0]), .ALU_op(ALU_op), .ALU_control(ALU_control));
    
    Main_Decoder main_de(.op5(instr[5]), .Reg_write(Reg_write), .Imm_src(Imm_src), .ALU_src(ALU_src), .Mem_Write(Mem_Write), .Result_src(Result_src), .Branch(branch), .ALU_op(ALU_op), .Jump(jump));
    
endmodule
