module top_pe_2x2_tb ;
reg clk , rst ;
reg [3:0] A_in_0,A_in_1;
reg [3:0] B_in_0,B_in_1;
wire [30:0]s1 , s2 , s3 , s4;

/*
A = a00 a01     b = b00 b01
    a10 a11         b10 b11
*/

// now do multiply like we do in matrix 
//1st atrix row0 and 2nd matrix column 1 
// means a goes left to right and b goes to top to bottom 

// for now lets defing the variable manualluyy 

reg [3:0] a00 = 4'b1010, a01 = 4'b0010, a10 = 4'b1110, a11 = 4'b1011;
reg [3:0] b00 = 4'b1010, b01 = 4'b0010, b10 = 4'b1110, b11 = 4'b1011;

// now passing of them 
// feed them 1 by 1 to inputs of code6_top_pr_2x2
always #10 clk = ~clk; 
code6_top_pe_2x2 in (.clk(clk),.rst(rst),.A_in_0(A_in_0),.A_in_1(A_in_1),.B_in_0(B_in_0),.B_in_1(B_in_1),.s1(s1),.s2(s2),.s3(s3),.s4(s4));

initial begin 
    $dumpfile("pe_2x2.vcd");
    $dumpvars(0,top_pe_2x2_tb);

    clk = 0;        // Start with 0
    rst = 1;        // Reset ON
    #20;            // Wait
    rst = 0;        // Reset OFF (Now hardware is ready)

    // T1: Input 1
    A_in_0 = a00; B_in_0 = b00;
    A_in_1 = 0; B_in_1 = 0;
    #100; // Wait for next clock cycle

    // T2: Input 2 (Skewed)
    A_in_0 = a01; B_in_0 = b10;
    A_in_1 = a10; B_in_1 = b01;
    #100;

    // T3: Input 3
    A_in_0 = 0; B_in_0 = 0;
    A_in_1 = a11; B_in_1 = b11;
    #100;

    // T4: Ek extra clock cycle result capture karne ke liye
    #100; 
    
    $display("Results: s1=%d, s2=%d, s3=%d, s4=%d", s1, s2, s3, s4);
    $finish;
end
endmodule 


