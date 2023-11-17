module access_ctl(
    input clk,
    input rst,
    input [31:0] instruction,
    output [31:0] instr_wb,
    output MemRW
);

reg        r_MemRW;
reg [31:0] r_instr_wb;



always @(posedge(clk) or posedge(rst)) begin
    if (rst) begin
        r_MemRW    <= 1'b0;
        r_instr_wb <= 32'h0;
    end else begin
        case (instruction[6:0])
            // LUI Instruction: 
            7'b0110111: begin
                r_mem_wr  <= 1'b0;
            end
            // AUIPC Instruction: 
            7'b0010111: begin
                r_mem_wr  <= 1'b0;
            end
            // JAL Instruction:
            7'b1101111: begin
                r_mem_wr  <= 1'b0;
            end
            // JALR Instruction:
            7'b1101111: begin
                r_mem_wr  <= 1'b0;
            end
            7'b1100011: begin
                case (instruction[14:12])
                    // BEQ Instruction:
                    3'b000: begin
                        r_mem_wr  <= 1'b0;
                    end
                    // BNE Instruction
                    3'b001: begin
                        r_mem_wr  <= 1'b0;
                    end
                    //BLT Instruction
                    3'b010: begin
                        r_mem_wr  <= 1'b0;
                    end
                    //BGE Instruction
                    3'b101: begin
                        r_mem_wr  <= 1'b0;
                    end
                    //BLTU Instruction
                    3'b110: begin
                        r_mem_wr  <= 1'b0;
                    end
                    //BGEU Instruction
                    3'b111: begin
                        r_mem_wr  <= 1'b0;
                    end
                endcase
            end
            7'b0000011: begin
                case (instruction[14:12])
                    //LB Instruction
                    3'b000: begin
                        r_mem_wr  <= 1'b0;
                    end
                    //LH Instruction
                    3'b001: begin
                        r_mem_wr  <= 1'b0;
                    end
                    //LW Instruction
                    3'b010: begin
                        r_mem_wr  <= 1'b0;
                    end
                    //LBU Instruction
                    3'b100: begin
                        r_mem_wr  <= 1'b0;
                    end
                    //LHU Instruction
                    3'b101: begin
                        r_mem_wr  <= 1'b0;
                    end
                endcase
            end
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
            7'b0010011: begin
                case (instruction[14:12])
                    // ADDI Instruction
                    3'b000: begin
                        r_mem_wr  <= 1'b0;
                    end
                    // SLTI Instruction
                    3'b010: begin
                        r_mem_wr  <= 1'b0;
                    end
                    // SLTIU Instruction
                    3'b011: begin
                        r_mem_wr  <= 1'b0;
                    end
                    // XORI Instruction
                    3'b100: begin
                        r_mem_wr  <= 1'b0;
                    end
                    // ORI Instruction
                    3'b100: begin
                        r_mem_wr  <= 1'b0;
                    end
                    // ANDI Instruction
                    3'b111: begin
                        r_mem_wr  <= 1'b0;
                    end
                    // SLLI Instruction
                    3'b001: begin
                        r_mem_wr  <= 1'b0;
                    end
                    3'b101: begin
                        case (instruction[31:25])
                            // SRLI Instruction
                            7'b0000000: begin
                                r_mem_wr  <= 1'b0;
                            end
                            // SRAI Instruction
                            7'b0100000: begin
                                r_mem_wr  <= 1'b0;
                            end
                        endcase
                    end
                endcase
            end
            7'b0110011: begin
                case (instruction[14:12]) 
                    3'b000: begin
                        case (instruction[31:25])
                            // ADD Instruction
                            7'b0000000: begin
                                r_mem_wr  <= 1'b0;
                            end
                            // SUB Instruction
                            7'b0100000: begin
                                r_mem_wr  <= 1'b0;
                            end
                        endcase
                    end
                    // SLL Instruction
                    3'b001: begin
                        r_mem_wr  <= 1'b0;
                    end
                    // SLT Instruction
                    3'b010: begin
                        r_mem_wr  <= 1'b0;
                    end
                    // SLTU Instruction
                    3'b011: begin
                        r_mem_wr  <= 1'b0;
                    end
                    // XOR Instruction
                    3'b100: begin
                        r_mem_wr  <= 1'b0;
                    end
                    // SRA Instruction
                    3'b100: begin
                        r_mem_wr  <= 1'b0;
                    end
                    // OR Instruction
                    3'b110: begin
                        r_mem_wr  <= 1'b0;
                    end
                    // AND Instruction
                    3'b111: begin
                        r_mem_wr  <= 1'b0;
                    end
                endcase
            end
            //  FENCE Instruction
            7'b0001111: begin
                r_mem_wr  <= 1'b0;
            end
            7'b1110011: begin
                case (instruction[31:20])
                    //  @todo
                    //  ECALL Instruction
                    7'h0: begin
                        r_mem_wr  <= 1'b0;
                    end
                    //  @todo 
                    //  EBREAK Instruction
                    7'h1: begin
                        r_mem_wr  <= 1'b0;
                    end
                endcase
            end
        endcase
    end
    end
endmodule


