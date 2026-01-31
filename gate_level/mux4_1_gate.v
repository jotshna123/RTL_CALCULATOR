// mux4_1_gate.v
module mux4_1_gate (
    input  [15:0] d0, d1, d2, d3,  // Data inputs
    input  [1:0]  s,               // Select lines (OP)
    output [15:0] y               // Output
);

wire s0n, s1n;
wire [15:0] w0, w1, w2, w3;

// Invert select lines
not (s0n, s[0]);
not (s1n, s[1]);

genvar i;
generate
    for (i = 0; i < 16; i = i + 1) begin : MUX_BITS
        // Enable each input only for its select condition
        and (w0[i], d0[i], s1n, s0n); // 00 → d0
        and (w1[i], d1[i], s1n, s[0]); // 01 → d1
        and (w2[i], d2[i], s[1], s0n); // 10 → d2
        and (w3[i], d3[i], s[1], s[0]); // 11 → d3

        // OR them together
        or  (y[i], w0[i], w1[i], w2[i], w3[i]);
    end
endgenerate

endmodule
