`timescale 1ns / 1ps

module fsm_tb();

    // Inputs
    reg clk;
    reg rst;

    // Outputs
    wire [3:0] A_in_0, A_in_1, B_in_0, B_in_1;
    wire valid;
    wire finish_flag;
    wire [30:0] s1,s2,s3,s4;

    // Instantiate the Unit Under Test (UUT)
    code7_valid_fsm uut (
        .clk(clk), 
        .rst(rst), 
        .A_in_0(A_in_0), 
        .A_in_1(A_in_1), 
        .B_in_0(B_in_0), 
        .B_in_1(B_in_1), 
        .valid(valid), 
        .finish_flag(finish_flag)
    );
    


    // Clock generation: 10ns period (100MHz)
    always #5 clk = ~clk;

    initial begin
        // Initialize Inputs
        clk = 0;
        rst = 1;

        // Wait 20 ns for global reset to settle
        #20;
        rst = 0;
        
        $display("Starting Simulation...");
        $display("Time\t State\t Valid\t A0\t B0\t A1\t B1");
        $monitor("%0t\t %b\t %b\t %h\t %h\t %h\t %h", $time, uut.state, valid, A_in_0, B_in_0, A_in_1, B_in_1);


        // Wait for finish_flag to be asserted
        wait(finish_flag == 1);
        
        #20;

        $display("Simulation Finished at %0t", $time);
        $finish;
    end

endmodule
