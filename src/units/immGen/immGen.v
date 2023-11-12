module immGen(
    input [3:0]    immSel,
    input [24:0]   instr,
    output reg [31:0]  immediate
);

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
        // 1 -> I-Type, [24:13]
        4'd1:   begin
                    immediate[11] <= instr[24];
                    immediate[10:5]  <= instr[23:18];
                    immediate[4:1]   <= instr[17:14];
                    immediate[0]     <= instr[13];
                end
        // 2 -> S Type, [24:18] [4:0]
        4'd2:   begin
                    immediate[31:11] <= instr[24];
                    immediate[10:5]  <= instr[23:18];
                    immediate[4:1]   <= instr[4:1];
                    immediate[0]     <= instr[0];
                end
        // 3 -> B Type, [24:23] [22:18] [4:1] [0]
        4'd3:   begin
                    immediate[31:12] <= instr[24];
                    immediate[11]    <= instr[0];
                    immediate[10:5]  <= instr[23:18];
                    immediate[4:1]   <= instr[4:1];
                    immediate[0]     <= 1'b0;
                end
        // 4 -> U Type, [24:5]
        4'd4:   begin
                    immediate[31]    <= instr[24];
                    immediate[30:20] <= instr[23:13];
                    immediate[19:12] <= instr[12:5];
                    immediate[11:0]  <= 12'b0;
                end
        // 5 -> J Type, [24:5]
        4'd5:   begin
                    immediate[31:20] <= instr[24];
                    immediate[19:12] <= instr[12:5];
                    immediate[11]    <= instr[13];
                    immediate[10:5]  <= instr[23:18];
                    immediate[4:1]   <= instr[17:14];
                    immediate[0]     <= 1'b0;
                end 
        endcase
    end
    assign immediate = immediate;
endmodule
