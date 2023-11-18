module access_ctl(
    input clk,
    input rst,
    input [31:0] instruction,
    output [31:0] instr_wb,
    output MemRW
);

reg        r_mem_wr;
reg [31:0] r_instr_wb;

assign instr_wb = r_instr_wb;
assign MemRW = r_mem_wr;

always @(posedge clk or posedge rst) begin
    if (rst) begin
        r_mem_wr   <= 1'b0;
        r_instr_wb <= 32'h0;
    end else begin
        case (instruction[6:0])
            7'b0100011: begin
                case (instruction[14:12])
                    // SB Instruction
                    3'b000: begin
                        r_mem_wr  <= 1'b1;
                    end
                    // SH Instruction
                    3'b001: begin
                        r_mem_wr  <= 1'b1;
                    end
                    // SW Instruction
                    3'b010: begin
                        r_mem_wr  <= 1'b1;
                    end
                endcase
            end
            default: begin
                r_mem_wr <= 1'b0;
            end
        endcase
        r_instr_wb <= instruction;
    end
end
endmodule


