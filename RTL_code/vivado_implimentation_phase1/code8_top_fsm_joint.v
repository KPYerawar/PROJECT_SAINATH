`timescale 1ns / 1ps
// code8_top_fsm_joint.v

module code8_top_fsm_joint(
    input         clk, rst,
    output        flag,
    output        uart_tx_pin
);

// Internal wires for the Systolic Array results
wire [30:0] s1, s2, s3, s4;

wire [3:0]  in1_a_out, in1_b_out, in2_a_out, in2_b_out;
wire [3:0]  in3_a_out, in3_b_out, in4_a_out, in4_b_out;
wire [30:0] in1_acc_sum, in2_acc_sum, in3_acc_sum, in4_acc_sum;
wire [3:0]  A_in_0, A_in_1, B_in_0, B_in_1;
wire        valid, flag1;
wire        v1_out, v2_out, v3_out, v4_out;

// ── Processing Elements ──────────────────────────────────────────
code4_processing_element PE1(
    .clk(clk), .rst(rst),
    .a_in(A_in_0),    .b_in(B_in_0),
    .a_out(in1_a_out),.b_out(in1_b_out),
    .acc_sum(in1_acc_sum), .valid(valid), .v_out(v1_out));

code4_processing_element PE2(
    .clk(clk), .rst(rst),
    .a_in(in1_a_out), .b_in(B_in_1),
    .a_out(in2_a_out),.b_out(in2_b_out),
    .acc_sum(in2_acc_sum), .valid(v1_out), .v_out(v2_out));

code4_processing_element PE3(
    .clk(clk), .rst(rst),
    .a_in(A_in_1),    .b_in(in1_b_out),
    .a_out(in3_a_out),.b_out(in3_b_out),
    .acc_sum(in3_acc_sum), .valid(v1_out), .v_out(v3_out));

code4_processing_element PE4(
    .clk(clk), .rst(rst),
    .a_in(in3_a_out), .b_in(in2_b_out),
    .a_out(in4_a_out),.b_out(in4_b_out),
    .acc_sum(in4_acc_sum), .valid(v3_out), .v_out(v4_out));

// ── Assignments ──────────────────────────────────────────────────
assign s1 = in1_acc_sum;
assign s2 = in2_acc_sum;
assign s3 = in3_acc_sum;
assign s4 = in4_acc_sum;

code7_valid_fsm in2(
    .clk(clk), .rst(rst),
    .A_in_0(A_in_0), .A_in_1(A_in_1),
    .B_in_0(B_in_0), .B_in_1(B_in_1),
    .valid(valid), .finish_flag(flag1));

assign flag = flag1;

// ── UART Sender ──────────────────────────────────────────────────
uart_result_sender #(.CLKS_PER_BIT(10416)) u_sender (
    .clk       (clk),
    .rst       (rst),
    .flag      (flag1),
    .s1        (s1),
    .s2        (s2),
    .s3        (s3),
    .s4        (s4),
    .tx_serial (uart_tx_pin)
);

endmodule