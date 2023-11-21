`timescale 1ns / 1ps

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
    logic [31:0] register [31:0];
    
    // assign result from register
    assign RD1 = register[A1];
    assign RD2 = register[A2];

    initial begin
        for (int i=0; i < 32; i++)
            register[i] = 'b0;
    end    

    // write port for rd
    always_ff @(posedge clk)
        if (WE3)
            // Prevent modefing Address 0
            if (A3 != 5'b0) register[A3] <= WD3;
    
endmodule
