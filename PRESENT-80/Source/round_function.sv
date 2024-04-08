`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.02.2024 17:10:24
// Design Name: 
// Module Name: round_function
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module round_function(
    input logic [63:0] state,
    input logic [63:0] round_key,
    output logic [63:0] new_state
);
    logic [63:0] state_after_sbox;
    logic [63:0] state_after_p_layer;

    // Apply S-Box substitution to each 4-bit chunk of the input state
    Sbox_64 sbox_64(
        .in(state),
        .out(state_after_sbox)
    );

    // Apply permutation layer
    pLayer p_layer_inst(
        .in(state_after_sbox),
        .out(state_after_p_layer)
    );

    // Key addition
    always_comb begin
        new_state = state_after_p_layer ^ round_key; // XOR with the round key
    end

endmodule

