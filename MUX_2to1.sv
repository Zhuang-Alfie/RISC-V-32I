`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// University: Dublin City University 
// Supervisor: Xiaojun Wang
// Student Name: Zhuang Miao 
// Module Name: MUX_2to1
// Project Name: Implementation and Performance Analysis of the RSIC-V RV32I Architecture
// Description: multiplexer (mux) 2-to-1 is a digital switch that allows one of two input signals to
//               be selected and forwarded to the output, based on the value of a control signal.
//////////////////////////////////////////////////////////////////////////////////

module MUX_2to1(
    input [31:0]  A,    // input data A
    input [31:0]  B,    // input data B
    input select,       // control signal
    
    output [31:0] out   // output data
    );
    
    assign out = select? B : A;
    
endmodule