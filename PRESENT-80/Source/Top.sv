`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// University: Dublin City University 
// Supervisor: Xiaojun Wang
// Student Name: Zhuang Miao 
// Module Name: Main_Decoder
// Project Name: Implementation and Performance Analysis of the RSIC-V RV32I Architecture
// Description: This is a Testbench for top-level design
//////////////////////////////////////////////////////////////////////////////////


module Top;

    logic clk;
    logic rstn;
    logic [79:0] key;
    logic [63:0] plaintext, ciphertext;
    
    PRESENT80Cipher cipher(
        .clk(clk),
        .rstn(rstn),
        .key(key),
        .plaintext(plaintext),
        .ciphertext(ciphertext)    
    );

    always #5 clk = ~clk;
    
    initial begin
        // Test 1(expect ciphertext: 64'h3333DCD3_213210D2)
        plaintext <= 64'hFFFF_FFFF_FFFF_FFFF;
        key <= 80'hFFFF_FFFF_FFFF_FFFF_FFFF;
        // Test 2(expect ciphertext: 64'h5579C138_7B228445)
//        plaintext <= 64'h0000_0000_0000_0000;
//        key <= 80'h0000_0000_0000_0000_0000;
        clk <= 0;
        rstn <= 0;
        
        #10 rstn <= 1;
    end
    
    always @(cipher.ks.round_counter)
        if (cipher.ks.round_counter == 1'b0)    // Finish simulation when counter is 0
            #10 $finish;
        

endmodule
