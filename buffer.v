module conditional_buffer(
    input wire [31:0] acc1,  // Input data
    input wire y,            // Control signal
    output wire [31:0] data  // Output data
);

assign data = y ? acc1 : 32'bz;  // Conditional output based on 'y'

endmodule
