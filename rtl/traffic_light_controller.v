`timescale 1ns/1ps

module traffic_light_controller (
    input  wire clk,
    input  wire reset,

    output reg ns_red,
    output reg ns_yellow,
    output reg ns_green,

    output reg ew_red,
    output reg ew_yellow,
    output reg ew_green
);

    // State encoding
    localparam S0_NS_GREEN  = 2'b00;
    localparam S1_NS_YELLOW = 2'b01;
    localparam S2_EW_GREEN  = 2'b10;
    localparam S3_EW_YELLOW = 2'b11;

    reg [1:0] state;

    // State transition logic
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= S0_NS_GREEN;
        else begin
            case (state)
                S0_NS_GREEN:  state <= S1_NS_YELLOW;
                S1_NS_YELLOW: state <= S2_EW_GREEN;
                S2_EW_GREEN:  state <= S3_EW_YELLOW;
                S3_EW_YELLOW: state <= S0_NS_GREEN;
                default:      state <= S0_NS_GREEN;
            endcase
        end
    end

    // Moore output logic
    always @(*) begin
        ns_red    = 1'b0;
        ns_yellow = 1'b0;
        ns_green  = 1'b0;

        ew_red    = 1'b0;
        ew_yellow = 1'b0;
        ew_green  = 1'b0;

        case (state)
            S0_NS_GREEN: begin
                ns_green = 1'b1;
                ew_red   = 1'b1;
            end

            S1_NS_YELLOW: begin
                ns_yellow = 1'b1;
                ew_red    = 1'b1;
            end

            S2_EW_GREEN: begin
                ns_red   = 1'b1;
                ew_green = 1'b1;
            end

            S3_EW_YELLOW: begin
                ns_red    = 1'b1;
                ew_yellow = 1'b1;
            end

            default: begin
                ns_green = 1'b1;
                ew_red   = 1'b1;
            end
        endcase
    end

endmodule
