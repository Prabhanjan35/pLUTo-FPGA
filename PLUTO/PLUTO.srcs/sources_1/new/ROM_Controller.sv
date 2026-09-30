`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.09.2026 22:02:39
// Design Name: 
// Module Name: ROM_Controller
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

module ROM_Controller(
    input Clk,
    input En,
    output wire signed [23:0] Out
    );
    reg [15:0] ram_address;
    reg [7:0] count;
    always @(posedge Clk) begin
        if (!En) begin
            ram_address <= 8'd0;
            count <= 8'd0;
        end
        else begin
            count <= count + 1'b1;
            if (ram_address < 8'd218 && count > 8'd14 && count < 8'd231) begin
                ram_address<=ram_address+1'b1;
            end
            else begin
                ram_address <= 8'd0;
            end
        end
    end
   LUT_mem rom(
        .clka(Clk),
        .addra(ram_address),
        .douta(Out)
    );
endmodule
