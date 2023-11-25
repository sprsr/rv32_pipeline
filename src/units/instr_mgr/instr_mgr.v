module instr_mgr(
    input        clk,
    input        rst,
    input [31:0] instr_fetch,
    input [31:0] instr_de,
    input [31:0] data_a_de,
    input [31:0] data_b_de,
    input [31:0] instr_exe,
    input [31:0] alu_out_exe,
    input [31:0] pc_exe,
    input [31:0] instr_acc,
    input [31:0] alu_out_acc,
    input [31:0] dmem_out_acc,
    input [31:0] instr_wb,
    input [31:0] data_d_wb,
    input [31:0] pc_4_acc,
    output       pc_sel,
    output       false_path,
    output       stall,
    output       hazard_a,
    output       hazard_b,
    output[31:0] data_a_mgr,
    output[31:0] data_b_mgr
);
reg       r_pc_sel;
reg       r_stall;
reg       r_hazard_a;
reg       r_hazard_b;
reg [5:0] r_conflict_map;
reg [2:0] r_wb_acc;
reg [2:0] r_wb_exe;
reg [2:0] r_wb_wb;
reg [31:0] r_data_mgr;
reg [31:0] r_data_a_mgr;
reg [31:0] r_data_b_mgr;

assign stall = r_stall;
assign hazard_a = r_hazard_a;
assign hazard_b = r_hazard_b;
assign data_a_mgr = r_data_a_mgr;
assign data_b_mgr = r_data_b_mgr;

mux2x1 inst_hazard_mux_A(
    .a(r_data_a_mgr),
    .b(data_a_de),
    .sel(r_hazard_a),
    .y(w_data_a)
);

mux2x1 inst_hazard_mux_B(
    .a(r_data_b_mgr),
    .b(data_b_de),
    .sel(r_hazard_b),
    .y(w_data_b)
);

reg r_brUn;
reg r_brEq;
reg r_brLT;

branch_comp inst_branch_comp(
    .i_dataA(r_data_a),
    .i_dataB(r_data_b),
    .brUn(r_brUn),
    .brEq(r_brEq),
    .brLT(r_brLT)
);

function conditional_branch;
    input [31:0] instruction;
    case (instruction[14:12])
        // BEQ Instruction:
        3'b000: begin
            case (r_BrEq)
                1'b0: conditional_branch = 1'b0;
                1'b1: conditional_branch = 1'b1;
            endcase
        end
        // BNE Instruction
        3'b001: begin
            case (BrEq)
                1'b0: conditional_branch = 1'b1;
                1'b1: conditional_branch = 1'b0;
            endcase
        end
        //BLT Instruction
        3'b010: begin
            r_BrUn    = 1'b0; 
            case (BrLT)
                1'b0: conditional_branch = 1'b0;
                1'b1: condtitional_branch = 1'b1;
            endcase
        end
        //BGE Instruction
        3'b101: begin
            r_BrUn    = 1'b0;
            case (BrLT)
                1'b0: conditional_branch = 1'b1;
                1'b1: conditional_branch = 1'b0;
            endcase
        end
        //BLTU Instruction
        3'b110: begin
            r_BrUn    <= 1'b1;
            case (BrLT)
                1'b0: conditional_branch = 1'b0;
                1'b1: conditional_branch = 1'b1;
            endcase
        end
        //BGEU Instruction
        3'b111: begin
            r_BrUn    = 1'b1;
            case (BrLT)
                1'b0: conditional_branch = 1'b1;
                1'b1: conditional_branch = 1'b0;
            endcase
        end
    endcase
endfunction


//Function checking if the instruction is a write back instruction
function [2:0] write_back_check;
    input [31:0] instruction;
    case (instruction[6:0])
        // LUI Instruction: 
        7'b0110111: begin
            write_back_check  = 2'b01;
        end
        // AUIPC Instruction: 
        7'b0010111: begin
            write_back_check  = 2'b01;
        end
        // JALR Instruction:
        7'b1100111: begin
            write_back_check  = 2'b10;
        end
        7'b1100011: begin
            write_back_check  = 2'bx;
        end
        7'b0000011: begin
            write_back_check  = 2'b0;
        end
        7'b0100011: begin
            write_back_check  = 2'b0;
        end
        7'b0010011: begin
            write_back_check  = 2'b1;
        end
        7'b0110011: begin
            write_back_check  = 2'b1;
        end
        default: begin
            write_back_check  = 2'b11;
        end
    endcase
endfunction

always @(posedge clk or posedge rst) begin
    if (rst) begin
        r_pc_sel = 1'b0;
        r_false_path = 1'b0;
        r_conflict_map = 6'b0;
        r_stall = 1'b0;
        r_hazard_a = 1'b0;
        r_hazard_b = 1'b0;
        r_wb_acc   = 4'h0;
        r_wb_exe   = 4'h0;
        r_data_mgr = 32'hx;
        r_data_a_mgr = 32'hx;
        r_data_b_mgr = 32'hx;
    end else begin
        r_conflict_map = 6'h0;
        r_stall = 1'b0;
        r_hazard_a = 1'b0;
        r_hazard_b = 1'b0;
        if (instr_wb[11:7] == instr_de[19:15]) begin
            r_conflict_map[5] = 1'b1;
        end if (instr_wb[11:7] == instr_de[24:20]) begin
            r_conflict_map[4] = 1'b1;
        end 
        if (instr_acc[11:7] == instr_de[19:15]) begin
            r_conflict_map[3] = 1'b1;
        end if (instr_acc[11:7] == instr_de[24:20]) begin
            r_conflict_map[2] = 1'b1;
        end 
        if (instr_exe[11:7] == instr_de[19:15]) begin
            r_conflict_map[1] = 1'b1;
        end if(instr_exe[11:7] == instr_de[24:20]) begin
            r_conflict_map[0] = 1'b1;
        end
        if (r_conflict_map[1] || r_conflict_map[0]) begin
            r_wb_exe = write_back_check(instr_exe);
            case (r_wb_exe)
                3'b00: begin
                    r_stall = 1'b1;
                    r_data_mgr = 32'hx;
                end
                3'b01: begin
                    r_data_mgr = alu_out_exe;
                end
                3'b10: begin
                    r_data_mgr = pc_exe + 1'b1;
                end
                default: begin
                    r_data_mgr = 32'hx;
                end
            endcase
            if (r_conflict_map[1] && r_wb_exe != 3'b11) begin
                r_data_a_mgr = r_data_mgr;
                r_hazard_a = 1'b1;
            end else if (r_conflict_map[0] && r_wb_exe != 3'b11) begin
                r_data_b_mgr = r_data_mgr;
                r_hazard_b = 1'b1;
            end
        end 
        if (r_conflict_map[3] || r_conflict_map[2]) begin
            r_wb_acc = write_back_check(instr_acc);
            case (r_wb_acc)
                3'b00: begin
                    r_data_mgr = dmem_out_acc;
                end
                3'b01: begin
                    r_data_mgr = alu_out_acc;
                end
                3'b10: begin
                    r_data_mgr = pc_4_acc;
                end
                default: begin
                    r_data_mgr = 32'hx;
                end
            endcase
            if (r_conflict_map[3] && !r_conflict_map[1] &&  r_wb_acc != 3'b11) begin
                r_data_a_mgr = r_data_mgr;
                r_hazard_a = 1'b1;
            end else if (r_conflict_map[2] && !r_conflict_map[0] &&  r_wb_acc != 3'b11) begin
                r_data_b_mgr = r_data_mgr;
                r_hazard_b = 1'b1;
            end
        end
        if (r_conflict_map[5] || r_conflict_map[4]) begin
            r_wb_wb = write_back_check(instr_wb);
            if (r_conflict_map[5] && !r_conflict_map[3] && !r_conflict_map[1] &&  r_wb_wb != 3'b11) begin
                r_data_a_mgr = data_d_wb;
                r_hazard_a = 1'b1;
            end else if (r_conflict_map[4] && !r_conflict_map[2] && !r_conflict_map[0] &&  r_wb_wb != 3'b11) begin
                r_data_b_mgr = data_d_wb;
                r_hazard_b = 1'b1;
            end
        end
        case (instr_fetch[6:0])
            // JAL Instruction:
            7'b1101111: begin
                r_pc_sel = 1'b1;
            end
            // JALR Instruction:
            7'b1101111: begin
                r_pc_sel = 1'b1;
            end
            default: begin
                r_pc_sel = 1'b0;
            end
        endcase
        if (instr_exe[6:0] == 7'b1100011) begin:
            r_pc_sel = branch(instr_exe);
        if (r_pc_sel) begin
            false_path <= 1'b1;
        end
    end
end

end

    end
end

endmodule
