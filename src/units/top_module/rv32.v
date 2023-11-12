module rv32(
    input clk,
    input rst,
    output zero
);


wire        w_regWEn;
wire        w_pc_sel;
wire        w_a_sel;
wire        w_b_sel;
wire        w_sign;
wire  [4:0] w_alu_sel;
wire  [1:0] w_wb_sel;
wire [31:0] w_pc_4;
wire [31:0] w_o_alu;
wire [31:0] w_pc;
wire [31:0] w_instruction;
wire [31:0] w_data_D;
wire [31:0] w_reg_data_A;
wire [31:0] w_reg_data_B;
wire [31:0] w_alu_in_A;
wire [31:0] w_alu_in_B;
wire [31:0] w_alu_out;
wire        w_alu_zero_flag;

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
    
branch_comp inst_branch_comp(
    .i_dataA(w_reg_data_A),
    .i_dataB(w_reg_data_B),
    .brUn(w_brUn),
    .brEq(w_brEq),
    .brLT(w_brLT)
);

mux2x1 inst_mux2x1_A(
    .a(w_pc),
    .b(w_reg_data_A),
    .sel(w_a_sel),
    .y(w_alu_in_A)
);

mux2x1 inst_mux2x1_B(
    .a(w_pc),
    .b(w_reg_data_B),
    .sel(w_b_sel),
    .y(w_alu_in_B)
);

alu inst_alu(
    .i_1(w_reg_data_A),
    .i_2(w_reg_data_B),
    .aluSel(w_alu_sel),
    .sign(w_sign),
    .result(w_alu_out),
    .zero_flag(w_alu_zero_flag)
);

dmem inst_dmem(

);

mux3x1 inst_mux3x1_wb(
    .a(w_pc_4),
    .b(w_alu_out),
    .c(w_dmem_out),
    .sel(w_wb_sel),
    .y(w_data_D)
);

