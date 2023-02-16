# Verilog basics

Verilog is language for hardware description (HDL), you can describe any hardware you want.

### How to run

Compile verilog files using `iverilog` then run output file. For example for `blinky_led.v` with testbench `blinky_led_tb.v` use following command and run the `led` output file.
```
iverilog blinky_led.v blinky_led_tb.v -o led
```

### Data types

**Possible values:**
- `0` - false, low
- `1` - true, high
- `x` - unknown value (can be `0` or `1`)
- `Z` - high impendance state, not `0` or `1`, but allows small current to flow through

**Data types**
- `wire` - cannot store value on it's own, is used to connect different modules (pieces of hardware), similar to realelectrical wire
- `reg` - similar to hardware registers, holds value between assingments, used as a variable
- `integer` - 32-bit integer
- `time` - unsigned 64-bit, can be used to store simulation time
- `realtime` - stores time as a float
- `real` - float

### Modules

Modules in verilog represent a piece of hardware, they are similar to functions in a programming language, they (may) take some input and (may) give you some output.

**Ports** - ports are set of signals that module interacts with (both input and output), similar to a function arguments

For example this simple module, acting like AND gate, has 3 ports. There is output port `o` and two input ports `x` and `y`. Then we use already built in module `and`, initialize it as `a1` and connect our module output `o` as `a1` output and our two inputs `x`, `y` as `a1` inputs.
```
module test (o, x, y);
    output o;
    input x, y;

    and a1 (o, x ,y);
endmodule
```

To test the module we need to write a test bench, that verifies functionality of this module.
```
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
```

### Vectors

Vectors in verilog are similar to arrays. They can be used to define for example N-bit registers or N-bit wires/connections.
```
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
```

### Sleep

You can delay statements in verilog using `#N`, where N is number of time units to sleep defined using `timescale time_unit/precision`.

```
`timescale 1ns/1ns

...

initial begin

    $display ("Time now is %0t", $realtime);
    /* sleep for 20ns */
    #20
    $display ("Time now is %0t", $realtime);
end
```

### Events

To react to some event, for example clocks rising or falling edge, you can use `always` block. Statements inside the block are executed sequentially on event.

```
`timescale 1ns/1ns

...

reg clk = 0;

/* make clock tick/change value each 1ns (time_unit) */
always #1 clk = !clk;

/* Execute block on rising edge of clk */
always @ (posedge clk) begin
    $display ("Clock is %b at %0t", clk, $realtime);
end

...
```
