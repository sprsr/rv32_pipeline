// The PC Module is handling most Fetching Logic with help of control unit (sel_pc)
module PC(
  input         clk,     // Clock input
  input         rst,     // Reset input
  input         sel_pc,  // PC Select Control Signal
  input  [31:0] in_pc,   // input ALU
  input  [31:0] in_alu,  // input PC
  output [31:0] pc_nxt,  // Next
  output [31:0] pc       // Program Counter output
);
  
  always @(posedge clk or posedge rst) begin
    if (rst) begin
        pc     <= 0;  // Reset the program counter to 0
        pc_nxt <=0;
    end else if (sel_pc) begin
        pc <= in_alu;          // Increment the program counter if enabled
        pc_nxt <= in_alu + 'd4;
    end else if (!sel_pc) begin
        pc <= in_pc;          // Increment the program counter if enabled
        pc_nxt <= in_pc + 'd4;
    end
  end
endmodule

