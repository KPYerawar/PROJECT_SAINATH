// uart_result_sender.v
// Sends S1=XXXXXXXX\r\n  S2=... S3=... S4=... to PuTTY when flag goes HIGH
// Fully synthesizable

module uart_result_sender #(
    parameter CLKS_PER_BIT = 10416
)(
    input        clk,
    input        rst,
    input        flag,
    input [30:0] s1, s2, s3, s4,
    output       tx_serial
);

// ── UART TX ──────────────────────────────────────────────────────
reg  tx_start = 0;
reg  [7:0] tx_byte = 0;
wire tx_done;

uart_tx #(.CLKS_PER_BIT(CLKS_PER_BIT)) u_tx (
    .clk(clk), .rst(rst),
    .tx_start(tx_start), .tx_byte(tx_byte),
    .tx_serial(tx_serial), .tx_done(tx_done)
);

// ── Hex nibble to ASCII ──────────────────────────────────────────
// s1..s4 are 31-bit. We display as 8 hex digits.
// Pad to 32 bits: {1'b0, s1} etc.
// Nibbles from MSB to LSB of 32-bit value:
//   bits [31:28] [27:24] [23:20] [19:16] [15:12] [11:8] [7:4] [3:0]
// Since bit31 is always 0 for s (31-bit), first nibble is always 0.

function [7:0] hexc;
    input [3:0] n;
    hexc = (n < 4'd10) ? (8'd48 + {4'd0,n}) : (8'd55 + {4'd0,n});
    //  n=0->'0'=48,  n=10->'A'=65=55+10
endfunction

// ── Message buffer: 52 bytes (4 results x 13 bytes each) ─────────
// Per result: 'S','N','=', 8 hex digits, '\r','\n'  = 13 bytes
reg [7:0] msg [0:51];

wire [31:0] w1 = {1'b0, s1};
wire [31:0] w2 = {1'b0, s2};
wire [31:0] w3 = {1'b0, s3};
wire [31:0] w4 = {1'b0, s4};

always @(*) begin
    // S1
    msg[ 0]="S"; msg[ 1]="1"; msg[ 2]="=";
    msg[ 3]=hexc(w1[31:28]); msg[ 4]=hexc(w1[27:24]);
    msg[ 5]=hexc(w1[23:20]); msg[ 6]=hexc(w1[19:16]);
    msg[ 7]=hexc(w1[15:12]); msg[ 8]=hexc(w1[11:8]);
    msg[ 9]=hexc(w1[7:4]);   msg[10]=hexc(w1[3:0]);
    msg[11]=8'h0D;            msg[12]=8'h0A;
    // S2
    msg[13]="S"; msg[14]="2"; msg[15]="=";
    msg[16]=hexc(w2[31:28]); msg[17]=hexc(w2[27:24]);
    msg[18]=hexc(w2[23:20]); msg[19]=hexc(w2[19:16]);
    msg[20]=hexc(w2[15:12]); msg[21]=hexc(w2[11:8]);
    msg[22]=hexc(w2[7:4]);   msg[23]=hexc(w2[3:0]);
    msg[24]=8'h0D;            msg[25]=8'h0A;
    // S3
    msg[26]="S"; msg[27]="3"; msg[28]="=";
    msg[29]=hexc(w3[31:28]); msg[30]=hexc(w3[27:24]);
    msg[31]=hexc(w3[23:20]); msg[32]=hexc(w3[19:16]);
    msg[33]=hexc(w3[15:12]); msg[34]=hexc(w3[11:8]);
    msg[35]=hexc(w3[7:4]);   msg[36]=hexc(w3[3:0]);
    msg[37]=8'h0D;            msg[38]=8'h0A;
    // S4
    msg[39]="S"; msg[40]="4"; msg[41]="=";
    msg[42]=hexc(w4[31:28]); msg[43]=hexc(w4[27:24]);
    msg[44]=hexc(w4[23:20]); msg[45]=hexc(w4[19:16]);
    msg[46]=hexc(w4[15:12]); msg[47]=hexc(w4[11:8]);
    msg[48]=hexc(w4[7:4]);   msg[49]=hexc(w4[3:0]);
    msg[50]=8'h0D;            msg[51]=8'h0A;
end

// ── Sender FSM ───────────────────────────────────────────────────
localparam WAIT    = 2'd0,
           SEND    = 2'd1,
           WAIT_TX = 2'd2,
           DONE    = 2'd3;

reg [1:0] state    = WAIT;
reg [5:0] byte_idx = 0;
reg       flag_r   = 0;

always @(posedge clk) begin
    if (rst) begin
        state    <= WAIT;
        tx_start <= 0;
        byte_idx <= 0;
        flag_r   <= 0;
    end else begin
        tx_start <= 0;   // default: off

        // One-shot latch: capture flag rising edge
        if (flag && !flag_r) flag_r <= 1;

        case (state)
            WAIT: begin
                if (flag_r) begin
                    byte_idx <= 0;
                    state    <= SEND;
                end
            end
            SEND: begin
                if (byte_idx < 6'd52) begin
                    tx_byte  <= msg[byte_idx];
                    tx_start <= 1;
                    state    <= WAIT_TX;
                end else
                    state <= DONE;
            end
            WAIT_TX: begin
                if (tx_done) begin
                    byte_idx <= byte_idx + 1;
                    state    <= SEND;
                end
            end
            DONE: state <= DONE;  // stay, all done
        endcase
    end
end

endmodule