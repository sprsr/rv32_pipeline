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

reg [3:0] r_conflict_map;

//Function checking if the instruction is a write back instruction
function [2:0] write_back_check;
    input [31:0] instruction;
    case (instruction[6:0])
        // LUI Instruction: 
        7'b0110111: begin
            write_back_check  <= 2'b01;
        end
        // AUIPC Instruction: 
        7'b0010111: begin
            write_back_check  <= 2'b01;
        end
        // JALR Instruction:
        7'b1100111: begin
            write_back_check  <= 2'b10;
        end
        7'b1100011: begin
            write_back_check  <= 2'bx;
        end
        7'b0000011: begin
            write_back_check  <= 2'b0;
        end
        7'b0100011: begin
            write_back_check  <= 2'b0;
        end
        7'b0010011: begin
            write_back_check  <= 2'b1;
        end
        7'b0110011: begin
            write_back_check  <= 2'b1;
        end
        default: begin
            write_back_check  <= 2'b11;
        end
    endcase
endfunction

always @(posedge clk or posedge rst) begin
    if (rst) begin
        r_conflict_map = 4'b0;
    end else begin
        if (instr_acc[11:7] == instr_de[19:15]) begin
            r_conflict_map[3] = 1'b1;
        end else if (instr_acc[11:7] == instr_de[24:20]) begin
            r_conflict_map[2] = 1'b1;
        end else if (instr_exe[11:7] == instr_de[19:15]) begin
            r_conflict_map[1] = 1'b1;
        end else if(instr_exe[11:7] == instr_de[24:20]) begin
            r_conflict_map[0] = 1'b1;
        end
        if (r_conflict_map[3]) begin
            r_acc_wb = write_back_check(instr_acc);
            case (r_acc_wb):
                3'b00: begin
                    r_data_out_a = dmem_out_acc;
                end
                3'b01: begin
                    r_data_out_a = alu_out_acc;
                end
                3'b10: begin
                    r_data_out_a = pc_4_acc;
                end
                    

            acc_wb = write_back_check(instr_exe);
        end
    end
end

endmodule
