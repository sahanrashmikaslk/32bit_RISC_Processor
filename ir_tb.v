`timescale 1ns / 1ns    

module instruction_register_tb;

    // Test Bench Signals
    reg tb_rst;
    reg tb_ldir;
    reg [31:0] tb_data;
    wire [3:0] tb_opcode;
    wire [27:0] tb_irout;

    // Instance of instruction_register
    instruction_register UUT (
        .rst(tb_rst),
        .ldir(tb_ldir),
        .data(tb_data),
        .opcode(tb_opcode),
        .irout(tb_irout)
    );

    // Initial block for test sequence
    initial begin
        // Initialize
        tb_rst = 0; tb_ldir = 0; tb_data = 32'b0;
        
        // Reset the module
        #10 tb_rst = 1; #10 tb_rst = 0;

        // Load instruction
        #10 tb_ldir = 1; tb_data = 32'hAABBCCDD; // Example instruction

        // Check the output
        #10 tb_ldir = 0; // Stop loading data

        // Load another instruction
        #20 tb_ldir = 1; tb_data = 32'h12345678; // Another example instruction

        // End of simulation
        #30 $finish;
    end

    // Monitor changes
    initial begin
        $monitor("Time = %d, Reset = %b, Load = %b, Data = %h, Opcode = %b, IRout = %h", 
                 $time, tb_rst, tb_ldir, tb_data, tb_opcode, tb_irout);
    end

endmodule
