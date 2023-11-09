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
            4'b1001: result = i_1 ^ i_2;
            4'b0010: result = i_1 + i_2;
            4'b0011: result = i_1 - i_2;
            // Less than Unsigned
            4'b0100: begin
                        if (i_1 < i_2) 
                            result = 1'b1;
                        else 
                            result = 1'b0;
                     end
            4'b1011: begin
                        if ($signed(i_1) < $signed(i_2))
                            result = 1'b1;
                        else 
                            result = 1'b0;
                     end
            // Pass Input 2
            4'b0101: result = i_2;
            // Shift Immediate 12 bytes and add
            4'b0111: result <= ((i_2 <<< 12) + i_1);
            4'b1000: result <= (i_1 <<< i_2[4:0]);
            4'b1100: result <= (i_1 >>> i_2[4:0]);
            4'b1101: result <= (5'b10000 + (i_1 >>> i_2[3:0]);
        endcase

        if (result == 0 )
            zero_flag = 1'b1;
        else
            zero_flag = 1'b0;
    end
endmodule
