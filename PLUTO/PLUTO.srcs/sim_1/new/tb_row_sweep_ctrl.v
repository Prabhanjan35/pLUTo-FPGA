`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.08.2026 16:31:52
// Design Name: 
// Module Name: tb_row_sweep_ctrl
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



module tb_row_sweep_ctrl;

    reg clk;
    reg rst;
    reg start;

    wire [1:0] row_index;
    wire lut_rd_en;
    wire capture_en;
    wire busy;
    wire done;


    // --------------------------------------------
    // DUT
    // --------------------------------------------

    pluto_row_sweep_ctrl #(
        .LUT_SIZE(4),
        .ROW_W(2)
    )
    dut (
        .clk(clk),
        .rst(rst),
        .start(start),

        .row_index(row_index),
        .lut_rd_en(lut_rd_en),
        .capture_en(capture_en),

        .busy(busy),
        .done(done)
    );


    // --------------------------------------------
    // Clock
    // --------------------------------------------

    always #5 clk = ~clk;


    // --------------------------------------------
    // Test
    // --------------------------------------------

    initial begin

        clk   = 0;
        rst   = 1;
        start = 0;

        // Reset
        #20;

        rst = 0;

        #10;

        // Start pLUTo LUT query
        start = 1;

        #10;

        start = 0;


        // Wait for completion
        wait(done);

        #20;

        $finish;

    end


    // --------------------------------------------
    // Monitor
    // --------------------------------------------

    always @(posedge clk) begin

        $display(
            "Time=%0t | State signals | row=%0d | read=%b | capture=%b | busy=%b | done=%b",
            $time,
            row_index,
            lut_rd_en,
            capture_en,
            busy,
            done
        );

    end

endmodule