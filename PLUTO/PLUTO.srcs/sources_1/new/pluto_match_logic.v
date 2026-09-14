`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.08.2026 16:24:01
// Design Name: 
// Module Name: pluto_match_logic
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


module pluto_match_logic #(
    parameter INDEX_W = 2,
    parameter N       = 4
)(
    input  wire [N*INDEX_W-1:0] query_vector,
    input  wire [INDEX_W-1:0]   row_index,
    output wire [N-1:0]         match
);

    genvar i;

    generate
        for (i = 0; i < N; i = i + 1) begin : MATCH_GEN

            assign match[i] =
                (query_vector[i*INDEX_W +: INDEX_W] == row_index);

        end
    endgenerate

endmodule