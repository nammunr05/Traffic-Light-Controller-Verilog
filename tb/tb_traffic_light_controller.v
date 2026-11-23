`timescale 1ns/1ps

module tb_traffic_light_controller;

    reg clk;
    reg reset;

    wire ns_red, ns_yellow, ns_green;
    wire ew_red, ew_yellow, ew_green;

    integer errors;

    traffic_light_controller dut (
        .clk(clk),
        .reset(reset),
        .ns_red(ns_red),
        .ns_yellow(ns_yellow),
        .ns_green(ns_green),
        .ew_red(ew_red),
        .ew_yellow(ew_yellow),
        .ew_green(ew_green)
    );

    // 10 ns clock period
    always #5 clk = ~clk;

    task check_state;
        input [8*30-1:0] state_name;
        input expected_ns_red;
        input expected_ns_yellow;
        input expected_ns_green;
        input expected_ew_red;
        input expected_ew_yellow;
        input expected_ew_green;
        begin
            #1;
            if ({ns_red, ns_yellow, ns_green,
                 ew_red, ew_yellow, ew_green} !==
                {expected_ns_red, expected_ns_yellow,
                 expected_ns_green, expected_ew_red,
                 expected_ew_yellow, expected_ew_green}) begin

                $display("FAIL: %0s", state_name);
                $display("Actual:   %b%b%b %b%b%b",
                    ns_red, ns_yellow, ns_green,
                    ew_red, ew_yellow, ew_green);
                errors = errors + 1;
            end else begin
                $display("PASS: %0s", state_name);
            end
        end
    endtask

    initial begin
        clk = 0;
        reset = 0;
        errors = 0;

        $dumpfile("waveforms/traffic_light.vcd");
        $dumpvars(0, tb_traffic_light_controller);

        // Apply reset
        reset = 1;
        #2;
        check_state("Reset - NS Green",
                    0, 0, 1, 1, 0, 0);

        // Release reset and test all four states
        reset = 0;

        @(posedge clk);
        check_state("NS Yellow", 0, 1, 0, 1, 0, 0);

        @(posedge clk);
        check_state("EW Green", 1, 0, 0, 0, 0, 1);

        @(posedge clk);
        check_state("EW Yellow", 1, 0, 0, 0, 1, 0);

        @(posedge clk);
        check_state("Cycle back - NS Green",
                    0, 0, 1, 1, 0, 0);

        // Test reset from another state
        @(posedge clk);
        #1;
        reset = 1;
        #1;
        check_state("Reset during operation",
                    0, 0, 1, 1, 0, 0);
        reset = 0;

        if (errors == 0)
            $display("\nALL TESTS PASSED!");
        else
            $display("\nTESTS FAILED: %0d error(s)", errors);

        $finish;
    end

endmodule
