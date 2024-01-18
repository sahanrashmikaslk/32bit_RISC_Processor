module ProgramCounter(
    input wire fetch,  // Positive edge triggered clock input
    input wire incpc,  // Increment PC control signal
    output [27:0] pcout  // 28-bit Program Counter output
);

    // The maximum value for the PC before it resets, assuming the constraint is intentional
    parameter MAX_PC_VALUE = 8'hFF; // 255 in decimal

    // Internal register to hold the Program Counter value
    reg [27:0] pcounter = 28'h0; // Initialize pcounter to 0

    // Reset the Program Counter or increment it based on the control signals
    always @(posedge fetch) begin
        if (pcounter[7:0] == MAX_PC_VALUE && incpc) begin
            // Reset the Program Counter to 0 when it reaches 255 and incpc is high
            pcounter <= 28'h0;
        end else if (incpc) begin
            // Increment the Program Counter if incpc is high
            pcounter <= pcounter + 1'b1;
        end
        // No need for a reset condition here as the fetch clock controls the increment
    end

    // Assign the internal register value to the output
    assign pcout = pcounter;

endmodule
