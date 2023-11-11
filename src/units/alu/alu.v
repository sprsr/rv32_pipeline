module alu ( 
    input      [31:0] i_1,
    input      [31:0] i_2,
    input      [3:0]  aluSel,
    output reg [31:0] result,
    output reg        zero_flag
);

    function [31:0] shift(input [31:0] fi_val, fi_op);
        begin
            case fi_pp
                0: shift = fi_val;
                1: shift = fi_val  
                2: shift = 

                    

        end

    always @(*) begin
        case(aluSel)
            4'b0000: result = i_1 & i_2;
            4'b0001: result = i_1 | i_2;
            4'b0010: result = i_1 ^ i_2;
            4'b0011: result = i_1 + i_2;
            4'b0100: result = i_1 - i_2;
            // Less than
            4'b0101: begin
                        if (i_1 < i_2) 
                            result = 1'b1;
                        else 
                            result = 1'b0;
                     end
            // Pass Input 2
            4'b0110: result = i_2;
            // Shift Left Logical
            4'b0111: result <= (i_1 << i_2[4:0]);
            // Shift Right Logical
            4'b1000: result <= (i_1 >> i_2[4:0]);
            // Shift Left Arithmetic
            4'b1001: result <= (i_1 >>> i_2[4:0]);
            // Shift Right Arithmetic
            4'b1010: result <= (i_1 <<< i_2[4:0]);
        endcase

        if (result == 0 )
            zero_flag = 1'b1;
        else
            zero_flag = 1'b0;
    end
endmodule
