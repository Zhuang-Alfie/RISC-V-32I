module MUX_3to1(
    input [31:0] ALU_result,
    input [31:0] Read_data,
    input [31:0] PC_plus4,
    input [1:0] Result_src,
    
    output logic [31:0] Result
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