module ALUSEL(
    input [31:0] instruction,
    output a_sel,
    output b_sel,
    output alu_sel,
    output mem_wr,
    output [1:0] wb_sel
);

reg       r_a_sel;
reg       r_b_sel;
reg [3:0] r_alu_sel;
reg       r_mem_wr;
reg [1:0] r_wb_sel;

assign a_sel   = r_a_sel;
assign b_sel   = r_b_sel;
assign alu_sel = r_alu_sel;
assign mem_wr  = r_mem_wr;
assign wb_sel  = r_wb_sel;

always @(*) begin
    case (instruction)
        7'b0110111: begin
            r_a_sel   <= 1'b0;
            r_b_sel   <= 1'b1;
            r_alu_sel <= 4'b1001;
            r_mem_wr    <= 1'b0;
            r_wb_sel    <= 2'b01;
        end
        7'b0010111: begin
            r_a_sel   <= 1'b1;
            r_b_sel   <= 1'b1;
            r_alu_sel <= 4'b0010;
            r_mem_wr    <= 1'b0;
            r_wb_sel    <= 2'b01;
        end
    endcase
end
endmodule
