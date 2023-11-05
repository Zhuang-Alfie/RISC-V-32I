`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.11.2023 15:59:30
// Design Name: 
// Module Name: ALU_Decoder
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


module ALU_Decoder(
    input [2:0] funct3,     // func3[2:0]
    input funct7,            // func7[5]
    input [6:0] op,
    input [1:0] ALU_op,
    
    output logic [2:0] ALU_control
    );
    
     logic [2:0] middle0;
     logic [2:0] middle1;
    
    always_comb begin
        case(ALU_op)
            2'b00 : ALU_control = 3'b000;       // lw, sw
            2'b01 : ALU_control = 3'b001;       // beq
            2'b10 : ALU_control = middle0;
            default : ALU_control = 3'bx;
        endcase
    end
    
    always_comb begin
        case(funct3)
            3'b000 : middle0 = middle1;
            3'b010 : middle0 = 3'b101;          // slt
            3'b110 : middle0 = 3'b011;          // or
            3'b111 : middle0 = 3'b010;          // and
            default : middle0 = 3'bx;
        endcase
    end
    
    always_comb begin
        case({op[5],funct3})
            2'b00 : middle1 = 3'b000;           // and
            2'b01 : middle1 = 3'b000;           // and
            2'b10 : middle1 = 3'b000;           // and
            2'b11 : middle1 = 3'b001;           // sub
            default : middle1 = 3'bx;
        endcase
    end

endmodule
