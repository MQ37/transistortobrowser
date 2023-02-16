`timescale 1ns/1ns

module uart_tb;

    /* writer clock */
    reg wclk = 0;
    always #1 wclk = !wclk;
    /* reader clock */
    reg rclk = 0;
    always #1 rclk = !rclk;

    /* LSB first */
    reg [7:0] swbus;
    wire [7:0] wbus;
    assign wbus = swbus;
    wire reg wrcv = 0;

    wire [7:0] rbus;
    wire reg rrcv = 1;
    wire rx;
    wire tx;


    /* writer */
    uart #("WRITER") wu (
                .bus(wbus),
                .clk(wclk),
                .rcv(wrcv),
                .rx(rx),
                .tx(tx) );

    /* reader */
    uart #("READER") ru (
                .bus(rbus),
                .clk(rclk),
                .rcv(rrcv),
                .rx(tx),
                .tx(rx) );

    initial begin

        swbus = 8'b11000011;
        /* 20 ticks to exchange 8-bits */
        #20
        $display ("MSG: %b %s", rbus, rbus);

        swbus = 8'b00111100;
        $display ("CHANGED WBUS %t", $realtime);
        #20
        $display ("MSG: %b %s", rbus, rbus);

        swbus = "c";
        #20
        $display ("MSG: %b %s", rbus, rbus);

        $finish;

    end

endmodule
