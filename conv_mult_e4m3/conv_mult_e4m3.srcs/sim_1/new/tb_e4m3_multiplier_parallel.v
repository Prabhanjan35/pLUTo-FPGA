`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.09.2026 19:45:31
// Design Name: 
// Module Name: tb_e4m3_multiplier_parallel
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


`timescale 1ns/1ps

module tb_e4m3_multiplier_parallel;

    parameter N = 8;

    logic clk;
    logic rst;
    logic valid_in;

    logic [7:0] a [0:N-1];
    logic [7:0] b [0:N-1];

    logic [7:0] result [0:N-1];

    logic valid_out;


    // ============================================
    // DUT
    // ============================================

    e4m3_multiplier_parallel #(
        .N(N)
    ) DUT (

        .clk       (clk),
        .rst       (rst),
        .valid_in  (valid_in),

        .a         (a),
        .b         (b),

        .result    (result),

        .valid_out (valid_out)

    );


    // ============================================
    // Clock
    // ============================================

    always #5 clk = ~clk;


    // ============================================
    // Test
    // ============================================

    initial begin

        clk      = 0;
        rst      = 1;
        valid_in = 0;

        // Clear inputs

        for (int i = 0; i < N; i++) begin
            a[i] = 8'h00;
            b[i] = 8'h00;
        end


        #20;

        rst = 0;


        // ========================================
        // 8 PARALLEL MULTIPLICATIONS
        // ========================================

        // 1.0 × 1.0 = 1.0

        a[0] = 8'h38;
        b[0] = 8'h38;


        // 2.0 × 2.0 = 4.0

        a[1] = 8'h40;
        b[1] = 8'h40;


        // 2.0 × 1.0 = 2.0

        a[2] = 8'h40;
        b[2] = 8'h38;


        // 0.5 × 0.5 = 0.25

        a[3] = 8'h30;
        b[3] = 8'h30;


        // 1.0 × 2.0 = 2.0

        a[4] = 8'h38;
        b[4] = 8'h40;


        // 4.0 × 2.0 = 8.0

        a[5] = 8'h48;
        b[5] = 8'h40;


        // 0.5 × 2.0 = 1.0

        a[6] = 8'h30;
        b[6] = 8'h40;


        // 4.0 × 4.0 = 16.0

        a[7] = 8'h48;
        b[7] = 8'h48;


        // Assert valid

        valid_in = 1;

        #10;

        valid_in = 0;

        #30;

        $finish;

    end

endmodule
