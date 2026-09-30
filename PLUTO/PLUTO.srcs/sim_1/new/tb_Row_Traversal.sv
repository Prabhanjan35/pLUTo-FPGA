`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.09.2026 06:01:26
// Design Name: 
// Module Name: tb_Row_Traversal
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


`timescale 1ns / 1ps

module tb_Row_Traversal;

    // Parameters
    parameter integer N          = 4;
    parameter integer DATA_WIDTH = 16;
    parameter integer OUT_WIDTH  = 16;

    // Testbench Signals
    reg                    clk;
    reg                    en;
    reg  [DATA_WIDTH-1:0]  input_array [0:N-1];
    wire [OUT_WIDTH-1:0]   output_array [0:N-1];
    wire                   done;

    // Instantiate Unit Under Test (UUT)
    Row_Traversal #(
        .N(N),
        .DATA_WIDTH(DATA_WIDTH),
        .OUT_WIDTH(OUT_WIDTH)
    ) uut (
        .clk(clk),
        .en(en),
        .input_array(input_array),
        .output_array(output_array),
        .done(done)
    );

    // 100MHz Clock Generation (10ns Period)
    always #5 clk = ~clk;

    // Test Stimulus Process
    initial begin
        // Initialize Signals
        clk = 1;
        en  = 0;
        
        // Provide test data: Notice input_array[0] and input_array[3] share duplicate value 16'h000A
        input_array[0] = 16'hF67A;
        input_array[1] = 16'hFDE2;
        input_array[2] = 16'hFDE3;
        input_array[3] = 16'hF67A;

        $display("=== Starting Row_Traversal Testbench ===");
        
        // Hold reset (en = 0) for 20ns
        #16;
        en = 1; // Enable module execution
        $display("[%0t ns] Module Enabled. Traversal Started...", $time);

        // Wait until module asserts done signal
        wait(done == 1'b1);
        
        // Wait 1 extra clock cycle to display final state cleanly
        @(posedge clk);
        
        $display("\n=== Processing Completed at %0t ns ===", $time);
        $display("Final Output Array Results:");
        for (int idx = 0; idx < N; idx = idx + 1) begin
            $display("  output_array[%0d] = 0x%0h (Input was 0x%0h)", idx, output_array[idx], input_array[idx]);
        end

        $finish;
    end

    // Optional: Real-time Monitor Signal Changes
    initial begin
        $monitor("[%0t ns] en=%b | done=%b | output_array=[%h, %h, %h, %h]", 
                 $time, en, done, output_array[0], output_array[1], output_array[2], output_array[3]);
    end

endmodule
