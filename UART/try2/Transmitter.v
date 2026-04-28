module Transmitter(
    input clk,
    input [7:0] data,
    input transmit,
    input reset,
    output reg TxD
);

    // Internal variables
    reg [3:0] bit_counter;          // Counter for 10 bits (Start + 8 Data + Stop)
    reg [13:0] baudrate_counter;    // Counter for 9600 Baud @ 100MHz (100MHz / 9600 approx 10416)
    reg [9:0] shiftright_register;  // Buffer for [Stop bit, Data, Start bit]
    reg state, next_state;          // 0: Idle, 1: Transmitting
    
    reg shift;                      // Control signal to shift bits
    reg load;                       // Control signal to load data
    reg clear;                      // Control signal to reset bit counter

    // Sequential Logic: State and Counters
    always @(posedge clk) begin
        if (reset) begin
            state <= 0;
            bit_counter <= 0;
            baudrate_counter <= 0;
        end
          else begin
            baudrate_counter <= baudrate_counter + 1;
            
            if (baudrate_counter == 10415) begin
                state <= next_state;
                baudrate_counter <= 0;

                if (load)
                    shiftright_register <= {1'b1, data, 1'b0}; // [Stop bit (1), Data (8), Start bit (0)]
                
                if (clear)
                    bit_counter <= 0;
                
                if (shift) begin
                    shiftright_register <= shiftright_register >> 1;
                    bit_counter <= bit_counter + 1;
                end
            end
        end
    end

    // Combinational Logic: FSM
    always @(posedge clk) begin
        load = 0;
        shift = 0;
        clear = 0;
        TxD = 1'b1; // Idle high

        case (state)
            0: begin // IDLE
                if (transmit) begin
                    next_state = 1;
                    load = 1;
                    shift = 0;
                    clear = 0;
                end else begin
                    next_state = 0;
                    TxD = 1'b1;
                end
            end

            1: begin // TRANSMITTING
                if (bit_counter == 10) begin
                    next_state = 0;
                    clear = 1;
                end else begin
                    next_state = 1;
                    TxD = shiftright_register[0];
                    shift = 1;
                end
            end

            default: next_state = 0;
        endcase
    end

endmodule
