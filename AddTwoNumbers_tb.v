`timescale 1ns / 1ns

module Processor_tb;

    // Inputs
    reg [31:0] data_in;
    reg execlk1;
    reg fetch;
    reg rst1;
    reg y;

    // Outputs
    wire [31:0] data_out;

    // Instantiate the Processor module
    Processor uut (
        .data_in(data_in),
        .execlk1(execlk1),
        .fetch(fetch),
        .rst1(rst1),
        .y(y),
        .data_out(data_out)
    );

    // Clock generation
    initial begin
        execlk1 = 0;
        fetch = 0;
        forever begin
            #5 execlk1 = ~execlk1; // Toggle execlk1 every 5 ns
            #7 fetch = ~fetch;     // Toggle fetch every 7 ns to demonstrate two clock domains
        end
    end

    // Test sequence for adding two numbers
    initial begin
        // Initialize Inputs
        data_in = 32'd0;
        rst1 = 1; // Start with reset asserted
        y = 0;    // Disable the conditional buffer output

        // Reset the processor
        #20 rst1 = 0; // Deassert reset
        
        // Simulate loading the first number into the accumulator
        #10 data_in = 32'd10; // Example data for the first number
            y = 1; // Enable the conditional buffer output to load into the accumulator

        // Hold the number in the accumulator
        #10 y = 0; // Disable the buffer to hold the value

        // Simulate loading the second number and performing the addition
        #10 data_in = 32'd20; // Example data for the second number
            y = 1; // Enable the buffer and assume that the ALU is set to perform addition now

        // Hold the result in the accumulator
        #10 y = 0; // Disable the buffer to hold the result

        // Additional delay to observe the result
        #20;

        // Check the result
        if (data_out !== 32'd30) begin
            $display("Test Failed: Incorrect addition result. Expected 30, got %d", data_out);
        end else begin
            $display("Test Passed: Correct addition result. 10 + 20 = %d", data_out);
        end

        // Finish the test
        #100;
        $finish;
    end

endmodule

