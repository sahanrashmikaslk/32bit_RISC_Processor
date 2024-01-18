`timescale 1ns / 1ps

module control_unit_tb;

// Input
reg [3:0] opcode;

// Outputs
wire incpc;
wire ldacc;
wire ldir;
wire ldpc;
wire rd;
wire rst;
wire wr;
wire y;

// Instantiate the Unit Under Test (UUT)
control_unit uut (
    .opcode(opcode), 
    .incpc(incpc),
    .ldacc(ldacc),
    .ldir(ldir),
    .ldpc(ldpc),
    .rd(rd),
    .rst(rst),
    .wr(wr),
    .y(y)
);

initial begin
    // Initialize Inputs
    opcode = 4'b0000;

    // Wait 100 ns for global reset to finish
    #100;
      
    // Test Case: opcode = 1011
    opcode = 4'b1011; #10;
    if (incpc !== 1'b1) begin
        $display("Test Case 1011 Failed: incpc should be 1.");
    end else begin
        $display("Test Case 1011 Passed.");
    end

    // Test Case: opcode = 1110
    opcode = 4'b1110; #10;
    if (y !== 1'b1 || rd !== 1'b0 || wr !== 1'b1) begin
        $display("Test Case 1110 Failed: y should be 1, rd should be 0, wr should be 1.");
    end else begin
        $display("Test Case 1110 Passed.");
    end

    // More test cases should be added here for other opcodes and expected outputs.

    // End of Tests
    $finish;
end

endmodule
