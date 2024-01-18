module MemoryModule(
    input [27:0] address,   // address input (28 bits)
    input [31:0] data,      // Data input (32 bits)
    input wr,               // Write enable signal
    input rd,               // Read enable signal
    input rst,              // Reset enable signal
    output reg [31:0] data1 // Data output (32 bits)
);

    // Define the memory as an array of 256 32-bit words
    reg [31:0] memory [0:255];

    always @(*) begin
        if (rst) begin
            memory[address] <= 32'b0;
        end else if (rd) begin
            data1 <= memory[address];
        end else if (wr) begin
            memory[address] <= data;
        end
    end

endmodule


