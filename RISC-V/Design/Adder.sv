`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// University: Dublin City University 
// Supervisor: Xiaojun Wang
// Student Name: Zhuang Miao 
// Module Name: Adder
// Project Name: Implementation and Performance Analysis of the RSIC-V RV32I Architecture
// Description: adder is a circuit to perform the arithmetic addition of binary numbers
//////////////////////////////////////////////////////////////////////////////////

module Adder(
    input [31:0] operand_a,
    input [31:0] operand_b,
    
    output [31:0] result
    );
    
    assign result = operand_a + operand_b;
    
endmodule
