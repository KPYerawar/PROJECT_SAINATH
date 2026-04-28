module Debounce_Signals #(parameter threshold = 1000000) (
    input clk,       // Input clock
    input btn,       // Input button for transmit or reset
    output reg transmit // Debounced signal
);

    // Double Flop for synchronization to the clock domain
    reg button_ff1 = 0;
    reg button_ff2 = 0;

    // 31-bit counter to handle the threshold timing
    reg [30:0] count = 0;

    // Synchronize the button input
    always @(posedge clk) begin
        button_ff1 <= btn;
        button_ff2 <= button_ff1;
    end

    // Increment or decrement the counter based on button state
    always @(posedge clk) begin
        if (button_ff2) begin
            // Increment up to the threshold limit to prevent overflow
            if (count < threshold)
                count <= count + 1;
        end else begin
            // Decrement down to zero to prevent underflow
            if (count > 0)
                count <= count - 1;
        end

        // Output the debounced signal based on the threshold
        if (count >= threshold)
            transmit <= 1'b1;
        else
            transmit <= 1'b0;
    end

endmodule
