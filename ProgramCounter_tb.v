module tb_ProgramCounter;

    // Define parameters
    parameter CLOCK_PERIOD = 10; // Clock period in time units
    parameter SIM_TIME = 100;    // Simulation time in time units

    // Signals for connecting to the ProgramCounter module
    reg fetch;
    reg incpc;
    reg [27:0] pcout; // Initial value of pcout

    // Clock generation
    reg clk = 0;
    always #((CLOCK_PERIOD / 2)) clk = ~clk;

    // Instantiate the ProgramCounter module
    ProgramCounter pc (
        .fetch(fetch),
        .incpc(incpc),
        .pcout(pcout)
    );

    // Test stimulus
    initial begin
        // Initialize inputs
        fetch = 0;
        incpc = 0;
        // Set initial value for pcout
        pcout = 28'h0;

        // Apply initial values
        #5 fetch = 1;
        #5 incpc = 1;

        // Simulate for SIM_TIME time units
        repeat (SIM_TIME) begin
            #1;
        end

        // Finish the simulation
        $finish;
    end

    // Display PC value
    always @(posedge clk) begin
        $display("PC: %h", pcout);
    end

endmodule
