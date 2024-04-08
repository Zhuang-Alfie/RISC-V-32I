`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// University: Dublin City University 
// Supervisor: Xiaojun Wang
// Student Name: Zhuang Miao 
// Module Name: Main_Decoder
// Project Name: Implementation and Performance Analysis of the RSIC-V RV32I Architecture
// Description: This is top level design of PRESENT-80 
//////////////////////////////////////////////////////////////////////////////////


module PRESENT80Cipher(
    input logic clk,                // clock
    input logic rstn,               // reset (negative)
    input logic [79:0] key,         // key
    input logic [63:0] plaintext,   // plaintext/state
    output logic [63:0] ciphertext  // ciphertext
    );

    logic [79:0] key_reg;
    logic [63:0] sbox_result, round_key, xor_result, state, state_new;

    assign xor_result = round_key ^ state;      // xor layer
    assign ciphertext = xor_result;

    Sbox_64 sbox_64(                            // S-box layer
        .in(xor_result),
        .out(sbox_result)
    );

    pLayer pl(                                  // Permutation layer
        .in(sbox_result),
        .out(state_new)
    );

    KeySchedule ks(                             // Addroundkey
        .clk(clk),
        .rstn(rstn),
        .key(key_reg),
        .round_key(round_key)
    );
    
    always @(posedge clk or negedge rstn) begin
        if (!rstn) begin
            key_reg <= key;
            state <= plaintext;
        end else begin
            state <= state_new;
        end
    end

endmodule
