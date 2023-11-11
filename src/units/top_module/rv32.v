module rv32(
    input clk,
    input rst,
    output zero
);


wire w_pc_sel;
wire w_pc_4;
wire w_o_alu;
wire w_pc;

control inst_control(
)

PC inst_pc(
    .clk(clk),
    .rst(rst),
    .sel_pc(w_sel_pc),
    .in_pc(w_pc_4),
    .in_alu(w_o_alu),
    .pc_nxt(w_pc_4),
    .pc(w_pc)
);


