`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.08.2026 16:50:49
// Design Name: 
// Module Name: pluto_ff_buffer
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


module pluto_ff_buffer #(
    parameter N       = 4,
    parameter DATA_W  = 8
)(
    input wire                 clk,
    input wire                 rst,
    input wire                 capture_en,

    input wire [N-1:0]         match,
    input wire [DATA_W-1:0]   lut_data,

    output reg [N*DATA_W-1:0] output_vector
);

    integer i;

    always @(posedge clk) begin

        if (rst) begin

            output_vector <= 0;

        end

        else if (capture_en) begin

            for (i = 0; i < N; i = i + 1) begin

                if (match[i]) begin

                    output_vector[i*DATA_W +: DATA_W]
                        <= lut_data;

                end

            end

        end

    end

endmodule
