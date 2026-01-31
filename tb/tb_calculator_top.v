`timescale 1ns/1ps

module tb_calculator_top;

reg        clk;
reg        start;
reg  [7:0] A, B;
reg  [1:0] OP;

wire [15:0] RESULT;
wire        DONE;
wire        DIV_BY_ZERO;

// DUT
calculator_top DUT (
    .A(A),
    .B(B),
    .OP(OP),
    .clk(clk),
    .start(start),
    .RESULT(RESULT),
    .DONE(DONE),
    .DIV_BY_ZERO(DIV_BY_ZERO)
);

/////////////////////
// Clock Generator
/////////////////////
always #5 clk = ~clk; // 10ns period

initial begin
    clk = 0;
    start = 0;
    A = 0;
    B = 0;
    OP = 0;

    $display("Time | OP |   A   B | RESULT | DONE Z");
    $display("-------------------------------------");

    // ADD: 10 + 5
    #10;
    A = 8'd10; B = 8'd5; OP = 2'b00;
    #10;
    $display("%4t | ADD | %3d %3d | %6d |  %b   %b",
              $time, A, B, RESULT, DONE, DIV_BY_ZERO);

    // SUB: 10 - 5
    #10;
    A = 8'd10; B = 8'd5; OP = 2'b01;
    #10;
    $display("%4t | SUB | %3d %3d | %6d |  %b   %b",
              $time, A, B, RESULT, DONE, DIV_BY_ZERO);

    // MUL: 10 * 5
    #10;
    A = 8'd10; B = 8'd5; OP = 2'b10;
    #10;
    $display("%4t | MUL | %3d %3d | %6d |  %b   %b",
              $time, A, B, RESULT, DONE, DIV_BY_ZERO);

    // DIV: 13 / 4
    #10;
    A = 8'd13; B = 8'd4; OP = 2'b11;
    start = 1; #10; start = 0;
    wait(DONE);
    $display("%4t | DIV | %3d %3d | %6d |  %b   %b",
              $time, A, B, RESULT, DONE, DIV_BY_ZERO);

    // DIV by zero test
    #20;
    A = 8'd20; B = 8'd0; OP = 2'b11;
    start = 1; #10; start = 0;
    wait(DONE);
    $display("%4t | DIV | %3d %3d | %6d |  %b   %b",
              $time, A, B, RESULT, DONE, DIV_BY_ZERO);

    $finish;
end

endmodule
