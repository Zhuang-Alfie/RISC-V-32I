`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// University: Dublin City University 
// Supervisor: Xiaojun Wang
// Student Name: Zhuang Miao 
// Module Name: Top_tb
// Project Name: Implementation and Performance Analysis of the RSIC-V RV32I Architecture
// Description: This is top level testbench.
//////////////////////////////////////////////////////////////////////////////////

module Top_tb;
    reg clk;

    Top dut(.clk(clk));
    
    // Generate clock
    always #5 clk = !clk;
    
    initial begin
        // Initial clock to zero
        clk = 0;
        
        
        // Loding Instructions
        // Here are three test, uncomment one of then to use, same as sucess condiction in always block
//         $readmemh("loop_test.mem", dut.inst_memory.memory);
//         $readmemh("standard_test.mem", dut.inst_memory.memory);
        $readmemh("Present-80.mem", dut.inst_memory.memory);
        // Initial RAM memory with S-box, permutation layer table
        $readmemh("RAM_Memory.mem", dut.data_memory.RAM);
    end

    always @(negedge clk) begin
//        if(dut.reg_file.A3 === 16 & dut.reg_file.WD3 === 1) begin                     //loop_test success condiction
//        if(dut.data_memory.A[31:2] === 25 & dut.data_memory.WD === 25) begin          //standard_test success condiction
        if(dut.reg_file.register[11] === 32'h5579c138 & dut.reg_file.register[10] === 32'h7b228445) begin                     //loop_test success condiction
            $display("Simulation succeeded");
            #10 $finish;
        end
    end
endmodule