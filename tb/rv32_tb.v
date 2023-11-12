module rv32_tb;

    //reset that pulses once
    reg reset = 0;
    reg clk;
    
    rv32 c0 (
        .clk(clk),
        .rst(reset)
    );

    initial begin 
        clk = 1'b0;
        forever #5 clk = ~clk;
    end

    initial begin

        $dumpfile("rv32_tb.vcd");
        $dumpvars(0,rv32_tb);

        # 17 reset = 1'b1;
        # 11 reset = 1'b0;
        # 29 reset = 1'b1;
        # 11 reset = 1'b0;
        # 100 $finish;
    end

endmodule
