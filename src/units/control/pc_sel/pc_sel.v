module pc_sel( input [31:0] inst,
               output       pc_sel
);

    always @(*)
    begin
            case(inst[6:0])
                7'h63: pc_sel   = 1'b1;
                7'h67: pc_sel   = 1'b1;
                7'h6f: pc_sel   = 1'b1;
                default: pc_sel = 1'b0;
            endcase
    end
endmodule
