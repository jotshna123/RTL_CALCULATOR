module calculator_top (
    input  [7:0]  A,
    input  [7:0]  B,
    input  [1:0]  OP,
    input         clk,
    input         start,

    output [15:0] RESULT,
    output        DONE,
    output        DIV_BY_ZERO
);


// ADD
wire [7:0] add_sum;
wire       add_cout;

// SUB
wire [7:0] sub_diff;
wire       sub_borrow;

// MUL
wire [15:0] mul_product;

// DIV
wire [7:0] div_quotient;
wire [7:0] div_remainder;
wire       div_done;
wire       div_zero;

/////////////////////
// Module Instances
/////////////////////

// ADDER
ripple_adder_8bit ADDER (
    .A(A),
    .B(B),
    .CIN(1'b0),
    .SUM(add_sum),
    .COUT(add_cout)
);

// SUBTRACTOR
subtractor_8bit SUBTRACTOR (
    .A(A),
    .B(B),
    .DIFF(sub_diff),
    .BORROW(sub_borrow)
);

// MULTIPLIER
multiplier_8bit MULTIPLIER (
    .A(A),
    .B(B),
    .PRODUCT(mul_product)
);

// DIVIDER (Sequential)
divider_8bit DIVIDER (
    .clk(clk),
    .start(start),
    .A(A),
    .B(B),
    .QUOTIENT(div_quotient),
    .REMAINDER(div_remainder),
    .DONE(div_done),
    .DIV_BY_ZERO(div_zero)
);

/////////////////////
// Format to 16-bit
/////////////////////

wire [15:0] add_out;
wire [15:0] sub_out;
wire [15:0] mul_out;
wire [15:0] div_out;

assign add_out = {7'b0, add_cout, add_sum};
assign sub_out = {7'b0, sub_borrow, sub_diff};
assign mul_out = mul_product;
assign div_out = {div_remainder, div_quotient};

assign DONE        = (OP == 2'b11) ? div_done : 1'b1;
assign DIV_BY_ZERO= (OP == 2'b11) ? div_zero : 1'b0;

/////////////////////
// RTL MUX Select
/////////////////////

mux4_1_rtl MUX (
    .d0(add_out),
    .d1(sub_out),
    .d2(mul_out),
    .d3(div_out),
    .s(OP),
    .y(RESULT)
);

endmodule
