`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// University: Dublin City University 
// Supervisor: Xiaojun Wang
// Student Name: Zhuang Miao 
// Module Name: Main_Decoder
// Project Name: Implementation and Performance Analysis of the RSIC-V RV32I Architecture
// Description: This is a KeySchedule design, generate key at every clock cycle
//////////////////////////////////////////////////////////////////////////////////


module KeySchedule(
    input logic clk,                // Clock signal
    input logic rstn,               // Asynchronous reset
    input logic [79:0] key,         // 80-bit master key input
    output logic [63:0] round_key  // 64-bit round key output
);

    reg [79:0] key_reg, key_shift, key_new; // Registers to hold the different key states
    reg [4:0] round_counter, xor_result;    // Round counter, xor result
    wire [3:0] sbox_out;                    // Output from the S-box module
    
    // Instantiate the S-box module
    Sbox sbox(
        .in(key_shift[79:76]),      // Connect the highest 4 bits of the key to the S-box input
        .out(sbox_out)              // Connect the S-box output
    );
    
    assign key_shift = {key_reg[18:0], key_reg[79:19]};                     // shift 60 bit to right
    assign xor_result = key_shift[19:15] ^ round_counter;                   // xor with counter
    assign key_new = {sbox_out,key_shift[75:20],xor_result,key_shift[14:0]};// merge different parts to new state
    assign round_key = key_reg[79:16];                                      // assign key_reg to output                                   
    
    
    // Key schedule operation
    always @(posedge clk or negedge rstn) begin
        if (!rstn) begin
            key_reg <= key; // Load the master key on reset
            round_counter <= 1;    // Reset the round counter
        end else begin
            // Assign key_reg to new key
            key_reg <= key_new;
            
            // Increment the round counter
            round_counter <= round_counter + 1'b1;
        end
    end

endmodule

