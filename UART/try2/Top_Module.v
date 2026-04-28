module Top_Module(
    input [7:0] data,
    input clk,
    input trasnmit,       // This acts as the reset in your logic
    input btn,            // This is the button for transmission
    output TxD,
    output TxD_Debug,
    output transmit_debug,
    output btn_debug,
    output clk_debug
);

    // Internal wires
    wire transmit_out;
    wire reset;

    // Direct assignment based on your image logic
    assign reset = trasnmit;

    // Instantiate Debounce for the button (btn)
    Debounce_Signals DB (
        .clk(clk),
        .btn(btn),
        .transmit(transmit_out)
    );

    // Instantiate Transmitter
    // Note: Mapping follows your snippet (clk, reset, transmit, data, TxD)
    Transmitter T1 (
        .clk(clk),
        .reset(reset),
        .transmit(transmit_out),
        .data(data),
        .TxD(TxD)
    );

    // Debug assignments
    assign TxD_Debug = TxD;
    assign transmit_debug = transmit_out;
    assign btn_debug = reset;
    assign clk_debug = clk;

endmodule
