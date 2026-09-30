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

module Query_Traversal_tb;
    parameter integer N          = 4;
    parameter integer DATA_WIDTH = 16;
    parameter integer OUT_WIDTH  = 16;
    reg                    clk;
    reg                    en;
    reg  [DATA_WIDTH-1:0]  input_array [0:N-1];
    wire [OUT_WIDTH-1:0]   output_array [0:N-1];
    wire                   done;
    Query_Traversal #(
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
    always #5 clk = ~clk;
    initial begin
        clk = 0;
        en  = 0;
        input_array[0] = 16'hF67A;
        input_array[1] = 16'hFDE2;
        input_array[2] = 16'hFDE3;
        input_array[3] = 16'hF67A;
        #17;
        en = 1; 
        $display("[%0t ns] Module Enabled. Traversal Started...", $time);
        wait(done == 1'b1);
        @(posedge clk);
        
        $display("\n=== Processing Completed at %0t ns ===", $time);
        $display("Final Output Array Results:");
        for (int idx = 0; idx < N; idx = idx + 1) begin
            $display("  output_array[%0d] = 0x%0h (Input was 0x%0h)", idx, output_array[idx], input_array[idx]);
        end
        $finish;
    end
    initial begin
        $monitor("[%0t ns] en=%b | done=%b | output_array=[%h, %h, %h, %h]", 
                 $time, en, done, output_array[0], output_array[1], output_array[2], output_array[3]);
    end

endmodule
