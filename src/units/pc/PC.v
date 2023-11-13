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

    reg [31:0] w_pc;
    reg [31:0] w_pc_nxt;

    assign pc = w_pc;
    assign pc_nxt = w_pc_nxt;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            w_pc <= 0;  // Reset the program counter to 0
            w_pc_nxt <=0;
        end else if (sel_pc) begin
            w_pc = in_alu;          // Increment the program counter if enabled
            w_pc_nxt = in_alu + 'd4;
        end else begin
            w_pc = in_pc;          // Increment the program counter if enabled
            w_pc_nxt = in_pc + 'd4;
        end
    end

endmodule

