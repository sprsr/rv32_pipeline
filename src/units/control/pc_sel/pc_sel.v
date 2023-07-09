module PCSEL( input [6:0]   opcode,
              output       pc_sel
);

    always @(opcode)
    begin
            case(opcode)
                7'h63: pc_sel   = 1'b1;
                7'h67: pc_sel   = 1'b1;
                7'h6f: pc_sel   = 1'b1;
                default: pc_sel = 1'b0;
            endcase
    end
endmodule
