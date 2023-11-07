module alu ( 
    input      [31:0] i_1,
    input      [31:0] i_2,
    input      [3:0]  aluSel,
    output reg [31:0] result,
    output reg        zero_flag
);

    always @(*) begin
    
        case(aluSel)
            4'b0000: result = i_1 & i_2;
            4'b0001: result = i_1 | i_2;
            4'b0010: result = i_1 + i_2;
            4'b0100: result = i_1 - i_2;
            4'b1000: begin
                        if (i_1 < i_2) 
                            result = 1'b1;
                        else 
                            result = 1'b0;
                     end
            4'b1001: result = i_2;
        endcase

        if (result == 0 )
            zero_flag = 1'b1;
        else
            zero_flag = 1'b0;
    end
endmodule
