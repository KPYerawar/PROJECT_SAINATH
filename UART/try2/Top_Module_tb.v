module Top_Module_tb();

    // Inputs
    reg [7:0] data;
    reg clk;
    reg trasnmit; // Reset signal
    reg btn;      // Button signal to be debounced

    // Outputs
    wire TxD;
    wire TxD_Debug;
    wire transmit_debug;
    wire btn_debug;
    wire clk_debug;

    // Instantiate the Unit Under Test (UUT)
    Top_Module uut (
        .data(data), 
        .clk(clk), 
        .trasnmit(trasnmit), 
        .btn(btn), 
        .TxD(TxD), 
        .TxD_Debug(TxD_Debug), 
        .transmit_debug(transmit_debug), 
        .btn_debug(btn_debug), 
        .clk_debug(clk_debug)
    );

    // Clock generation (100MHz)
    always #5 clk = ~clk;

    initial begin
        // Initialize Inputs
        clk = 0;
        trasnmit = 1; // Start in reset
        btn = 0;
        data = 8'h41; // ASCII 'A' (8'b01000001)

        // Wait 100ns for global reset
        #100;
        trasnmit = 0; // Release reset
        #50;

        // Simulate Button Press with Bouncing
        // Toggle btn rapidly to simulate mechanical noise
        btn = 1; #20;
        btn = 0; #20;
        btn = 1; #20;
        btn = 0; #20;
        
        // Hold button high long enough to pass the debounce threshold
        // Note: In simulation, you might want to lower the threshold 
        // in Debounce_Signals to see results faster.
        btn = 1; 
        
        // Wait for the transmitter to finish (Start + 8 Data + Stop = 10 bits)
        // Each bit at 9600 baud is ~104,166ns
        #1500000; 

        btn = 0; // Release button
        #100000;

        // Test with different data
        data = 8'h5A; // ASCII 'Z'
        btn = 1;
        #1500000;
        btn = 0;

        #1000;
        $stop; // End simulation
    end

    // Monitor output in console
    initial begin
        $monitor("Time=%0t | Data=%h | Reset=%b | Button=%b | TxD=%b", 
                 $time, data, trasnmit, btn, TxD);
    end

endmodule
