`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.11.2023 16:35:18
// Design Name: 
// Module Name: ALU
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
            3'b000: ALUResult = srcA + srcB;           // add - (lw, sw, add)
            3'b001: ALUResult = srcA - srcB;           // sub - (beq, sub)
            3'b010: ALUResult = srcA & srcB;           // and - (and)
            3'b011: ALUResult = srcA | srcB;           // or - (or)
            3'b101: ALUResult = {31'b0, srcA < srcB};  // set less than - (slt)
            default: ALUResult = 32'b0;
        endcase
    end        
                
endmodule
