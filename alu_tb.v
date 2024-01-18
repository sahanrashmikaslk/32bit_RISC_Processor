`timescale 1ns / 1ps

module ALU_tb;

// Inputs to the ALU
reg [31:0] acc;
reg [31:0] data;
reg [3:0] opcode;
reg execlk;

// Output from the ALU
wire [31:0] acc1;

// Instantiate the ALU module
ALU uut (
    .acc(acc), 
    .data(data), 
    .opcode(opcode), 
    .execlk(execlk), 
    .acc1(acc1)
);

// Clock generation
initial begin
    execlk = 0;
    forever #5 execlk = ~execlk; // Generate a clock with a period of 10ns
end

// Test sequence
initial begin
    // Initialize Inputs
    acc = 0;
    data = 0;
    opcode = 0;

    // Wait for the global reset
    #100;

    // Test Case 1: ADD
    acc = 32'h00000001; // Operand A
    data = 32'h00000001; // Operand B
    opcode = 4'b0000; // Opcode for ADD
    #10; // Wait for one clock cycle
    
    // Check the result
    if (acc1 !== 32'h00000002) begin
        $display("Test Case 1 Failed: Incorrect result for ADD. Expected 00000002, got %h", acc1);
    end else begin
        $display("Test Case 1 Passed: Correct result for ADD.");
    end
    
    // Test Case 2: SUB
    acc = 32'h00000003;
    data = 32'h00000001;
    opcode = 4'b0001; // Opcode for SUB
    #10; // Wait for one clock cycle
    
    // Check the result
    if (acc1 !== 32'h00000002) begin
        $display("Test Case 2 Failed: Incorrect result for SUB. Expected 00000002, got %h", acc1);
    end else begin
        $display("Test Case 2 Passed: Correct result for SUB.");
    end

    // Add more test cases for other operations...

    // End the simulation
    $finish;
end

endmodule