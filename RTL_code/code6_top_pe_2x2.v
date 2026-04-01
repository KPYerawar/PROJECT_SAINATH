module code6_top_pe_2x2(
input clk , rst ,
input [3:0] A_in_0,A_in_1,
input [3:0] B_in_0,B_in_1,
output [30:0]s1, s2,s3, s4 );

wire [3:0] in1_a_out;
wire [3:0] in1_b_out;
wire [3:0] in2_a_out;
wire [3:0] in2_b_out;
wire [3:0] in3_a_out;
wire [3:0] in3_b_out;
wire [3:0] in4_a_out;
wire [3:0] in4_b_out;
wire [30:0] in1_acc_sum ;
wire [30:0] in2_acc_sum ;
wire [30:0] in3_acc_sum ;
wire [30:0] in4_acc_sum ;

/*
          B_in_0    B_in_1
            |         |
A_in_0 -> [PE1] -> [PE2]
           |         |
A_in_1 -> [PE3] -> [PE4]
*/
// onw just get the wire and cinnect them 

code4_processing_element PE1 (.clk(clk),.rst(rst),.a_in(A_in_0),.b_in(B_in_0),.a_out(in1_a_out),.b_out(in1_b_out),.acc_sum(in1_acc_sum));
code4_processing_element PE2 (.clk(clk),.rst(rst),.a_in(in1_a_out),.b_in(B_in_1),.a_out(in2_a_out),.b_out(in2_b_out),.acc_sum(in2_acc_sum));
code4_processing_element PE3 (.clk(clk),.rst(rst),.a_in(A_in_1),.b_in(in1_b_out),.a_out(in3_a_out),.b_out(in3_b_out),.acc_sum(in3_acc_sum));
code4_processing_element PE4 (.clk(clk),.rst(rst),.a_in(in3_a_out),.b_in(in2_b_out),.a_out(in4_a_out),.b_out(in4_b_out),.acc_sum(in4_acc_sum));


assign s1 = in1_acc_sum;
assign s2 = in2_acc_sum;
assign s3 = in3_acc_sum;
assign s4 = in4_acc_sum;

endmodule 

// ok this is done now pipelining is done and flow is also according to dig 
