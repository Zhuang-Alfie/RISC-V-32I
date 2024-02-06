`timescale 1ns / 1ps

module BL_tb;

    reg [31:0] A;
    reg [31:0] B;
    reg select;
    reg [31:0] out;
    MUX_2to1 mux2_1 (
        .A(A),      // 32-bit
        .B(B),      // 32-bit
        .select(select),
        .out(out)   // 32-bit
    );
    
    reg [31:0] A;
    reg [31:0] RD;
    Instruction_Memory inst_memory(
        .A(A),       // 32-bit
        .RD(RD)       // 32-bit
    );
    
    reg [31:0] operand_a;
    reg [31:0] operand_b;
    reg [31:0] result;
    Adder adder1(
        .operand_a(operand_a),
        .operand_b(operand_b),
        .result(result)
    );
    
    
    reg [31:0] A;
    reg [31:0] B;
    reg [31:0] A;
    reg [31:0] B;
    reg [31:0] A;
    reg [31:0] B;
    reg [31:0] A;
    reg [31:0] B;
    reg [31:0] A;
    reg [31:0] B;
    Register_file reg_file(
        .A1(),
        .A2(),
        .A3(),
        .WD3(),
        .clk(),
        .WE3(),
        .RD1(),
        .RD2()
    );
    
    Control_Unit control_unit(
        .instr(),       // 32-bit
        .zero(), 
        .PC_src(), 
        .Reg_write(),
        .Imm_src(),     // 2-bit
        .ALU_src(),
        .ALU_control(), // 3-bit
        .Mem_Write(),
        .Result_src()   // 2-bit
    );
    
    Extend extend (
        .inst(),
        .Imm_src(),
        .Imm_ext()
    );
    
    MUX_2to1 mux2_2 (
        .A(),   // 32-bit
        .B(),    // 32-bit
        .select(),
        .out()      // 32-bit
    );
    
    ALU alu (
        .srcA(),
        .srcB(),
        .ALUControl(),
        .Zero(),
        .ALUResult()
    );
    
    Adder adder2 (
        .operand_a(),
        .operand_b(),
        .result()
    );
    
    Data_memory data_memory (
        .A(),
        .WD(),
        .clk(),
        .WE(),
        .RD()
    );
    
    MUX_3to1 mux3_1 (
        .ALU_result(),
        .Read_data(),
        .PC_plus4(),
        .Result_src(),
        .Result()
    );
    
    

endmodule
