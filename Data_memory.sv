module Data_memory(
    input [31:0] A,
    input [31:0] WD,
    input clk,
    input WE,
    output logic [31:0] RD 
    );
    
    logic [31:0] RAM [100:0];
    
    assign RD = RAM[A[31:2]];
    
    //Synchronous write, synchronous read
    always_ff @(posedge clk) begin
        if(WE) RAM[A[31:2]] <= WD;
    end
    
    // Initial block with empty memory    
    initial begin
        for (int i=0; i < 101; i++)
            RAM[i] <= 0;
    end

endmodule
