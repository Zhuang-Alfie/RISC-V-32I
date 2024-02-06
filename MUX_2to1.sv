`timescale 1ns / 1ps

module MUX_2to1(
    input [31:0]  A,
    input [31:0]  B,
    input select,
    
    output [31:0] out
    );
    
    assign out = select? B : A;
    
endmodule