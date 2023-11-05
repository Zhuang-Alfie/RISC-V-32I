`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.11.2023 12:55:47
// Design Name: 
// Module Name: Register_file
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


module Register_file(
   input [4:0] A1,      // address 1 - instr[19:15]
   input [4:0] A2,      // address 2 - instr[24:20]
   input [4:0] A3,      // write data input - instr[11:7]
   input [31:0] WD3,
   
   input clk,
   input WE3,
   
   output logic [31:0] RD1,
   output logic [31:0] RD2
    );
    
    // register with 32 * 32-bit storage
    logic [31:0] register [0:31];
    
    // assign result from register
    assign RD1 = register[A1];
    assign RD2 = register[A2];
    
    // TODO : Question 1
    // register x0 is ZERO
    assign register[0] = 32'b0;
//    initial register[0] = 32'b0;

    // write port for rd
    always_ff @(posedge clk)
        if (WE3)
            if (A3 != 5'b0) register[A3] <= WD3;
    
endmodule
