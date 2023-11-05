`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.11.2023 14:25:47
// Design Name: 
// Module Name: Extend
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


module Extend(
    input [31:0] inst,
    
    input [1:0] Imm_src,
    
    output logic [31:0] Imm_ext
    );
    
    // source : https://github.com/tilk/riscv-simple-sv/blob/master/core/common/immediate_generator.sv
    // Immediate format
    //       31.............30........20.19........12.11.....11.10.........5.4..........1.0.....0
    // I = { {21{inst[31]}},                                     inst[30:25], inst[24:20]         };
    // S = { {21{inst[31]}},                                     inst[30:25], inst[11:7]          };
    // B = { {20{inst[31]}}, inst[7],                            inst[30:25], inst[11:8],   1'b0  };
    // U = { {1{inst[31]}},  inst[30:20], inst[19:12],                                      12'b0 };
    // J = { {12{inst[31]}},              inst[19:12], inst[20], inst[30:25], inst[24:21],  1'b0  };
    
    always_comb begin
        Imm_ext = 32'b0;
        case(Imm_src)
            00: Imm_ext = { {21{inst[31]}}, inst[31:20] };                                              // I
            01: Imm_ext = { {21{inst[31]}}, inst[30:25], inst[11:7] };                                  // S
            10: Imm_ext = { {20{inst[31]}}, inst[7], inst[30:25], inst[11:8], 1'b0 };                   // B
            11: Imm_ext = { {12{inst[31]}}, inst[19:12], inst[20], inst[30:25], inst[24:21], 1'b0 };    // J
            default: Imm_ext = 32'b0;
        endcase
    end
    
endmodule
