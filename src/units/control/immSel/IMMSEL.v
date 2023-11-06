module IMMSEL( input opcode,
               output [4:0] immSel
);
reg r_immSel;
assign immSel = r_immSel;
    always @(*) begin
        case (opcode)
            7'b0110011: r_immSel <= 4'h0;
            7'b0010011: r_immSel <= 4'h1;
            7'b0100011: r_immSel <= 4'h2;
            7'b1100011: r_immSel <= 4'h3;
            7'b0110111: r_immSel <= 4'h4;
            7'b0010111: r_immSel <= 4'h4;
            7'b1101111: r_immSel <= 4'h5;
        endcase
    end

endmodule
