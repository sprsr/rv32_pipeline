// Instruction Cache.  
// Will determine best way to load instructions from Main Memory later. 
// Right now an initial test sequence will be used
module imem(
    input  [31:0] i_addr,
    output [31:0] o_data
);

    reg  [31:0]  r_memory [0:1023];

    initial begin
        r_memory[0] <= 32'b   0000	0000	0001	0101	1000	0101	1001	0011;
        r_memory[1] <= 32'b   0000	0000	0001	0101	1000	0101	1001	0011;
    end

    assign o_data = r_memory[i_addr];

endmodule
