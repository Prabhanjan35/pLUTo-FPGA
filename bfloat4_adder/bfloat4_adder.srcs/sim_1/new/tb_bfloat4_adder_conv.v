//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.09.2026 00:58:53
// Design Name: 
// Module Name: tb_bfloat4_adder_conv
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


`timescale 1ns / 1ps

module tb_bfloat4_adder_conv;

    reg  [3:0] a;
    reg  [3:0] b;
    reg  [3:0] expected;
    wire [3:0] sum;

    integer errors;

    bfloat4_adder_conv dut (
        .a(a),
        .b(b),
        .sum(sum)
    );

    task test;
        input [3:0] test_a;
        input [3:0] test_b;
        input [3:0] test_expected;

        begin

            a = test_a;
            b = test_b;
            expected = test_expected;

            #10;

            if (sum === expected) begin

                $display(
                    "PASS: A=%b B=%b SUM=%b",
                    a, b, sum
                );

            end

            else begin

                $display(
                    "FAIL: A=%b B=%b EXPECTED=%b ACTUAL=%b",
                    a, b, expected, sum
                );

                errors = errors + 1;

            end

        end
    endtask


    initial begin

        errors = 0;

        $display("");
        $display("==============================================");
        $display("       BFLOAT4 E2M1 ADDER VERIFICATION");
        $display("==============================================");
        $display("");


        // --------------------------------------------------------
        // Basic positive operations
        // --------------------------------------------------------

        test(4'b0000, 4'b0000, 4'b0000); // 0 + 0 = 0

        test(4'b0001, 4'b0001, 4'b0010); // 0.5 + 0.5 = 1

        test(4'b0010, 4'b0010, 4'b0100); // 1 + 1 = 2

        test(4'b0010, 4'b0001, 4'b0011); // 1 + 0.5 = 1.5

        test(4'b0011, 4'b0001, 4'b0100); // 1.5 + 0.5 = 2

        test(4'b0011, 4'b0011, 4'b0101); // 1.5 + 1.5 = 3

        test(4'b0100, 4'b0100, 4'b0110); // 2 + 2 = 4

        test(4'b0101, 4'b0010, 4'b0110); // 3 + 1 = 4


        // --------------------------------------------------------
        // Larger values
        // --------------------------------------------------------

        test(4'b0110, 4'b0010, 4'b0110); // 4 + 1 = 5 -> 4

        test(4'b0110, 4'b0110, 4'b0111); // 4 + 4 = 8 -> 6

        test(4'b0111, 4'b0111, 4'b0111); // 6 + 6 = 12 -> 6

        test(4'b0010, 4'b0111, 4'b0111); // 1 + 6 = 7 -> 6


        // --------------------------------------------------------
        // Positive + negative
        // --------------------------------------------------------

        test(4'b0010, 4'b1010, 4'b0000); // 1 + (-1) = 0

        test(4'b0100, 4'b1010, 4'b0010); // 2 + (-1) = 1

        test(4'b0101, 4'b1010, 4'b0100); // 3 + (-1) = 2

        test(4'b0110, 4'b1010, 4'b0101); // 4 + (-1) = 3

        test(4'b0111, 4'b1010, 4'b0110); // 6 + (-1) = 5 -> 4


        // --------------------------------------------------------
        // Negative + negative
        // --------------------------------------------------------

        test(4'b1010, 4'b1010, 4'b1100); // -1 + -1 = -2

        test(4'b1100, 4'b1100, 4'b1110); // -2 + -2 = -4

        test(4'b1110, 4'b1110, 4'b1111); // -4 + -4 = -8 -> -6

        test(4'b1111, 4'b1111, 4'b1111); // -6 + -6 = -12 -> -6


        // --------------------------------------------------------
        // Mixed ordering
        // --------------------------------------------------------

        test(4'b1010, 4'b0010, 4'b0000); // -1 + 1 = 0

        test(4'b1010, 4'b0100, 4'b0010); // -1 + 2 = 1

        test(4'b1100, 4'b0101, 4'b0010); // -2 + 3 = 1

        test(4'b1110, 4'b0110, 4'b0000);  // -4 + 4 = 0
        

        // --------------------------------------------------------
        // Final result
        // --------------------------------------------------------

        $display("");
        $display("==============================================");

        if (errors == 0) begin
            $display("ALL TESTS PASSED!");
        end
        else begin
            $display("TESTS FAILED = %0d", errors);
        end

        $display("==============================================");
        $display("");

        $finish;

    end

endmodule