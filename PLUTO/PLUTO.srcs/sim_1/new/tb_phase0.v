`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.08.2026 16:57:17
// Design Name: 
// Module Name: tb_phase0
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

module tb_phase0;

    reg clk;
    reg rst;
    reg start;

    reg [7:0] query_vector;

    wire [31:0] output_vector;
    wire busy;
    wire done;


    // ------------------------------------------------
    // DUT
    // ------------------------------------------------

    pluto_phase0 dut (
        .clk(clk),
        .rst(rst),
        .start(start),

        .query_vector(query_vector),

        .output_vector(output_vector),
        .busy(busy),
        .done(done)
    );


    // ------------------------------------------------
    // Clock
    // ------------------------------------------------

    always #5 clk = ~clk;


    // ------------------------------------------------
    // Test
    // ------------------------------------------------

    initial begin

        clk = 0;
        rst = 1;
        start = 0;

        // [1 0 1 3]
        //
        // element 0 = 01
        // element 1 = 00
        // element 2 = 01
        // element 3 = 11
        //
        // packed = 11010001 = D1

        query_vector = 8'b11010001;


        // --------------------------------------------
        // Reset
        // --------------------------------------------

        #20;

        rst = 0;

        #10;


        // --------------------------------------------
        // Start pLUTo query
        // --------------------------------------------

        start = 1;

        #10;

        start = 0;


        // --------------------------------------------
        // Wait for completion
        // --------------------------------------------

        wait(done);

        #20;

        $display("--------------------------------");
        $display("FINAL OUTPUT = %h", output_vector);
        $display("--------------------------------");

        $finish;

    end


    // ------------------------------------------------
    // Monitor
    // ------------------------------------------------

    always @(posedge clk) begin

        $display(
            "Time=%0t | start=%b | row=%0d | busy=%b | done=%b | output=%h",
            $time,
            start,
            dut.row_index,
            busy,
            done,
            output_vector
        );

    end

endmodule
