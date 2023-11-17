module execute_ctl(
    input         clk,
    input         rst,
    input         BrEq,
    input         BrLT,
    input  [31:0] instruction,
    output        a_sel,
    output        b_sel,
    output        sign,
    output [3:0]  alu_sel,
    output [31:0] instr_acc
);

reg       r_a_sel   = 1'b0;
reg       r_b_sel   = 1'b0;
reg [3:0] r_alu_sel = 4'b0;
reg       r_sign    = 1'b0;

