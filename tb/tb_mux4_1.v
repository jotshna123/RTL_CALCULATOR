`timescale 1ns/1ps

module tb_mux4_1;

reg  [15:0] d0, d1, d2, d3;
reg  [1:0]  s;
wire [15:0] y;

// DUT — change module name if testing gate-level version
mux4_1_rtl DUT (
    .d0(d0),
    .d1(d1),
    .d2(d2),
    .d3(d3),
    .s(s),
    .y(y)
);

initial begin
    $display("Time |  SEL |    Y");
    $display("-----------------------");

    // Set known patterns
    d0 = 16'h000A; // 10
    d1 = 16'h0014; // 20
    d2 = 16'h001E; // 30
    d3 = 16'h0028; // 40

    s = 2'b00; #10;
    $display("%4t |  %b  | %4d", $time, s, y);

    s = 2'b01; #10;
    $display("%4t |  %b  | %4d", $time, s, y);

    s = 2'b10; #10;
    $display("%4t |  %b  | %4d", $time, s, y);

    s = 2'b11; #10;
    $display("%4t |  %b  | %4d", $time, s, y);

    $finish;
end

endmodule
