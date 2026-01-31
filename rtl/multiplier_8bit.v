// multiplier_8bit.v
module multiplier_8bit (
    input  [7:0] A,
    input  [7:0] B,
    output [15:0] PRODUCT
);

reg [15:0] result;
reg [15:0] a_shifted;
integer i;

// Combinational multiplier
always @(*) begin
    result = 16'b0;

    for (i = 0; i < 8; i = i + 1) begin
        if (B[i]) begin
            a_shifted = A << i;
            result = result + a_shifted;
        end
    end
end

assign PRODUCT = result;

endmodule
