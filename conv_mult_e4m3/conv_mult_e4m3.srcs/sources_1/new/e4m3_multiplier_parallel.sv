`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.09.2026 19:42:55
// Design Name: 
// Module Name: e4m3_multiplier_parallel
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


module e4m3_multiplier_parallel #(
    parameter N = 8
)(
    input  logic       clk,
    input  logic       rst,
    input  logic       valid_in,

    input  logic [7:0] a [0:N-1],
    input  logic [7:0] b [0:N-1],

    output logic [7:0] result [0:N-1],
    output logic       valid_out
);

    genvar i;

    generate

        for (i = 0; i < N; i = i + 1) begin : GEN_E4M3_MULT

            e4m3_multiplier u_multiplier (

                .clk       (clk),
                .rst       (rst),
                .valid_in  (valid_in),

                .a         (a[i]),
                .b         (b[i]),

                .result    (result[i]),

                .valid_out ()

            );

        end

    endgenerate



    always_ff @(posedge clk) begin

        if (rst)
            valid_out <= 1'b0;

        else
            valid_out <= valid_in;

    end

endmodule
