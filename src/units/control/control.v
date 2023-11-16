module control( input [31:0] inst,
                input        brEq,
                input        brLT,
                output       pcSel,
                output [3:0] ImmSel,
                output       RegWEn,
                output       BrUn,
                output       BSel,
                output       ASel,
                output [3:0] ALUSel,
                output       sign,
                output       MemRW,
                output [1:0] WBSel
);

wire w_instr_de;

fetch_ctl inst_fetch_ctl(
    .clk(clk),
    .rst(rst),
    .instruction(inst),
    .immSel(ImmSel),
    .instr_de(w_instr_de)
);
    //Leaving this buffer module for more logic
    /*
    instr_ctl inst_instr_ctl(
        .instruction(inst), 
        .BrEq(brEq),
        .BrLT(brLT),
        .a_sel(ASel),
        .b_sel(BSel),
        .alu_sel(ALUSel),
        .sign(sign),
        .mem_wr(MemRW),
        .RegWEn(RegWEn),
        .immSel(ImmSel),
        .BrUn(BrUn),
        .pc_sel(pcSel),
        .wb_sel(WBSel)
    );
    */

endmodule
