`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.08.2026 16:39:59
// Design Name: 
// Module Name: pluto_lut_memory
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

module pluto_lut_memory #(
    parameter ROW_W  = 2,
    parameter DATA_W = 8
)(
    input  wire             clk,
    input  wire             rd_en,
    input  wire [ROW_W-1:0] row_index,

    output reg [DATA_W-1:0] lut_data
);

    // --------------------------------------------
    // LUT storage
    // --------------------------------------------

    reg [DATA_W-1:0] lut [0:3];


    // --------------------------------------------
    // Initialize LUT
    //
    // LUT:
    // 0 -> 2
    // 1 -> 3
    // 2 -> 5
    // 3 -> 7
    // --------------------------------------------

    initial begin

        lut[0] = 8'd2;
        lut[1] = 8'd3;
        lut[2] = 8'd5;
        lut[3] = 8'd7;

    end


    // --------------------------------------------
    // LUT read
    // --------------------------------------------

    always @(posedge clk) begin

        if (rd_en) begin

            lut_data <= lut[row_index];

        end

    end

endmodule