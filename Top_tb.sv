`timescale 1ns / 1ps

module Top_tb;

    reg clk;

    Top dut(.clk(clk));
    
    always #10 clk = !clk;
    
    initial begin 
        clk = 0;    // Initial clock to zero
        
        // Loding Instructions to the register
        // Here are two test, uncomment one of then to use, same as sucess condiction
//        $readmemh("loop_test.mem", dut.inst_memory.memory);
        $readmemh("standard_test.mem", dut.inst_memory.memory);

        #8000 $finish;  // Force finish testing
    end

    always @(negedge clk) begin
//        if(dut.reg_file.A3 === 10 & dut.reg_file.WD3 === 7) begin                 //loop_test success condiction
        if(dut.data_memory.A[31:2] === 25 & dut.data_memory.WD === 25) begin        //standard_test success condiction
            $display("Simulation succeeded");
            #10 $finish;
        end
    end

endmodule
