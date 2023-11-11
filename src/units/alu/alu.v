module alu ( 
    input      [31:0] i_1,
    input      [31:0] i_2,
    input      [3:0]  aluSel,
    input             sign,
    input             shift,
    output     [31:0] result,
    output reg        zero_flag
);

    reg [31:0] r_operand_1;
    reg [31:0] r_operand_2;

    function [31:0] sign_op;
        input [31:0] fi_val;
        input fi_op;
            if (fi_op == 1'b1) begin
                sign_op <= $signed(fi_val);
            end else begin
                sign_op <= $unsigned(fi_val);
            end
    endfunction


    always @(*) begin
       r_operand_1 = sign_op(i_1,sign);
       r_operand_2 = sign_op(i_2,sign);
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
