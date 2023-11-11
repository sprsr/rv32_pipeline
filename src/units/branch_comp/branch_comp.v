module branch_comp(
    input [31:0] i_dataA,
    input [31:0] i_dataB,
    input        brUn,
    output  wire brEq,
    output  wire brLT
);

    reg r_Eq;
    reg r_LT;

    assign brEq = r_Eq;
    assign brLT = r_LT;
    
    always @(i_dataA or i_dataB) begin
        if (brUn) begin
            if ($unsigned(i_dataA) == $unsigned(i_dataB)) begin
                r_Eq <= 1'b1;
                r_LT <= 1'b0;
            end else if ($unsigned(i_dataA) < $unsigned(i_dataB)) begin
                r_Eq <= 1'b0;
                r_LT <= 1'b1;
            end else begin
                r_Eq <= 1'b0;
                r_LT <= 1'b0;
            end
        end else begin
            if ($signed(i_dataA) == $signed(i_dataB)) begin
                r_Eq <= 1'b1;
                r_LT <= 1'b0;
            end else if ($signed(i_dataA) < $signed(i_dataB)) begin
                r_Eq <= 1'b0;
                r_LT <= 1'b1;
            end else begin
                r_Eq <= 1'b0;
                r_LT <= 1'b0;
            end    
        end
    end
endmodule
