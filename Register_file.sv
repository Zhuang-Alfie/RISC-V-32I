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

    // initial block with empry memory
    initial begin
        for (int i=0; i < 32; i++)
            register[i] = 'b0;
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
