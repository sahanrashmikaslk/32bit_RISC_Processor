`timescale 1ns / 1ps

module conditional_buffer_tb;

// Inputs to the conditional buffer
reg [31:0] acc1;
reg y;

// Output from the conditional buffer
wire [31:0] data;

// Instantiate the Unit Under Test (UUT)
conditional_buffer uut (
    .acc1(acc1), 
    .y(y), 
    .data(data)
);

initial begin
    // Initialize Inputs
    acc1 = 32'hAAAAAAAA; // Some arbitrary test data
    y = 0; // Initially, 'y' is low, so 'data' should be high-impedance

    // Wait for 100 ns
    #100;
    
    // Check if data is high-impedance when y is 0
    if (data !== 32'bz) begin
        $display("Test Failed: Data should be high-impedance when y is 0.");
    end else begin
        $display("Test Passed: Data is high-impedance when y is 0.");
    end

    // Set 'y' high to enable output
    y = 1; #10;

    // Check if data equals acc1 when y is 1
    if (data !== acc1) begin
        $display("Test Failed: Data should equal acc1 when y is 1.");
    end else begin
        $display("Test Passed: Data equals acc1 when y is 1.");
    end

    // End of Tests
    $finish;
end

endmodule
