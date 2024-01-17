`timescale 1ns / 1ps

module Top_tb;

    reg clk;

    Top dut(.clk(clk));
    
    always #10 clk = !clk;
    
    initial begin 
        clk = 0;
        #8000 $finish;
    end
    

endmodule