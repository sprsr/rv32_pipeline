
always @(posedge(clk) or posedge(rst)) begin
    if (rst) begin
        r_immSel  <= 4'h4;
    end else begin      
        case (instruction[6:0])
            // LUI Instruction: 
            7'b0110111: begin
                r_immSel  <= 4'h4;
            end
            // AUIPC Instruction: 
            7'b0010111: begin
                r_immSel  <= 4'h4;
            end
            // JAL Instruction:
            7'b1101111: begin
                r_immSel  <= 4'h5;
            end
            // JALR Instruction:
            7'b1101111: begin
                r_immSel  <= 4'h1;
            end
            7'b1100011: begin
                    // BEQ Instruction:
                    // BNE Instruction
                    //BLT Instruction
                    //BGE Instruction
                    //BLTU Instruction
                    //BGEU Instruction
                    r_immSel  <= 4'h3;
            end
            7'b0000011: begin
                    //LB Instruction
                    //LH Instruction
                    //LW Instruction
                    //LBU Instruction
                    //LHU Instruction
                    r_immSel  <= 4'h1;
            end
            7'b0100011: begin
                    // SB Instruction
                    // SH Instruction
                    // SW Instruction
                    r_immSel  <= 4'h2;
            end
            7'b0010011: begin
                    // ADDI Instruction
                    // SLTI Instruction
                    // SLTIU Instruction
                    // XORI Instruction
                    // ORI Instruction
                    // ANDI Instruction
                    // SLLI Instruction
                            // SRLI Instruction
                            //7'b0000000: begin
                            // SRAI Instruction
                            //7'b0100000: begin
                        r_immSel  <= 4'h1;
            end
            7'b0110011: begin
                // case (instruction[14:12]) 
                //    3'b000: begin
                        //case (instruction[31:25])
                            // ADD Instruction
                            //7'b0000000: begin
                            // SUB Instruction
                            //7'b0100000: begin
                    // SLL Instruction
                    //3'b001: begin
                    // SLT Instruction
                    //3'b010: begin
                    // SLTU Instruction
                    //3'b011: begin
                    // XOR Instruction
                    //3'b100: begin
                    // SRA Instruction
                    //3'b100: begin
                    // OR Instruction
                    //3'b110: begin
                    // AND Instruction
                    //3'b111: begin
                        r_immSel  <= 4'h0;
            end
            //  FENCE Instruction
            7'b0001111: begin
                r_immSel  <= 4'h0;
            end
            7'b1110011: begin
                // case (instruction[31:20])
                    //  @todo
                    //  ECALL Instruction
                    //7'h0: begin
                    //  @todo 
                    //  EBREAK Instruction
                    //7'h1: begin
                        r_immSel  <= 4'h0;
            end
        endcase
        instr_de <= instruction;
    end
end
