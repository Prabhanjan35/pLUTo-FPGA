`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.08.2026 16:56:06
// Design Name: 
// Module Name: pluto_phase0
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



module pluto_phase0 #(
    parameter N      = 4,
    parameter ROW_W  = 2,
    parameter DATA_W = 8
)(
    input  wire                 clk,
    input  wire                 rst,
    input  wire                 start,

    input  wire [N*2-1:0]       query_vector,

    output wire [N*DATA_W-1:0]  output_vector,
    output wire                 busy,
    output wire                 done
);

    // ------------------------------------------------
    // Internal signals
    // ------------------------------------------------

    wire [ROW_W-1:0] row_index;

    wire             lut_rd_en;
    wire             capture_en;

    wire [N-1:0]     match;

    wire [DATA_W-1:0] lut_data;


    // ------------------------------------------------
    // 1. Row Sweep Controller
    // ------------------------------------------------

    pluto_row_sweep_ctrl #(
        .LUT_SIZE(4),
        .ROW_W(ROW_W)
    ) row_controller (
        .clk(clk),
        .rst(rst),
        .start(start),

        .row_index(row_index),
        .lut_rd_en(lut_rd_en),
        .capture_en(capture_en),

        .busy(busy),
        .done(done)
    );


    // ------------------------------------------------
    // 2. Match Logic
    // ------------------------------------------------

    pluto_match_logic match_unit (
        .query_vector(query_vector),
        .row_index(row_index),
        .match(match)
    );


    // ------------------------------------------------
    // 3. LUT Memory
    // ------------------------------------------------

    pluto_lut_memory #(
        .ROW_W(ROW_W),
        .DATA_W(DATA_W)
    ) lut_memory (
        .clk(clk),
        .rd_en(lut_rd_en),
        .row_index(row_index),

        .lut_data(lut_data)
    );


    // ------------------------------------------------
    // 4. FF Buffer
    // ------------------------------------------------

    pluto_ff_buffer #(
        .N(N),
        .DATA_W(DATA_W)
    ) result_buffer (
        .clk(clk),
        .rst(rst),
        .capture_en(capture_en),

        .match(match),
        .lut_data(lut_data),

        .output_vector(output_vector)
    );

endmodule
