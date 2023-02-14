module string;

    reg [8*5:1] str = "abcde";
    reg [7:0] char;
    integer i, j, base;

    initial begin

        $display ("%b", str);
        $display ("%s", str);

        for (i = 0; i < 5; i += 1) begin
            base = i*8 + 1;
            for (j = 0; j < 8; j += 1) begin
                char[j] = str[base + j];
            end
            $display ("From: %d To: %d Char: %s %d", base, base+7, char, char);
        end

    end

endmodule
