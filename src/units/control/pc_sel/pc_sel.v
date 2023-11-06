module PCSEL( input [6:0]   opcode,
              output        pc_sel
);
reg r_pc_sel;
assign pc_sel = r_pc_sel;
    always @(*)
    begin
            case (opcode)
                7'h63: r_pc_sel <= 1'b1;
                7'h67: r_pc_sel <= 1'b1;
                7'h6f: r_pc_sel <= 1'b1;
                default: r_pc_sel <= 1'b0;
            endcase
    end
endmodule
