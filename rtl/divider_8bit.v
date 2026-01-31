module divider_8bit (
    input        clk,
    input        start,
    input  [7:0] A,   // Dividend
    input  [7:0] B,   // Divisor

    output reg [7:0] QUOTIENT,
    output reg [7:0] REMAINDER,
    output reg       DONE,
    output reg       DIV_BY_ZERO
);

reg [7:0] rem_reg;
reg [7:0] div_reg;
reg [7:0] quo_reg;
reg       busy;

always @(posedge clk) begin
    if (start) begin
        // Initialization
        if (B == 8'b0) begin
            DIV_BY_ZERO <= 1;
            DONE        <= 1;
            QUOTIENT   <= 8'b0;
            REMAINDER  <= 8'b0;
            busy       <= 0;
        end else begin
            DIV_BY_ZERO <= 0;
            DONE        <= 0;
            rem_reg    <= A;
            div_reg    <= B;
            quo_reg    <= 8'b0;
            busy       <= 1;
        end
    end
    else if (busy) begin
        if (rem_reg >= div_reg) begin
            rem_reg <= rem_reg - div_reg;
            quo_reg <= quo_reg + 1'b1;
        end else begin
            // Finished
            QUOTIENT  <= quo_reg;
            REMAINDER<= rem_reg;
            DONE     <= 1;
            busy     <= 0;
        end
    end
end

endmodule
