module instruction_register(       
    input wire rst,          // Reset signal
    input wire ldir,         // Load instruction signal
    input wire [31:0] data,  // 32-bit instruction input
    output reg [3:0] opcode, // 4-bit opcode output
    output reg [27:0] irout  // 28-bit instruction output
);

always @(posedge rst or posedge ldir) begin
    if (ldir) begin
        // If load instruction signal is asserted, load the data into opcode and irout
        opcode <= data[31:28]; // MSB 4 bits as opcode
        irout <= data[27:0];   // Remaining 28 bits as irout
    end
    else if (rst) begin
        // If reset is asserted, set opcode to all 1's and irout to 0
        opcode <= 4'b1111;
        irout <= 28'b0;
    end  
    // No 'else' statement; retain the current value if neither rst nor ldir is asserted
end

endmodule
