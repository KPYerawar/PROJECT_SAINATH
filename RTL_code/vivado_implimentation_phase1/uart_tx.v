`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/15/2026 07:49:07 AM
// Design Name: 
// Module Name: uart_tx
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
// uart_tx.v
// 8N1 UART Transmitter
// Baud = clk_freq / CLKS_PER_BIT
// For 100 MHz clock, 9600 baud: CLKS_PER_BIT = 10416

module uart_tx #(
    parameter CLKS_PER_BIT = 10416
)(
    input        clk,
    input        rst,
    input        tx_start,    // pulse high 1 cycle to begin sending
    input  [7:0] tx_byte,     // byte to transmit
    output reg   tx_serial,   // connect to FPGA UART TX pin
    output reg   tx_done      // pulses high 1 cycle when byte fully sent
);

localparam IDLE  = 2'd0;
localparam START = 2'd1;
localparam DATA  = 2'd2;
localparam STOP  = 2'd3;

reg [1:0]  state   = IDLE;
reg [13:0] clk_cnt = 0;
reg [2:0]  bit_idx = 0;
reg [7:0]  tx_data = 0;

always @(posedge clk) begin
    if (rst) begin
        state     <= IDLE;
        tx_serial <= 1'b1;   // idle line high
        tx_done   <= 1'b0;
        clk_cnt   <= 0;
        bit_idx   <= 0;
    end else begin
        tx_done <= 1'b0;     // default: not done

        case (state)
            IDLE: begin
                tx_serial <= 1'b1;
                clk_cnt   <= 0;
                bit_idx   <= 0;
                if (tx_start) begin
                    tx_data <= tx_byte;
                    state   <= START;
                end
            end

            START: begin
                tx_serial <= 1'b0;   // start bit
                if (clk_cnt == CLKS_PER_BIT - 1) begin
                    clk_cnt <= 0;
                    state   <= DATA;
                end else
                    clk_cnt <= clk_cnt + 1;
            end

            DATA: begin
                tx_serial <= tx_data[bit_idx];  // LSB first
                if (clk_cnt == CLKS_PER_BIT - 1) begin
                    clk_cnt <= 0;
                    if (bit_idx == 7) begin
                        bit_idx <= 0;
                        state   <= STOP;
                    end else
                        bit_idx <= bit_idx + 1;
                end else
                    clk_cnt <= clk_cnt + 1;
            end

            STOP: begin
                tx_serial <= 1'b1;   // stop bit
                if (clk_cnt == CLKS_PER_BIT - 1) begin
                    tx_done <= 1'b1;
                    clk_cnt <= 0;
                    state   <= IDLE;
                end else
                    clk_cnt <= clk_cnt + 1;
            end

            default: state <= IDLE;
        endcase
    end
end

endmodule