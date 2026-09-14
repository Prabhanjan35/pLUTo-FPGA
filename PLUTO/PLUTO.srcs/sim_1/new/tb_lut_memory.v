`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.08.2026 16:41:51
// Design Name: 
// Module Name: tb_lut_memory
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

module tb_lut_memory;

    reg clk;
    reg rd_en;
    reg [1:0] row_index;

    wire [7:0] lut_data;


    // --------------------------------------------
    // Instantiate LUT Memory
    // --------------------------------------------

    pluto_lut_memory #(
        .ROW_W(2),
        .DATA_W(8)
    ) dut (
        .clk(clk),
        .rd_en(rd_en),
        .row_index(row_index),
        .lut_data(lut_data)
    );


    // --------------------------------------------
    // Clock
    // 10 ns period
    // --------------------------------------------

    always #5 clk = ~clk;


    // --------------------------------------------
    // Test sequence
    // --------------------------------------------

    initial begin

        clk       = 0;
        rd_en     = 0;
        row_index = 0;

        #10;

        // Read LUT[0]
        row_index = 2'd0;
        rd_en     = 1;

        #10;

        rd_en = 0;

        #10;

        // Read LUT[1]
        row_index = 2'd1;
        rd_en     = 1;

        #10;

        rd_en = 0;

        #10;

        // Read LUT[2]
        row_index = 2'd2;
        rd_en     = 1;

        #10;

        rd_en = 0;

        #10;

        // Read LUT[3]
        row_index = 2'd3;
        rd_en     = 1;

        #10;

        rd_en = 0;

        #10;

        $finish;

    end


    // --------------------------------------------
    // Console monitor
    // --------------------------------------------

    always @(posedge clk) begin

        $display(
            "Time=%0t | row=%0d | rd_en=%b | lut_data=%0d",
            $time,
            row_index,
            rd_en,
            lut_data
        );

    end

endmodule