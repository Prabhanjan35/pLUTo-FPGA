`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.08.2026 16:51:47
// Design Name: 
// Module Name: tb_ff_buffer
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




module tb_ff_buffer;

    reg clk;
    reg rst;
    reg capture_en;

    reg [3:0] match;
    reg [7:0] lut_data;

    wire [31:0] output_vector;


    // --------------------------------------------
    // DUT
    // --------------------------------------------

    pluto_ff_buffer #(
        .N(4),
        .DATA_W(8)
    ) dut (
        .clk(clk),
        .rst(rst),
        .capture_en(capture_en),
        .match(match),
        .lut_data(lut_data),
        .output_vector(output_vector)
    );


    // --------------------------------------------
    // Clock
    // --------------------------------------------

    always #5 clk = ~clk;


    // --------------------------------------------
    // Test
    // --------------------------------------------

    initial begin

        clk        = 0;
        rst        = 1;
        capture_en = 0;
        match      = 4'b0000;
        lut_data   = 8'd0;

        // Reset
        #10;
        rst = 0;

        // ----------------------------------------
        // Row 0
        // match = 0010
        // LUT value = 2
        // Expected output = [0,2,0,0]
        // ----------------------------------------

        #10;

        match      = 4'b0010;
        lut_data   = 8'd2;
        capture_en = 1;

        #10;

        capture_en = 0;


        // ----------------------------------------
        // Row 1
        // match = 0101
        // LUT value = 3
        // Expected output = [3,2,3,0]
        // ----------------------------------------

        #10;

        match      = 4'b0101;
        lut_data   = 8'd3;
        capture_en = 1;

        #10;

        capture_en = 0;


        // ----------------------------------------
        // Row 2
        // match = 0000
        // LUT value = 5
        // Nothing should change
        // ----------------------------------------

        #10;

        match      = 4'b0000;
        lut_data   = 8'd5;
        capture_en = 1;

        #10;

        capture_en = 0;


        // ----------------------------------------
        // Row 3
        // match = 1000
        // LUT value = 7
        // Expected output = [3,2,3,7]
        // ----------------------------------------

        #10;

        match      = 4'b1000;
        lut_data   = 8'd7;
        capture_en = 1;

        #10;

        capture_en = 0;

        #20;

        $finish;

    end


    // --------------------------------------------
    // Monitor
    // --------------------------------------------

    always @(posedge clk) begin

        $display(
            "Time=%0t | match=%b | lut_data=%0d | capture=%b | output=%h",
            $time,
            match,
            lut_data,
            capture_en,
            output_vector
        );

    end

endmodule
