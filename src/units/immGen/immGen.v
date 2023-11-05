module immGen(
    input [3:0]    immSel,
    input [24:0]   instr,
    output [31:0]  immediate
);

    wire [31:0] w_immediate;
    always @(*) begin
        // immSel:
        // 0 -> R-Type, No immediate
        // 1 -> I-Type, [24:13]
        // 2 -> S Type, [24:18] [4:0]
        // 3 -> B Type, [24:23] [22:18] [4:1] [0]
        // 4 -> U Type, [24:5]
        // 5 -> J Type, [24:5]
        case (immSel) 
        // 0 -> R-Type, No Immediate
        4'd0:   w_immediate <= 0;
        // 1 -> I-Type, [24:13]
        4'd1:   begin
                    w_immediate[31:11] <= instr[24];
                    w_immediate[10:5]  <= instr[23:18];
                    w_immediate[4:1]   <= instr[17:14];
                    w_immediate[0]     <= instr[13];
                end
        // 2 -> S Type, [24:18] [4:0]
        4'd2:   begin
                    w_immediate[31:11] <= instr[24];
                    w_immediate[10:5]  <= instr[23:18];
                    w_immediate[4:1]   <= instr[4:1];
                    w_immediate[0]     <= instr[0];
                end
        // 3 -> B Type, [24:23] [22:18] [4:1] [0]
        4'd3:   begin
                    w_immediate[31:12] <= instr[24];
                    w_immediate[11]    <= instr[0];
                    w_immediate[10:5]  <= instr[23:18];
                    w_immediate[4:1]   <= instr[4:1];
                    w_immediate[0]     <= 1'b0;
                end
        // 4 -> U Type, [24:5]
        4'd4:   begin
                    w_immediate[31]    <= instr[24];
                    w_immediate[30:20] <= instr[23:13];
                    w_immediate[19:12] <= instr[12:5];
                    w_immediate[11:0]  <= 12'b0;
                end
        // 5 -> J Type, [24:5]
        4'd5:   begin
                    w_immediate[31:20] <= instr[24];
                    w_immediate[19:12] <= instr[12:5];
                    w_immediate[11]    <= instr[13];
                    w_immediate[10:5]  <= instr[23:18];
                    w_immediate[4:1]   <= instr[17:14];
                    w_immediate[0]     <= 1'b0;
                end 
        endcase
    end
    assign immediate = w_immediate;
endmodule
