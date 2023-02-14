module blinky_led (input clk, output led);

    /* 4-bit counter */
    reg [3:0] counter = 0;
    /* led will change state 16 ticks */
    assign led = counter[3];

    /* increment counter on rising edge */
    always @ (posedge clk) begin
        counter <= counter + 1;
    end

endmodule
