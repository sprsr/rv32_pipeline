module instr_mgr(
    input        clk,
    input        rst,
    input [31:0] instr_de,
    input [31:0] instr_exe,
    input [31:0] instr_acc,
    output       stall,
    output       hazard,
    output[31:0] data_a_mgr,
    output[31:0] data_b_mgr
);

always @(posedge clk or posedge rst) begin
    if rst begin
    end else begin
        if (instr_acc[11:7] == instr_de[19:15] or instr_acc[11:7 == instr_de[24:20]]) begin

        end else if (instr_exe[11:7] == instr_de[19:15] or instr_exe[11:7 == instr_de[24:20]]) begin

        end else begin

        end
    end
end

endmodule
