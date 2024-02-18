`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// University: Dublin City University 
// Supervisor: Xiaojun Wang
// Student Name: Zhuang Miao 
// Module Name: ALU_Decoder
// Project Name: Implementation and Performance Analysis of the RSIC-V RV32I Architecture
// Description: The ALU Decoder is a critical component in a RISC-V RV32I based single-cycle 
//              processor, enabling the flexible and dynamic operation of the ALU by translating 
//              instruction codes into specific ALU control signals.
//////////////////////////////////////////////////////////////////////////////////

module ALU_Decoder(
    input [2:0] funct3,         // from instr[14:12]
    input funct7,               // from instr[30]
    input op5,                  // from instr[5]
    input [1:0] ALU_op,
    
    output logic [2:0] ALU_control
    );
    
    always_comb begin
        case(ALU_op)
            2'b00 : ALU_control = 3'b000;       // lw, sw
            2'b01 : ALU_control = 3'b001;       // beq
            2'b10 : case(funct3)
                        3'b000 : case({op5,funct7})
                                    2'b00, 2'b01, 2'b10 : ALU_control = 3'b000;     // add
                                    2'b11 : ALU_control = 3'b001;                   // sub
                                    default : ALU_control = 3'bx;
                                 endcase
                        3'b010 : ALU_control = 3'b101;          // slt
                        3'b110 : ALU_control = 3'b011;          // or
                        3'b111 : ALU_control = 3'b010;          // and
                        3'b101 : ALU_control = 3'b110;          // srl
                        3'b001 : ALU_control = 3'b100;          // sll
                        default : ALU_control = 3'bx;
                    endcase
            default : ALU_control = 3'bx;
        endcase
    end

endmodule
