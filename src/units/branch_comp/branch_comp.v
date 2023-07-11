module branch_comp(
    input [31:0] i_dataA;
    input [31:0] i_dataB;
    input        brUn;
    output       brEq;
    output       brLT;
);


    always @(i_dataA or i_dataB) begin
        if (brUn) begin
            if (i_dataA == i_dataB) begin
                brEq <= 1'b1;
                brLT <= 1'b0;
            end else if (i_dataA < i_datab) begin
                brEq <= 1'b0;
                brLT <= 1'b1;
            end else begin
                brEq <= 1'b0;
                brLT <= 1'b0;
            end
        end else begin
            if ($signed(i_dataA) == $signed(i_datab))) begin
                brEq <= 1'b1;
                brLT <= 1'b0;
            end else if ($signed(i_dataa) < $signed(i_datab)) begin
                brEq <= 1'b0;
                brLT <= 1'b1;
            end else begin
                brEq <= 1'b0;
                brLT <= 1'b0;
            end    
        end
    end
endmodule
