module wb_ctl(
    input clk,
    input rst,
    input [31:0] instruction,
    output [1:0] wb_sel
    output       regWEn
);

reg [1:0] r_wb_sel;
reg       r_regWEn;
reg [31:0] r_instr_wb;

assign wb_sel = r_wb_sel;

always @(posedge clk or posedge rst) begin
    if (rst) begin
        r_wb_sel <= 1'b0;
        r_instr_wb <= 32'h0;
        r_regWEn <= 1'b0;
    end else begin
        case (instruction[6:0])
            // LUI Instruction: 
            7'b0110111: begin
                r_wb_sel  <= 2'b01;
                r_regWEn <= 1'b1;
            end
            // AUIPC Instruction: 
            7'b0010111: begin
                r_wb_sel  <= 2'b01;
                r_regWEn <= 1'b1;
            end
            // JAL Instruction:
            7'b1101111: begin
                r_wb_sel  <= 2'b10;
                r_regWEn <= 1'b1;
            end
            7'b1100011: begin
                r_wb_sel  <= 2'bx;
            end
            7'b0000011: begin
                r_wb_sel  <= 2'b0;
                r_regWEn <= 1'b1;
            end
            7'b0100011: begin
                r_wb_sel  <= 2'b0;
                r_regWEn <= 1'b1;
            end
            7'b0010011: begin
                r_wb_sel  <= 2'b1;
                r_regWEn <= 1'b1;
            end
            7'b0110011: begin
                r_wb_sel  <= 2'b1;
                r_regWEn <= 1'b1;
            end
            default: begin
                r_wb_sel  <= 2'b0;
                r_regWEn  <= 1'b0;
            end
        endcase
        r_instr_wb <= instruction;
    end
end
endmodule
