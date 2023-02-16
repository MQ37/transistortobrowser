module uart
            #(parameter name="UART")
            (
                inout [7:0] bus,
                input clk,
                input rcv,
                input rx,
                output tx
            );

    reg [7:0] mem;
    reg [2:0] counter = 0;
    reg stx = 1;

    /* is exchange in progress */
    reg ex = 0;
    /* wait one clock */
    reg lock = 0;

    assign tx = stx;

    /* when receiving output mem to bus */
    assign bus = (rcv) ? mem : 8'bZ;

    always @ (posedge clk) begin
        /* if not receiving and
        * locked and
        * exchanging
        * then unlock for writing */
        if (!rcv && lock && ex) begin
            lock = 0;
            $display (
                "(%s) [%0t] unlocked",
                name, $realtime
            );
        end


        /* if not reading and
        * not exchanging and
        * not lock
        * then start exchange */
        if (!rcv && !ex && !lock) begin
            ex = 1;
            /* signal start of exchange to reader */
            stx = 0;
            /* wait one cycle */
            lock = 1;
            $display (
                "(%s) [%0t] starting write exchange rcv: %b ex: %b lock: %b",
                name, $realtime,
                rcv, ex, lock
            );
        end

        /* if not receiving and
        * exchanging and
        * not locked
        * then write */
        if (!rcv && ex && !lock) begin
            stx = bus[counter];
            counter = counter + 1;
            $display (
                "(%s) [%0t] wrote tx: %b",
                name, $realtime,
                stx
            );
        end

        /* signal end of exchange */
        if (!rcv && lock && !ex) begin
            stx = 1;
            lock = 0;
            $display (
                "(%s) [%0t] signaling end of exchange tx: %b",
                name, $realtime,
                stx
            );
        end

        /* if not receiving and
        * exchanging and
        * not locked and
        * counter overflowed
        * then reset */
        if (!rcv && ex && !lock && counter == 3'b000) begin
            ex = 0;
            lock = 1;
            $display (
                "(%s) [%0t] reset ex: %b lock %b",
                name, $realtime,
                ex, lock
            );
        end


    end

    always @ (negedge clk) begin
        /* unlock for reading */
        if (rcv && lock && ex) begin
            lock = 0;
            $display (
                "(%s) [%0t] unlocked",
                name, $realtime
            );
        end

        /* start reading exchange */
        if (rcv && !ex && !lock && rx == 0) begin
            ex = 1;
            /* wait one cycle */
            lock = 1;
            $display (
                "(%s) [%0t] starting read exchange rcv: %b ex: %b lock: %b rx: %b",
                name, $realtime,
                rcv, ex, lock, rx
            );
        end

        /* if reading and
        * exchange and
        * not locked
        * then read */
        if (rcv && ex && !lock) begin
            mem[counter] = rx;
            counter = counter + 1;
            $display (
                "(%s) [%0t] received rx: %b",
                name, $realtime,
                rx
            );
        end

        /* signal end of exchange */
        if (rcv && lock && !ex && rx) begin
            lock = 0;
            $display (
                "(%s) [%0t] received end of exchange rx: %b",
                name, $realtime,
                rx
            );
        end

        /* reset */
        if (rcv && ex && !lock && counter == 3'b000) begin
            ex = 0;
            lock = 1;
            $display (
                "(%s) [%0t] reset ex: %b lock %b",
                name, $realtime,
                ex, lock
            );
        end
    end
endmodule
