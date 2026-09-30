`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.09.2026 11:02:21
// Design Name: 
// Module Name: Row_Sweep_FSM
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


module unique_array_processor #(
    parameter integer N = 4,
    parameter integer DATA_WIDTH = 4,
    parameter integer OUT_WIDTH = 4
)(
    input  wire                   clk,
    input  wire                   rst_n,
    input  wire                   start,
    input  wire [DATA_WIDTH-1:0]  input_array [0:N-1],
    output reg  [OUT_WIDTH-1:0]   output_array [0:N-1],
    output reg                    done
);

    reg [N-1:0] visited;
    reg         processing;
    reg [3:0]   next_idx;

    // Combinational helper to find the next unvisited index (enables skipping duplicates)
    integer k;
    always @(*) begin
        next_idx = 0;
        for (k = N-1; k >= 0; k = k - 1) begin
            if (!visited[k]) begin
                next_idx = k;
            end
        end
    end

    // Example mapping function based on your requirement (3->1, 4->8, 2->9)
    function [OUT_WIDTH-1:0] compute_output(input [DATA_WIDTH-1:0] val);
        begin
            case (val)
                4'd3:    compute_output = 4'd1;
                4'd4:    compute_output = 4'd8;
                4'd2:    compute_output = 4'd9;
                default: compute_output = 4'd0;
            endcase
        end
    endfunction

    integer i;
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            visited    <= {N{1'b0}};
            done       <= 1'b0;
            processing <= 1'b0;
            for (i = 0; i < N; i = i + 1) begin
                output_array[i] <= {OUT_WIDTH{1'b0}};
            end
        end else begin
            if (start && !processing) begin
                visited    <= {N{1'b0}};
                done       <= 1'b0;
                processing <= 1'b1;
            end else if (processing) begin
                if (&visited) begin
                    processing <= 1'b0;
                    done       <= 1'b1;
                end else begin
                    // Broadcast the mapped output to all indices matching the current unique element
                    for (i = 0; i < N; i = i + 1) begin
                        if (input_array[i] == input_array[next_idx]) begin
                            output_array[i] <= compute_output(input_array[next_idx]);
                            visited[i]      <= 1'b1;
                        end
                    end
                end
            end
        end
    end

endmodule