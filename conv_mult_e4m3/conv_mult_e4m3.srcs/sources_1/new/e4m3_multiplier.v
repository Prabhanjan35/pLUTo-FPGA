`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.09.2026 19:26:55
// Design Name: 
// Module Name: e4m3_multiplier
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


module e4m3_multiplier (
    input  logic      clk,
    input  logic       rst,
    input  logic       valid_in,

    input  logic [7:0] a,
    input  logic [7:0] b,

    output logic [7:0] result,
    output logic       valid_out
);

    logic sign_a;
    logic sign_b;

    logic [3:0] exp_a;
    logic [3:0] exp_b;

    logic [2:0] mant_a;
    logic [2:0] mant_b;

    logic sign_result;

    logic [4:0] exp_sum;

    logic [7:0] mant_product;

    logic [3:0] exp_result;
    logic [2:0] mant_result;

    always_comb begin

        sign_a = a[7];
        exp_a  = a[6:3];
        mant_a = a[2:0];

        sign_b = b[7];
        exp_b  = b[6:3];
        mant_b = b[2:0];

        sign_result = sign_a ^ sign_b;


        exp_sum = exp_a + exp_b - 4'd7;


        mant_product =
            {1'b1, mant_a} *
            {1'b1, mant_b};


        exp_result  = exp_sum[3:0];
        mant_result = mant_product[5:3];

        if (mant_product[7]) begin

            exp_result  = exp_sum[3:0] + 1'b1;
            mant_result = mant_product[6:4];

        end

        result = {
            sign_result,
            exp_result,
            mant_result
        };

    end

    always_ff @(posedge clk) begin

        if (rst) begin
            valid_out <= 1'b0;
        end

        else begin
            valid_out <= valid_in;
        end

    end

endmodule
