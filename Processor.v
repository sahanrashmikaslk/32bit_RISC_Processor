module Processor(
    input wire [31:0] data_in,  // 32-bit data input
    input wire execlk1,         // Execution clock
    input wire fetch,           // Fetch clock
    input wire rst1,            // Reset signal
    input wire y,               // Control signal for conditional buffer
    output wire [31:0] data_out // 32-bit data output
);

    // Internal wires to connect modules
    wire [3:0] opcode;
    wire [27:0] irout;
    wire incpc;
    wire ldacc;
    wire ldir;
    wire ldpc;
    wire rd;
    wire wr;
    wire [31:0] acc;
    wire [31:0] acc1;
    wire [31:0] data1;
    wire [27:0] address;
    wire [27:0] pcout;

    // Instantiate modules
    instruction_register IR (
        .rst(rst1),
        .ldir(ldir),
        .data(data_in),
        .opcode(opcode),
        .irout(irout)
    );

    control_unit CU (
        .opcode(opcode),
        .incpc(incpc),
        .ldacc(ldacc),
        .ldir(ldir),
        .ldpc(ldpc),
        .rd(rd),
        .rst(rst1),
        .wr(wr),
        .y(y)
    );

    ALU alu (
        .acc(acc),
        .data(data1),
        .opcode(opcode),
        .execlk(execlk1),
        .acc1(acc1)
    );

    accumulator ACC (
        .execlk(execlk1),
        .ldacc(ldacc),
        .rst(rst1),
        .acc(acc1),
        .acc_out(acc)
    );

    conditional_buffer BUFFER (
        .acc1(acc),
        .y(y),
        .data(data_out)
    );

    MemoryModule MEMORY (
        .address(irout),
        .data(data_in),
        .wr(wr),
        .rd(rd),
        .rst(rst1),
        .data1(data1)
    );

    Multiplexer MUX (
        .fetch(fetch),
        .irout(irout),
        .pcout(pcout),
        .address(address)
    );

    ProgramCounter PC (
        .fetch(fetch),
        .incpc(incpc),
        .pcout(pcout)
    );

endmodule

