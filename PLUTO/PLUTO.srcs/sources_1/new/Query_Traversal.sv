`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.09.2026 11:09:06
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
    output reg                    done,
    output reg [3:0] debug_cascade
);
    wire [DATA_WIDTH-1:0] rom_address;
    wire [3:0]   next_idx;
    reg start;
    reg startbuf;
    reg [3:0] next_idx_comb;
    reg [OUT_WIDTH-1:0] data;
    reg [3:0] visited;
    LUT_mem rom(
        .clka(clk),
        .addra(rom_address),
        .douta(data)
    );
    integer k;
    always @(*) begin
        if (!visited[3])      next_idx_comb = 3;
        else if (!visited[2]) next_idx_comb = 2;
        else if (!visited[1]) next_idx_comb = 1;
        else                  next_idx_comb = 0;
    end
    assign rom_address = input_array[next_idx];
    //always @(negedge clk) begin
        //if (!en) begin
            //next_idx <= {N{1'b0}};
        //end else begin
            //next_idx <= next_idx_comb; 
        //end
    //end
    assign next_idx = next_idx_comb;
    integer i; 
    always @(posedge clk) begin
        if (en) begin
            startbuf <= 1'b1;
        end else begin
            startbuf <= 1'b0;
        end
    end
    always @(negedge clk) begin
        if (startbuf) begin
            start <= 1'b1;
        end else begin
            start <= 1'b0;
        end
    end
    always @(negedge clk) begin
        if (!en) begin
                visited    <= {N{1'b0}};
                done       <= 1'b0;
                for (i = 0; i < N; i = i + 1) begin
                    output_array[i] <= {OUT_WIDTH{1'b0}};
                end
        end else begin
            if (&visited) begin
                done <= 1'b1;
            end
            else begin 
                for (i = 0; i < N; i = i + 1) begin
                    if (input_array[i] == input_array[next_idx]) begin
                        output_array[i] <= data;
                        visited[i]      <= 1'b1;      
                    end
                end
            end
        end
    end
    assign debug_cascade = (!visited[3]) ? 3 : (!visited[2]) ? 2 : (!visited[1]) ? 1 : 0;
endmodule
