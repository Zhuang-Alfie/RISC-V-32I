`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// University: Dublin City University 
// Supervisor: Xiaojun Wang
// Student Name: Zhuang Miao 
// Module Name: MUX_3to1
// Project Name: Implementation and Performance Analysis of the RSIC-V RV32I Architecture
// Description: multiplexer (mux) 3-to-1 is a digital switch that allows one of three input signals to
//               be selected and forwarded to the output, based on the value of a control signal.
//////////////////////////////////////////////////////////////////////////////////

module MUX_3to1(
    input [31:0] ALU_result,    // Input 1
    input [31:0] Read_data,     // Input 2
    input [31:0] PC_plus4,      // Input 3
    input [1:0] Result_src,     // Control signal
    
    output logic [31:0] Result  // Output
    );
    
    always_comb begin
        case(Result_src)
            2'b00 : Result = ALU_result;
            2'b01 : Result = Read_data;
            2'b10 : Result = PC_plus4;
            default : Result = 32'bx;
        endcase
    end          
endmodule