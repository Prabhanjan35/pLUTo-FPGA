`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.08.2026 16:24:41
// Design Name: 
// Module Name: tb_match_logic
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

module tb_match_logic;

    // ------------------------------------------------
    // Testbench signals
    // ------------------------------------------------

    reg [7:0] query_vector;
    reg [1:0] row_index;

    wire [3:0] match;


    // ------------------------------------------------
    // Instantiate pLUTo Match Logic
    // ------------------------------------------------

    pluto_match_logic #(
        .INDEX_W(2),
        .N(4)
    ) dut (
        .query_vector(query_vector),
        .row_index(row_index),
        .match(match)
    );


    // ------------------------------------------------
    // Test sequence
    // ------------------------------------------------

    initial begin

        // Input vector:
        //
        // [1 0 1 3]
        //
        // element 0 = 1
        // element 1 = 0
        // element 2 = 1
        // element 3 = 3

        query_vector = 8'b11_01_00_01;


        // ==========================================
        // Test row 0
        // ==========================================

        row_index = 2'd0;

        #10;

        $display("Row = %0d, Match = %b",
                 row_index, match);


        // ==========================================
        // Test row 1
        // ==========================================

        row_index = 2'd1;

        #10;

        $display("Row = %0d, Match = %b",
                 row_index, match);


        // ==========================================
        // Test row 2
        // ==========================================

        row_index = 2'd2;

        #10;

        $display("Row = %0d, Match = %b",
                 row_index, match);


        // ==========================================
        // Test row 3
        // ==========================================

        row_index = 2'd3;

        #10;

        $display("Row = %0d, Match = %b",
                 row_index, match);


        // End simulation
        $finish;

    end

endmodule