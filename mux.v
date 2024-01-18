module Multiplexer(
    input wire fetch,      // Control signal for selecting input
    input wire [27:0] irout, // Input 1
    input wire [27:0] pcout, // Input 2
    output wire [27:0] address // Output
);

    assign address = (fetch) ? pcout : irout;

endmodule
