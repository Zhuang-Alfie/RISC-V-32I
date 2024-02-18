`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// University: Dublin City University 
// Supervisor: Xiaojun Wang
// Student Name: Zhuang Miao 
// Module Name: ALU
// Project Name: Implementation and Performance Analysis of the RSIC-V RV32I Architecture
// Description: Arithmetic Logic Unit (ALU)is responsible for carrying out operations such as addition, subtraction, 
//              logical operations (AND, OR, XOR, NOT), and shift operations, which are fundamental to the execution 
//              of various instruction types within the RISC-V RV32I architecture, including arithmetic, logical, 
//              control, and data transfer instructions
//////////////////////////////////////////////////////////////////////////////////


module ALU(
    input signed [31:0] srcA,
    input signed [31:0] srcB,
    input [2:0] ALUControl,
    
    output Zero,
    output logic [31:0] ALUResult
    );
    
    assign Zero = (ALUResult == 0);
    
     always_comb begin
        ALUResult = 32'b0;
        case (ALUControl)
                                                       // operations    - (RV32I Instructions)
            3'b000: ALUResult = srcA + srcB;           // add           - (lw, sw, add)
            3'b001: ALUResult = srcA - srcB;           // sub           - (beq, sub)
            3'b010: ALUResult = srcA & srcB;           // and           - (and)
            3'b011: ALUResult = srcA | srcB;           // or            - (or)
            3'b100: ALUResult = srcA << srcB[4:0];     // sll           - (sll)
            3'b110: ALUResult = srcA >> srcB[4:0];     // srl           - (srl)
            3'b101: ALUResult = {31'b0, srcA < srcB};  // bit operation - (slt)
            default: ALUResult = 32'b0;
        endcase
    end        
                
endmodule
