`timescale 1ns / 1ps
`timescale 1ns / 1ps

module Row_Sweep_FSM_tb;

    // Inputs
    reg clk;
    reg rst;
    reg start;

    // Outputs
    wire [15:0] row_index;
    wire        lut_rd_en;
    wire        capture_en;
    wire        busy;
    wire        done;

    // Performance Monitoring Variables
    integer cycle_counter;
    integer rd_en_count;
    integer capture_en_count;
    reg     monitoring;

    // Instantiate the Unit Under Test (UUT)
    Row_Sweep_FSM uut (
        .clk(clk),
        .rst(rst),
        .start(start),
        .row_index(row_index),
        .lut_rd_en(lut_rd_en),
        .capture_en(capture_en),
        .busy(busy),
        .done(done)
    );

    // 100 MHz Clock Generation (10ns period)
    always #5 clk = ~clk;

    // Track cycle counts during operation
    always @(posedge clk) begin
        if (rst) begin
            cycle_counter    <= 0;
            rd_en_count      <= 0;
            capture_en_count <= 0;
            monitoring       <= 0;
        end else begin
            if (start) begin
                monitoring       <= 1;
                cycle_counter    <= 0;
                rd_en_count      <= 0;
                capture_en_count <= 0;
            end else if (done) begin
                monitoring       <= 0;
            end

            if (monitoring) begin
                cycle_counter <= cycle_counter + 1;
                if (lut_rd_en)  rd_en_count      <= rd_en_count + 1;
                if (capture_en) capture_en_count <= capture_en_count + 1;
            end
        end
    end

    // Test Sequence
    initial begin
        // Initialize Signals
        clk   = 0;
        rst   = 1;
        start = 0;

        // Apply Reset
        #20;
        rst = 0;
        #20;

        // Trigger FSM Sweep
        @(posedge clk);
        start = 1'b1;
        @(posedge clk);
        start = 1'b0;

        // Wait for Completion
        @(posedge done);

        // Display Cycle Analysis
        $display("\n=========================================");
        $display("          FSM TIMING VERIFICATION        ");
        $display("=========================================");
        $display("Total Cycles (Start to Done) : %0d", cycle_counter);
        $display("Total Read Pulses (lut_rd_en): %0d", rd_en_count);
        $display("Total Captures (capture_en)  : %0d", capture_en_count);
        $display("=========================================");

        // Formal Assertions
        if (rd_en_count == 65536) begin
            $display("[PASS] Correct number of BRAM read requests (65,536).");
        end else begin
            $display("[FAIL] Expected 65,536 read requests, got %0d", rd_en_count);
        end

        if (capture_en_count == 65536) begin
            $display("[PASS] Correct number of captured rows (65,536).");
        end else begin
            $display("[FAIL] Expected 65,536 captures, got %0d", capture_en_count);
        end

        if (cycle_counter == 65538) begin
            $display("[PASS] Total execution latency matched (65,538 cycles).");
        end else begin
            $display("[FAIL] Unexpected total latency: %0d cycles", cycle_counter);
        end

        #50;
        $finish;
    end

endmodule
