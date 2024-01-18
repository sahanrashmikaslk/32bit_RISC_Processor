module control_unit(
    input wire [3:0] opcode, // 4-bit opcode input
    output reg incpc,        // Signal to increment program counter
    output reg ldacc,        // Control signal for accumulator
    output reg ldir,         // Control signal for instruction register
    output reg ldpc,         // Control signal for program counter
    output reg rd,           // Read signal
    output reg rst,          // Reset signal
    output reg wr,           // Write signal
    output reg y             // Additional control signal
);

always @(*) begin
    // Default values for control signals
    incpc = 0;
    ldacc = 0;
    ldir = 0;
    ldpc = 0;
    rd = 0;
    rst = 0;
    wr = 0;
    y = 0;
    
    case (opcode)
        4'b1011: begin
            incpc = 1; // Signal to increment program counter
        end
        4'b1110: begin
            y = 1;     // Set y
            rd = 0;    // Set read to 0
            wr = 1;    // Set write to 1
        end
        // Add additional cases for other opcodes
        default: begin
            // Default case, if needed
        end
    endcase
end

endmodule