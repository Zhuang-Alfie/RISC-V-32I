`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// University: Dublin City University 
// Supervisor: Xiaojun Wang
// Student Name: Zhuang Miao 
// Module Name: Main_Decoder
// Project Name: Implementation and Performance Analysis of the RSIC-V RV32I Architecture
// Description: This is a Sbox design with 4 bit input
//////////////////////////////////////////////////////////////////////////////////


module Sbox(
    input logic [3:0] in,
    output logic [3:0] out
    );
    
    always_comb begin
        case(in)
            4'h0: out = 4'hC;
            4'h1: out = 4'h5;
            4'h2: out = 4'h6;
            4'h3: out = 4'hB;
            4'h4: out = 4'h9;
            4'h5: out = 4'h0;
            4'h6: out = 4'hA;
            4'h7: out = 4'hD;
            4'h8: out = 4'h3;
            4'h9: out = 4'hE;
            4'hA: out = 4'hF;
            4'hB: out = 4'h8;
            4'hC: out = 4'h4;
            4'hD: out = 4'h7;
            4'hE: out = 4'h1;
            4'hF: out = 4'h2;
            default: out = 4'hx;
        endcase
    end
endmodule