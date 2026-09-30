`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.09.2026 19:32:51
// Design Name: 
// Module Name: tb_e4m3_multiplier
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


`timescale 1ns/1ps

module tb_e4m3_multiplier;

    logic clk;
    logic rst;
    logic valid_in;

    logic [7:0] a;
    logic [7:0] b;

    logic [7:0] result;
    logic valid_out;




    e4m3_multiplier DUT (

        .clk       (clk),
        .rst       (rst),
        .valid_in  (valid_in),

        .a         (a),
        .b         (b),

        .result    (result),
        .valid_out (valid_out)

    );
    
    always #5 clk = ~clk;


    initial begin

        clk      = 0;
        rst      = 1;
        valid_in = 0;

        a = 8'h00;
        b = 8'h00;

        #20;

        rst = 0;

        // 1.0 × 1.0 = 1.0
        //
        // 1.0 = 00111000 = 0x38


        a = 8'h38;
        b = 8'h38;

        valid_in = 1;

        #10;

        valid_in = 0;

        #20;


        // 2.0 × 2.0 = 4.0
        //
        // 2.0 = 01000000 = 0x40
        // 4.0 = 01001000 = 0x48

        a = 8'h40;
        b = 8'h40;

        valid_in = 1;

        #10;

        valid_in = 0;

        #20;


        // 2.0 × 1.0 = 2.0

        a = 8'h40;
        b = 8'h38;

        valid_in = 1;

        #10;

        valid_in = 0;

        #20;


        // 0.5 × 0.5 = 0.25
        //
        // 0.5 = 00110000 = 0x30
        // 0.25 = 00101000 = 0x28
   
        a = 8'h30;
        b = 8'h30;

        valid_in = 1;

        #10;

        valid_in = 0;

        #20;


        $finish;

    end

endmodule