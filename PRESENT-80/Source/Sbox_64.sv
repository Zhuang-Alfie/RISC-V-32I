`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// University: Dublin City University 
// Supervisor: Xiaojun Wang
// Student Name: Zhuang Miao 
// Module Name: Main_Decoder
// Project Name: Implementation and Performance Analysis of the RSIC-V RV32I Architecture
// Description: This is a Sbox design with 64 bit input
//////////////////////////////////////////////////////////////////////////////////


module Sbox_64(
    input logic [63:0] in,
    output logic [63:0] out
    );
    Sbox sbox_1(.in(in[3:0]), .out(out[3:0]));
    Sbox sbox_2(.in(in[7:4]), .out(out[7:4]));
    Sbox sbox_3(.in(in[11:8]), .out(out[11:8]));
    Sbox sbox_4(.in(in[15:12]), .out(out[15:12]));
    Sbox sbox_5(.in(in[19:16]), .out(out[19:16]));
    Sbox sbox_6(.in(in[23:20]), .out(out[23:20]));
    Sbox sbox_7(.in(in[27:24]), .out(out[27:24]));
    Sbox sbox_8(.in(in[31:28]), .out(out[31:28]));
    Sbox sbox_9(.in(in[35:32]), .out(out[35:32]));
    Sbox sbox_10(.in(in[39:36]), .out(out[39:36]));
    Sbox sbox_11(.in(in[43:40]), .out(out[43:40]));
    Sbox sbox_12(.in(in[47:44]), .out(out[47:44]));
    Sbox sbox_13(.in(in[51:48]), .out(out[51:48]));
    Sbox sbox_14(.in(in[55:52]), .out(out[55:52]));
    Sbox sbox_15(.in(in[59:56]), .out(out[59:56]));
    Sbox sbox_16(.in(in[63:60]), .out(out[63:60]));
endmodule
