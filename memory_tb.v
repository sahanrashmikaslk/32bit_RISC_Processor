`timescale 1ns / 1ns

module MemoryModule_tb;

    // Test bench signals
    reg [27:0] tb_address;
    reg [31:0] tb_data;
    reg tb_wr, tb_rd, tb_rst;
    wire [31:0] tb_data1;

    // Instantiate the Unit Under Test (UUT)
    MemoryModule uut (
        .address(tb_address),
        .data(tb_data),
        .wr(tb_wr),
        .rd(tb_rd),
        .rst(tb_rst),
        .data1(tb_data1)
    );

    // Test cases
    initial begin
        // Initialize Inputs
        tb_address = 0;
        tb_data = 0;
        tb_wr = 0;
        tb_rd = 0;
        tb_rst = 1;

        // Wait 100 ns for global reset
        #100;
        tb_rst = 0;

        // Write data
        tb_address = 5;
        tb_data = 32'hA5A5A5A5;
        tb_wr = 1;
        #10;
        tb_wr = 0;

        // Read data
        #10;
        tb_rd = 1;
        #10;
        tb_rd = 0;

        // Reset and read again
        #10;
        tb_rst = 1;
        #10;
        tb_rst = 0;
        tb_rd = 1;
        #10;
        tb_rd = 0;

        // Add more test cases as needed

        // End of test message
        #10;
        $display("Test completed");
        $finish;
    end
      
endmodule
