`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.09.2026 00:41:44
// Design Name: 
// Module Name: bfloat4_adder_conv
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

module bfloat4_adder_conv (
    input  [3:0] a,
    input  [3:0] b,
    output reg [3:0] sum
);

    reg signed [6:0] qa;
    reg signed [6:0] qb;
    reg signed [7:0] qsum;
    reg signed [7:0] magnitude;

    always @(*) begin

        // ========================================================
        // DECODE A
        //
        // Internal unit = 0.5
        //
        // 0000 =  0
        // 0001 = +0.5
        // 0010 = +1
        // 0011 = +1.5
        // 0100 = +2
        // 0101 = +3
        // 0110 = +4
        // 0111 = +6
        // ========================================================

        case (a)

            4'b0000: qa =  7'sd0;
            4'b0001: qa =  7'sd1;
            4'b0010: qa =  7'sd2;
            4'b0011: qa =  7'sd3;
            4'b0100: qa =  7'sd4;
            4'b0101: qa =  7'sd6;
            4'b0110: qa =  7'sd8;
            4'b0111: qa =  7'sd12;

            // Negative values
            4'b1000: qa =  7'sd0;
            4'b1001: qa = -7'sd1;
            4'b1010: qa = -7'sd2;
            4'b1011: qa = -7'sd3;
            4'b1100: qa = -7'sd4;
            4'b1101: qa = -7'sd6;
            4'b1110: qa = -7'sd8;
            4'b1111: qa = -7'sd12;

            default: qa = 7'sd0;

        endcase


        // ========================================================
        // DECODE B
        // ========================================================

        case (b)

            4'b0000: qb =  7'sd0;
            4'b0001: qb =  7'sd1;
            4'b0010: qb =  7'sd2;
            4'b0011: qb =  7'sd3;
            4'b0100: qb =  7'sd4;
            4'b0101: qb =  7'sd6;
            4'b0110: qb =  7'sd8;
            4'b0111: qb =  7'sd12;

            // Negative values
            4'b1000: qb =  7'sd0;
            4'b1001: qb = -7'sd1;
            4'b1010: qb = -7'sd2;
            4'b1011: qb = -7'sd3;
            4'b1100: qb = -7'sd4;
            4'b1101: qb = -7'sd6;
            4'b1110: qb = -7'sd8;
            4'b1111: qb = -7'sd12;

            default: qb = 7'sd0;

        endcase


        // ========================================================
        // ADD
        // ========================================================

        qsum = qa + qb;


        // ========================================================
        // ZERO
        // ========================================================

        if (qsum == 0) begin

            sum = 4'b0000;

        end


        // ========================================================
        // POSITIVE RESULT
        // ========================================================

        else if (qsum > 0) begin

            magnitude = qsum;

            // 0.5
            if (magnitude == 1) begin
                sum = 4'b0001;
            end

            // 1
            else if (magnitude == 2) begin
                sum = 4'b0010;
            end

            // 1.5
            else if (magnitude == 3) begin
                sum = 4'b0011;
            end

            // 2
            else if (magnitude == 4) begin
                sum = 4'b0100;
            end

            // 2.5 -> round to 2
            else if (magnitude == 5) begin
                sum = 4'b0100;
            end

            // 3
            else if (magnitude == 6) begin
                sum = 4'b0101;
            end

            // 3.5 -> round to 3
            else if (magnitude == 7) begin
                sum = 4'b0101;
            end

            // 4
            else if (magnitude == 8) begin
                sum = 4'b0110;
            end

            // 4.5
            else if (magnitude == 9) begin
                sum = 4'b0110;
            end

            // 5 -> round to 4
            else if (magnitude == 10) begin
                sum = 4'b0110;
            end

            // 5.5 -> round to 6
            else if (magnitude == 11) begin
                sum = 4'b0111;
            end

            // 6 and above -> saturate to 6
            else begin
                sum = 4'b0111;
            end

        end


        // ========================================================
        // NEGATIVE RESULT
        // ========================================================

        else begin

            magnitude = -qsum;

            // -0.5
            if (magnitude == 1) begin
                sum = 4'b1001;
            end

            // -1
            else if (magnitude == 2) begin
                sum = 4'b1010;
            end

            // -1.5
            else if (magnitude == 3) begin
                sum = 4'b1011;
            end

            // -2
            else if (magnitude == 4) begin
                sum = 4'b1100;
            end

            // -2.5 -> round to -2
            else if (magnitude == 5) begin
                sum = 4'b1100;
            end

            // -3
            else if (magnitude == 6) begin
                sum = 4'b1101;
            end

            // -3.5 -> round to -3
            else if (magnitude == 7) begin
                sum = 4'b1101;
            end

            // -4
            else if (magnitude == 8) begin
                sum = 4'b1110;
            end

            // -4.5 -> round to -4
            else if (magnitude == 9) begin
                sum = 4'b1110;
            end

            // -5 -> round to -4
            else if (magnitude == 10) begin
                sum = 4'b1110;
            end

            // -5.5 -> round to -6
            else if (magnitude == 11) begin
                sum = 4'b1111;
            end

            // -6 and below -> saturate to -6
            else begin
                sum = 4'b1111;
            end

        end

    end

endmodule