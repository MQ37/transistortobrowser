`timescale 1ns/1ns

module blinky_led_tb;

    /* create clock and output led signal */
    reg clk;
    wire led;

    /* init module */
    blinky_led l1(clk, led);

    /* start clock 1ns */
    always #1 clk = !clk;

    initial begin
        /* initial clock state */
        clk = 0;

        /* monitor led changes */
        $monitor ("[%t] led: %b", $time, led);

        /* sleep 160 ns
        * should blink 10 times */
        #160

        $finish;
    end

endmodule
