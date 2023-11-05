// Data Cache.  
module dmem(
    input         clk,
    input         rst,
    input  [31:0] i_addr,
    input  [31:0]  dataW,
    input          memRW,
    output wire [31:0] o_data
);

wire [31:0] w_data;
reg [31:0] memory [0:1023];
assign o_data = w_data;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            w_data[31:0] <= 32'd0;
        end else if (memRW) begin
            memory[i_addr] <= dataW;
        end else begin
            w_data <= memory[i_addr];
        end
    end    
endmodule
