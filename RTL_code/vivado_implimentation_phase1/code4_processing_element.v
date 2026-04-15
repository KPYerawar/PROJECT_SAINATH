// code4_processing_element.v
// Fix: v_out now resets to 0 on rst

module code4_processing_element(
    input  [3:0] a_in, b_in,
    input        clk, rst,
    input        valid,
    output reg [30:0] acc_sum,
    output [3:0] a_out, b_out,
    output reg   v_out
);

reg [3:0] aout;
reg [3:0] bout;

always @(posedge clk) begin
    if (rst) begin
        aout    <= 0;
        bout    <= 0;
        acc_sum <= 0;
        v_out   <= 0;   // FIX: was missing reset
    end else begin
        aout  <= a_in;
        bout  <= b_in;
        v_out <= valid;
        if (valid)
            acc_sum <= acc_sum + (a_in * b_in);
        // else acc_sum holds (no need to write same value)
    end
end

assign a_out = aout;
assign b_out = bout;

endmodule