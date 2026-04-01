module code5_top_pe(
input clk , rst ,
input [3:0] a_in,b_in);

wire [3:0] in1_a_out;
wire [3:0] in1_b_out;
wire [3:0] in2_a_out;
wire [3:0] in2_b_out;
wire [3:0] in3_a_out;
wire [3:0] in3_b_out;
wire [3:0] in4_a_out;
wire [3:0] in4_b_out;
wire [15:0] in1_acc_sum ;
wire [15:0] in2_acc_sum ;
wire [15:0] in3_acc_sum ;
wire [15:0] in4_acc_sum ;


code4_processing_element in1 (.clk(clk),.rst(rst),.a_in(a_in),.b_in(b_in),.a_out(in1_a_out),.b_out(in1_b_out),.acc_sum(in1_acc_sum));
code4_processing_element in2 (.clk(clk),.rst(rst),.a_in(in1_a_out),.b_in(in1_b_out),.a_out(in2_a_out),.b_out(in2_b_out),.acc_sum(in2_acc_sum));
code4_processing_element in3 (.clk(clk),.rst(rst),.a_in(in2_a_out),.b_in(in2_b_out),.a_out(in3_a_out),.b_out(in3_b_out),.acc_sum(in3_acc_sum));
code4_processing_element in4 (.clk(clk),.rst(rst),.a_in(in3_a_out),.b_in(in3_b_out),.a_out(in4_a_out),.b_out(in4_b_out),.acc_sum(in4_acc_sum));

endmodule 
