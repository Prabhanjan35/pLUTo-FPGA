`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.09.2026 01:56:40
// Design Name: 
// Module Name: top
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


module top(
    input clk,
    input en,
    output done,
    output [3:0] visited
    );
    wire [63:0] in_vio;
    wire [15:0] in_query [0:3];
    assign in_query[0] = in_vio[63:48];
    assign in_query[1] = in_vio[47:32];
    assign in_query[2] = in_vio[31:16];
    assign in_query[3] = in_vio[15:0];
    wire [63:0] out_vio;
    wire [15:0] out_query [0:3];
    assign out_vio[63:48] = out_query[0];
    assign out_vio[47:32] = out_query[1];
    assign out_vio[31:16] = out_query[2];
    assign out_vio[15:0] = out_query[3];
    Query_Traversal q1(clk,en,in_query,out_query,done,visited);
    vio_0 v1(clk,out_vio,in_vio);
endmodule
