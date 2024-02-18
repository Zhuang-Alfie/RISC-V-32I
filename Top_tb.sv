`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// University: Dublin City University 
// Supervisor: Xiaojun Wang
// Student Name: Zhuang Miao 
// Module Name: Top_tb
// Project Name: Implementation and Performance Analysis of the RSIC-V RV32I Architecture
// Description: This is top level testbench, there are three general tests.
//////////////////////////////////////////////////////////////////////////////////

module Top_tb;
    reg clk;

    Top dut(.clk(clk));
    
    // Generate clock
    always #10 clk = !clk;
    
    initial begin 
        clk = 0;    // Initial clock to zero
        
        // Upload SBox details into the RAM
        $readmemh("RAM_Memory.mem", dut.data_memory.RAM);
        
        // Loding Instructions to the register
        // Here are two test, uncomment one of then to use, same as sucess condiction
//        $readmemh("loop_test.mem", dut.inst_memory.memory);
        $readmemh("SimpleTest.mem", dut.inst_memory.memory);

        #1710 $finish;  // Force finishing test
    end

    always @(negedge clk) begin
//        if(dut.reg_file.A3 === 10 & dut.reg_file.WD3 === 7) begin                     //loop_test success condiction
//        if(dut.data_memory.A[31:2] === 25 & dut.data_memory.WD === 25) begin          //standard_test success condiction
//            $display("Simulation succeeded");
//            #10 $finish;
//        end
    end
endmodule
