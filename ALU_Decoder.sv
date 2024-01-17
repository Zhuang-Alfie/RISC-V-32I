module ALU_Decoder(
    input [2:0] funct3,     // func3[2:0]
    input funct7,            // func7[5]
    input op5,
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
                        default : ALU_control = 3'bx;
                    endcase
            default : ALU_control = 3'bx;
        endcase
    end

endmodule

