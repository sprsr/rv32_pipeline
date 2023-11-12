module rv32_tb;

    //reset that pulses once
    reg reset = 0;
    initial begin
        # 17 reset = 1'b1;
        # 11 reset = 1'b0;
        # 29 rest  = 1'b1;
        # 11 reset = 1'b0;
        # 100 $stop;
    end

    reg clk = 0;
    always #5 clk = !clk;

    rv32 c0 (clk, reset);
endmodule
