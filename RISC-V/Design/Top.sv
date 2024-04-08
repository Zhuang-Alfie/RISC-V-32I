`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// University: Dublin City University 
// Supervisor: Xiaojun Wang
// Student Name: Zhuang Miao 
// Module Name: Top
// Project Name: Implementation and Performance Analysis of the RSIC-V RV32I Architecture
// Description: This module is the top level of all the modules.
//////////////////////////////////////////////////////////////////////////////////

(* DONT_TOUCH = "true|yes" *)   //Avoid synthesis optimizing circuit
module Top(
    (* keep = "true" *)input clk
);

    wire [31:0] instr;
    
    wire PC_src, Mem_Write, ALU_src, Reg_write, zero;
    wire [1:0] Imm_src, Result_src;
    wire [2:0] ALU_control;
    
    wire [31:0] Imm_ext, RD1, RD2, out, ALUResult, RD_DM, Result_mux3_1, result_PC_plus4, result_PC_target, out_mux2_1;

    reg [31:0] PC_next, PC;
    reg [31:0] constant_4;
    
    assign PC_next = out_mux2_1;
    
    // Flip-flop generate next PC
    always @(posedge clk)
            PC <= PC_next;
            
    initial begin
        constant_4 = 'b100;     // assign to constant = 4
        PC = 0;
    end

    (* DONT_TOUCH = "true|yes" *)MUX_2to1 mux2_1 (//Avoid synthesis optimizing circuit
        .A(result_PC_plus4),
        .B(result_PC_target),
        .select(PC_src),
        .out(out_mux2_1)
    );
    
    (* DONT_TOUCH = "true|yes" *)Instruction_Memory inst_memory(//Avoid synthesis optimizing circuit
        .A(PC),
        .RD(instr)
    );
    
    (* DONT_TOUCH = "true|yes" *)Adder PC_plus4 (//Avoid synthesis optimizing circuit
        .operand_a(PC),
        .operand_b(constant_4),
        .result(result_PC_plus4)
    );

    (* DONT_TOUCH = "true|yes" *)Register_file reg_file(//Avoid synthesis optimizing circuit
        .A1(instr[19:15]),
        .A2(instr[24:20]),
        .A3(instr[11:7]),
        .WD3(Result_mux3_1),
        .clk(clk),
        .WE3(Reg_write),
        .RD1(RD1),
        .RD2(RD2)
    );
    
    (* DONT_TOUCH = "true|yes" *)Control_Unit control_unit(//Avoid synthesis optimizing circuit
        .instr(instr),
        .zero(zero), 
        .PC_src(PC_src), 
        .Reg_write(Reg_write),
        .Imm_src(Imm_src),
        .ALU_src(ALU_src),
        .ALU_control(ALU_control),
        .Mem_Write(Mem_Write),
        .Result_src(Result_src)
    );
    
    (* DONT_TOUCH = "true|yes" *)Extend extend (//Avoid synthesis optimizing circuit
        .inst(instr),
        .Imm_src(Imm_src),
        .Imm_ext(Imm_ext)
    );
    
    (* DONT_TOUCH = "true|yes" *)MUX_2to1 mux2_2 (//Avoid synthesis optimizing circuit
        .A(RD2),
        .B(Imm_ext),
        .select(ALU_src),
        .out(out)
    );
    
    (* DONT_TOUCH = "true|yes" *)ALU alu (//Avoid synthesis optimizing circuit
        .srcA(RD1),
        .srcB(out),
        .ALUControl(ALU_control),
        .Zero(zero),
        .ALUResult(ALUResult)
    );
    
    (* DONT_TOUCH = "true|yes" *)Adder PC_target (//Avoid synthesis optimizing circuit
        .operand_a(Imm_ext),
        .operand_b(PC),
        .result(result_PC_target)
    );
    
    (* DONT_TOUCH = "true|yes" *)Data_memory data_memory (//Avoid synthesis optimizing circuit
        .A(ALUResult),
        .WD(RD2),
        .clk(clk),
        .WE(Mem_Write),
        .RD(RD_DM)
    );
    
    (* DONT_TOUCH = "true|yes" *)MUX_3to1 mux3_1 (//Avoid synthesis optimizing circuit
        .ALU_result(ALUResult),
        .Read_data(RD_DM),
        .PC_plus4(result_PC_plus4),
        .Result_src(Result_src),
        .Result(Result_mux3_1)
    );
    
    

endmodule
