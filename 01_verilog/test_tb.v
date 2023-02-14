/* Declare timescale for sleep time_unit/time_precision
* is used as unit in sleep (#)
* #10 -> sleep for 10ns */
`timescale 1ns/1ns

module test_tb;
    /* registers for test inputs */
    reg x, y;
    /* output wire */
    wire out;
    /* initialize the test module */
    test t1(o, x, y);

    /* actual test */
    initial begin
        /* test 0, 0 => 0 */
        #10 y = 0; x = 0;
        #10 $display ("[%t] x: %b y: %b o: %b", $time, x, y, o);
        if (o)
            $display("0, 0 => 0 FAILED");

        /* test 0, 1 => 0 */
        #10 y = 0; x = 1;
        #10 $display ("[%t] x: %b y: %b o: %b", $time, x, y, o);
        if (o)
            $display("0, 1 => 0 FAILED");

        /* test 1, 0 => 0 */
        #10 y = 1; x = 0;
        #10 $display ("[%t] x: %b y: %b o: %b", $time, x, y, o);
        if (o)
            $display("1, 0 => 0 FAILED");

        /* test 1, 1 => 1 */
        #10 y = 1; x = 1;
        #10 $display ("[%t] x: %b y: %b o: %b", $time, x, y, o);
        if (!o)
            $display("1, 1 => 1 FAILED");
    end

endmodule
