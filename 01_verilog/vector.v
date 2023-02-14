module vector;

    reg [7:0] byte;

    initial begin

        /* store 8-bit binary value
        * 8 means 8-bit
        * 'b means binary
        * 100000001 is actual value */
        byte = 8'b10000001;
        $display ("value binary: %b", byte);
        $display ("value decimal: %d", byte);

        /* store 8-bit hex value
        * 8 means 8-bit
        * 'h means binary
        * ff is actual value */
        byte = 8'hff;
        $display ("value binary: %b", byte);
        $display ("value decimal: %d", byte);
    end

endmodule
