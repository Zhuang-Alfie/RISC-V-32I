`timescale 1ns / 1ps

module Adder(
    input [31:0] operand_a,
    input [31:0] operand_b,
    
    output [31:0] result
    );
    
    assign result = operand_a + operand_b;
    
endmodule