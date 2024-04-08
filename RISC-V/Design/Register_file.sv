`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// University: Dublin City University 
// Supervisor: Xiaojun Wang
// Student Name: Zhuang Miao 
// Module Name: Register_file
// Project Name: Implementation and Performance Analysis of the RSIC-V RV32I Architecture
// Description:  Register_file is the central hub for fast data storage and access during instruction execution
//////////////////////////////////////////////////////////////////////////////////

module Register_file(
   input [4:0] A1,      // address 1        - instr[19:15]
   input [4:0] A2,      // address 2        - instr[24:20]
   input [4:0] A3,      // write data input - instr[11:7]
   input [31:0] WD3,    // write data
   
   input clk,           // clock
   input WE3,           // write enabel
   
   output logic [31:0] RD1, // read data 1
   output logic [31:0] RD2  // read data 2
    );
    
    // register with 32 * 32-bit storage
    logic [31:0] register [31:0];

    //initial block with empry memory
    initial begin
        for (int i=0; i < 32; i++) begin
            register[i] = 'b0;
        end
    end    

    assign RD1 = register[A1];
    assign RD2 = register[A2];

    // write port for rd; Synchronous write, synchronous read.
    always_ff @(posedge clk) begin
        if (WE3)
            // prevent writting to saved address 0x00;
            if (A3 != 5'b0) register[A3] <= WD3;
    end
    
endmodule
