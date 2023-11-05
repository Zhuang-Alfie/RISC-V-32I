`timescale 1ns / 1ps

module MUX_2to1(
    input [31:0] PC_target,
    input [31:0] PC_plus4,
    input PC_src,
    
    output [31:0] PC_next
    );
    
    assign PC_next = PC_src? PC_plus4 : PC_target;
    
endmodule