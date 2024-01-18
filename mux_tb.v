`timescale 1ns/1ns

module Multiplexer_tb;

    // Parameters
    parameter CLK_PERIOD = 10; // Clock period in ns

    // Signals
    reg clk;
    reg fetch;
    reg [27:0] irout;
    reg [27:0] pcout;
    wire [27:0] address;

    // Instantiate the module
    Multiplexer uut (
        .fetch(fetch),
        .irout(irout),
        .pcout(pcout),
        .address(address)
    );

    // Clock generation
    always #((CLK_PERIOD / 2)) fetch = ~fetch;

    // Test stimulus
    initial begin
        // Initialize signals
        fetch = 0;
        irout = 28'h12345678;
        pcout = 28'hABCDEF01;

        // Apply stimulus
        #10 fetch = 1;
        #10 fetch = 0;
        #10 fetch = 1;

        // Display header
        $display("Time\tCLK\tFetch\tIRout\tPCout\tAddress");

        // Apply more stimulus and display results
        repeat (20) begin
            #10 irout = irout + 1;
            pcout = pcout + 1;

            $display("%0t\t%d\t%d\t%h\t%h\t%h", $time, clk, fetch, irout, pcout, address);
        end

        // End simulation
        $stop;
    end

endmodule
