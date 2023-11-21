module Top;

    wire [31:0] instr;
    
    wire PC_src, Mem_Write, ALU_src, Reg_write, zero;
    wire [1:0] Imm_src, Result_src;
    wire [2:0] ALU_control;
    
    wire [31:0] Imm_ext, RD1, RD2, out, ALUResult, RD_DM, Result_mux3_1, result_PC_plus4, result_PC_target, out_mux2_1;

    reg clk;
    reg [31:0] PC_next, PC;
    reg [31:0] constant_4;
    
    always  #5 clk = ~clk;
    assign PC_next = out_mux2_1;
    
    // Flip-flop generate next PC
    always @(posedge clk)
        PC <= PC_next;
    
    initial begin
        constant_4 = 'b100;     // assign to constant 4
        clk = 0;        // initial clock
        PC = 0;
    end

    MUX_2to1 mux2_1 (
        .A(result_PC_plus4),        // 32-bit
        .B(result_PC_target),       // 32-bit
        .select(PC_src),
        .out(out_mux2_1)               // 32-bit
    );
    
    Instruction_Memory inst_memory(
        .A(PC),             // 32-bit
        .RD(instr)          // 32-bit
    );
    
    Adder PC_plus4 (
        .operand_a(PC),
        .operand_b(constant_4),
        .result(result_PC_plus4)
    );

    Register_file reg_file(
        .A1(instr[19:15]),
        .A2(instr[24:20]),
        .A3(instr[11:7]),
        .WD3(Result_mux3_1),
        .clk(clk),
        .WE3(Reg_write),
        .RD1(RD1),
        .RD2(RD2)
    );
    
    Control_Unit control_unit(
        .instr(instr),              // 32-bit
        .zero(zero), 
        .PC_src(PC_src), 
        .Reg_write(Reg_write),
        .Imm_src(Imm_src),          // 2-bit
        .ALU_src(ALU_src),
        .ALU_control(ALU_control),  // 3-bit
        .Mem_Write(Mem_Write),
        .Result_src(Result_src)     // 2-bit
    );
    
    Extend extend (
        .inst(instr),
        .Imm_src(Imm_src),
        .Imm_ext(Imm_ext)
    );
    
    MUX_2to1 mux2_2 (
        .A(RD2),            // 32-bit
        .B(Imm_ext),        // 32-bit
        .select(ALU_src),
        .out(out)           // 32-bit
    );
    
    ALU alu (
        .srcA(RD1),
        .srcB(out),
        .ALUControl(ALU_control),
        .Zero(zero),
        .ALUResult(ALUResult)
    );
    
    Adder PC_target (
        .operand_a(Imm_ext),
        .operand_b(PC),
        .result(result_PC_target)
    );
    
    Data_memory data_memory (
        .A(ALUResult),
        .WD(RD2),
        .clk(clk),
        .WE(Mem_Write),
        .RD(RD_DM)
    );
    
    MUX_3to1 mux3_1 (
        .ALU_result(ALUResult),
        .Read_data(RD_DM),
        .PC_plus4(result_PC_plus4),
        .Result_src(Result_src),
        .Result(Result_mux3_1)
    );
    
    

endmodule