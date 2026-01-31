// subtractor_8bit.v
module subtractor_8bit (
    input  [7:0] A,
    input  [7:0] B,
    output [7:0] DIFF,
    output       BORROW
);

wire [7:0] B_inv;
wire cout;

// Step 1: Invert B (1's complement)
assign B_inv = ~B;

// Step 2 & 3: A + (~B) + 1
ripple_adder_8bit ADDER (
    .A(A),
    .B(B_inv),
    .CIN(1'b1),   // +1 for 2's complement
    .SUM(DIFF),
    .COUT(cout)
);

// Borrow logic
// If cout = 1 → No borrow
// If cout = 0 → Borrow happened
assign BORROW = ~cout;

endmodule
