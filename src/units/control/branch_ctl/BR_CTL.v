module BRCTL(
    input [31:0] instruction,
    output       brun
);

reg r_brun;
assign brun = r_brun;

    always @(*) begin
        if (instruction[6:0] == 7'b1100011 && (instruction[14:12] == 3'b111 || instruction[14:12] == 3'b110)) begin
            r_brun <= 1'b1;
        end else begin
            r_brun <= 1'b0;
        end
    end
endmodule
