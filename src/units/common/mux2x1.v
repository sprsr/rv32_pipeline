module mux2x1(
    input a,
    input b,
    input sel,
    output y
);

    always @(*) begin
        case(sel)
            1'b1 : y = a;
            1'b0 : y = b;
        endcase    
    end
endmodule
