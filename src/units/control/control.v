module control( input [31:0] inst,
                input        brEq,
                input        brLT,
                output       pcSel,
                output       ImmS:l,
                output       RegWEn,
                output       BrUn,
                output       BSel,
                output       ASel,
                output       ALUSel,
                output       sign,
                output       MemRW,
                output       WBSel
);

    //Leaving this buffer module for more logic
    //
    inst_ctl inst_inst_ctl(
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

endmodule
