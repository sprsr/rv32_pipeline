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

//Function checking if the instruction is a write back instruction
function [3:0] write_back_check;
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
        end else begin
            if ((instr_acc[11:7] == instr_de[19:15]) or (instr_acc[11:7] == instr_de[24:20])) begin
                acc_wb = write_back_check(instr_acc);
            end else if ((instr_exe[11:7] == instr_de[19:15]) or (instr_exe[11:7] == instr_de[24:20])) begin
                acc_wb = write_back_check(instr_exe);
            end
        end
    end

    endmodule
