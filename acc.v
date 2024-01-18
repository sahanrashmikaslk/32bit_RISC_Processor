// Code your design here
module accumulator(
    input wire execlk,    // Clock input
    input wire ldacc,     // Load signal
    input wire rst,       // Reset signal
    input wire [31:0] acc,  // Input data
    output reg [31:0] acc_out  // Output data
);

always @(posedge execlk or posedge rst) begin
    if (rst) begin
        // Synchronous reset to zero
        acc_out <= 32'b0;
    end else if (ldacc) begin
        // Load the input into the accumulator when load signal is high
        acc_out <= acc;
    end
    // Else, retain the current value, effectively making this a register
end

endmodule
