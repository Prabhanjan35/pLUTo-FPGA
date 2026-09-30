`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.09.2026 11:04:59
// Design Name: 
// Module Name: Query_Traversal
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


module Query_Traversal #(
    parameter integer N = 4,
    parameter integer DATA_WIDTH = 16,
    parameter integer OUT_WIDTH = 16
)(
    input  wire                   clk,
    input  wire                   en,
    input  wire [DATA_WIDTH-1:0]  input_array [0:N-1],
    output reg  [OUT_WIDTH-1:0]   output_array [0:N-1],
    output reg                    done
);
    reg [DATA_WIDTH-1:0] rom_address;
    reg [N-1:0] visited;
    reg         processing;
    reg [3:0]   next_idx;
    reg [OUT_WIDTH-1:0] data;
    LUT_mem rom(
        .clka(clk),
        .addra(rom_address),
        .douta(data)
    );
    integer k;
    initial next_idx = 4'b0000;
    always @(*) begin
        for (k = N-1; k >= 0; k = k - 1) begin
            if (!visited[k]) begin
                next_idx = k;
            end
        end
    end
    assign rom_address = input_array[next_idx];
    integer i;
    initial visited    <= {N{1'b0}};
    initial done       <= 1'b0;
    initial begin
        for (i = 0; i < N; i = i + 1) begin
           output_array[i] <= {OUT_WIDTH{1'b0}};
        end
    end    
    always @(negedge clk) begin
        if (&visited) begin
                done       <= 1'b1;
        end else begin
            for (i = 0; i < N; i = i + 1) begin
                if (input_array[i] == input_array[next_idx]) begin
                    if (en) begin
                        output_array[i] <= data;
                        visited[i]      <= 1'b1;
                    end
                end
            end
        end
    end
endmodule
