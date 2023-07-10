//Register File 
module reg(
    input         clk,
    input         rst,
    input         regWEn,
    input  [4:0]  addrD,
    input  [4:0]  addrA,
    input  [4:0]  addrB,
    output [31:0] dataA,
    output [31:0] dataB
);

    reg [31:0] memory [0:31];

    always @(posedge clk or posedge rst) begin
        if (rst) begin 
            memory[0:31] <= 32'h0;
        // Control.v will determine if we need to write back.
        end else if (regWEn) begin
            memory[addrD] <= dataD;
        end
    end

    assign dataA = memory[addrA];
    assign dataB = memory[addrB];
endmodule

