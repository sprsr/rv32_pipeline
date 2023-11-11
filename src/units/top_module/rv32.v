module rv32(
    input clk,
    input rst,
    output zero
);


wire        w_regWEn;
wire        w_pc_sel;
wire [31:0] w_pc_4;
wire [31:0] w_o_alu;
wire [31:0] w_pc;
wire [31:0] w_instruction;
wire [31:0] w_reg_data_A;
wire [31:0] w_reg_data_B;

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

imem inst_imem(
    .i_addr(w_pc),
    .o_data(w_instruction)
);

register inst_register(
    .clk(clk),
    .rst(rst),
    .regWEn(w_regWEn),
    .dataD(w_o_alu),
    .addrD(w_instruction[11:7]),
    .addrA(w_instruction[19:15]),
    .addrB(w_instruction[24:20]),
    .dataA(w_reg_data_A),
    .dataB(w_reg_data_B),
);


