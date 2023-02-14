module string;
    reg [8*5:0] str = "abcde";

    initial begin

        $display ("%b", str);
        $display ("%s", str);

    end

endmodule
