`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.08.2026 16:31:02
// Design Name: 
// Module Name: pluto_row_sweep_ctrl
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


module pluto_row_sweep_ctrl #(
    parameter LUT_SIZE = 4,
    parameter ROW_W    = 2
)(
    input  wire             clk,
    input  wire             rst,
    input  wire             start,

    output reg [ROW_W-1:0] row_index,
    output reg             lut_rd_en,
    output reg             capture_en,

    output reg             busy,
    output reg             done
);

    // FSM states
    localparam S_IDLE    = 3'd0;
    localparam S_WAIT    = 3'd1;
    localparam S_CAPTURE = 3'd2;
    localparam S_NEXT    = 3'd3;
    localparam S_DONE    = 3'd4;

    reg [2:0] state;


    always @(posedge clk) begin

        if (rst) begin

            state      <= S_IDLE;
            row_index  <= 0;

            lut_rd_en  <= 1'b0;
            capture_en <= 1'b0;

            busy       <= 1'b0;
            done       <= 1'b0;

        end

        else begin

            // Default values for one-cycle signals
            lut_rd_en  <= 1'b0;
            capture_en <= 1'b0;
            done       <= 1'b0;


            case (state)

                // ------------------------------------
                // IDLE
                // ------------------------------------

                S_IDLE: begin

                    busy      <= 1'b0;
                    row_index <= 0;

                    if (start) begin

                        busy      <= 1'b1;

                        // Request LUT row 0
                        lut_rd_en <= 1'b1;

                        state <= S_WAIT;

                    end

                end


                // ------------------------------------
                // WAIT
                // ------------------------------------

                S_WAIT: begin

                    busy <= 1'b1;

                    // LUT data is available
                    state <= S_CAPTURE;

                end


                // ------------------------------------
                // CAPTURE
                // ------------------------------------

                S_CAPTURE: begin

                    busy <= 1'b1;

                    // Tell FF buffer to capture
                    capture_en <= 1'b1;

                    state <= S_NEXT;

                end


                // ------------------------------------
                // NEXT ROW
                // ------------------------------------

                S_NEXT: begin

                    busy <= 1'b1;

                    if (row_index == LUT_SIZE-1) begin

                        state <= S_DONE;

                    end

                    else begin

                        row_index <= row_index + 1'b1;

                        // Request next LUT row
                        lut_rd_en <= 1'b1;

                        state <= S_WAIT;

                    end

                end


                // ------------------------------------
                // DONE
                // ------------------------------------

                S_DONE: begin

                    busy <= 1'b0;
                    done <= 1'b1;

                    state <= S_IDLE;

                end


                default: begin

                    state <= S_IDLE;

                end

            endcase

        end

    end

endmodule
