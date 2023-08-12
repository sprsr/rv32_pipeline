
// Data Cache.  
module dmem(
    input  [31:0] i_addr,
    input  [31:0]  dataW,
    input          memRW,
    output [31:0] o_data
);

reg [31:0] memory [0:1023];

    always @(address) begin
        if memRW begin
            memory[i_addr] <= dataW;
        end else begin
            o_data <= memory[i_addr];
        end
    end    
endmodule
