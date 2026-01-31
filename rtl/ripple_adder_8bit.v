// ripple_adder_8bit.v
module ripple_adder_8bit (
    input  [7:0] A,
    input  [7:0] B,
    input        CIN,
    output [7:0] SUM,
    output       COUT
);

wire [7:0] c;  // internal carry wires

// First stage
full_adder FA0 (
    .a(A[0]),
    .b(B[0]),
    .cin(CIN),
    .sum(SUM[0]),
    .cout(c[0])
);

// Middle stages
genvar i;
generate
    for (i = 1; i < 8; i = i + 1) begin : ADDER_CHAIN
        full_adder FA (
            .a(A[i]),
            .b(B[i]),
            .cin(c[i-1]),
            .sum(SUM[i]),
            .cout(c[i])
        );
    end
endgenerate

// Final carry out
assign COUT = c[7];

endmodule
