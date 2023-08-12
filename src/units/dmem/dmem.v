
// Data Cache.  
module dmem(
    input  [31:0] i_addr,
    output [31:0] o_data
);

reg [31:0] memory [0:1023];

    initial begin
        mem[0] <= 32'h12345678;
        mem[1] <= 32'hABCDEF01;
    end

    always @(address) begin
        o_inst<=memory[i_addr];
    end    
endmodule
