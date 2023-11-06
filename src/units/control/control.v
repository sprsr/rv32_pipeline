module control( input [31:0] inst,
                input        brEq,
                input        brLT,
                output       pcSel,
                output       ImmSel,
                output       RegWEn,
                output       BrUn,
                output       BSel,
                output       ASel,
                output       ALUSel,
                output       MemRW,
                output       WBSel
);

    PCSEL inst_pcSel(.opcode(inst[6:0]),.pc_sel(pcSel));
    IMMSEL inst_immSel(.opcode(inst[6:0]),.immSel(ImmSel));
    BRCTL inst_brctl(.instruction(inst),.brun(BrUn));
endmodule
