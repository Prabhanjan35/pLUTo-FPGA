`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.09.2026 19:31:42
// Design Name: 
// Module Name: e3m4_multiplication
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
    input  logic       clk,
    input  logic       rst,
    input  logic       valid_in,

    input  logic [7:0] a,
    input  logic [7:0] b,

    output logic [7:0] result,
    output logic       valid_out
);

   

    logic       sign_a;
    logic       sign_b;

    logic [3:0] exp_a;
    logic [3:0] exp_b;

    logic [2:0] frac_a;
    logic [2:0] frac_b;

    logic       sign_result;

    logic [4:0] exponent_sum;

    logic [3:0] mantissa_a;
    logic [3:0] mantissa_b;

    logic [7:0] mantissa_product;

    logic [4:0] exponent_normalized;

    logic [2:0] fraction_result;



    always_comb begin


        sign_a = a[7];
        exp_a  = a[6:3];
        frac_a = a[2:0];


    
        sign_b = b[7];
        exp_b  = b[6:3];
        frac_b = b[2:0];


     
        sign_result = sign_a ^ sign_b;



        mantissa_a = {1'b1, frac_a};
        mantissa_b = {1'b1, frac_b};


        mantissa_product =
            mantissa_a * mantissa_b;

        exponent_sum =
            exp_a + exp_b - 5'd7;

        if (mantissa_product[7]) begin


            exponent_normalized =
                exponent_sum + 1'b1;

            fraction_result =
                mantissa_product[6:4];

        end
        else begin


            exponent_normalized =
                exponent_sum;

            fraction_result =
                mantissa_product[5:3];

        end


        result = {
            sign_result,
            exponent_normalized[3:0],
            fraction_result
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