module accumulator_tb;

// Inputs
reg execlk;
reg ldacc;
reg rst;
reg [31:0] acc;

// Outputs
wire [31:0] acc_out;

// Instantiate the Unit Under Test (UUT)
accumulator uut (
    .execlk(execlk), 
    .ldacc(ldacc), 
    .rst(rst), 
    .acc(acc), 
    .acc_out(acc_out)
);

initial begin
  
    // Initialize Inputs
    execlk = 0;
    ldacc = 0;
    rst = 0;
    acc = 0;

    // Wait 100 ns for global reset to finish
    #100;
      
    // Add stimulus here
    rst = 1; // Assert reset
    #10;
    rst = 0; // Deassert reset
    #10;
    
    acc = 32'hA5A5A5A5; // Set some test data
    ldacc = 1; // Assert load signal to load data into the accumulator
    #10;
    ldacc = 0; // Deassert load to see if data is held

#10;
acc = 32'h3C3C3C3C; // Change the test data
ldacc = 1; // Load the new test data into the accumulator
#10;
ldacc = 0; // Hold the data in the accumulator

// Add more test cases as needed
end

// Clock generation
always #5 execlk = ~execlk; // Toggle clock every 5ns

endmodule