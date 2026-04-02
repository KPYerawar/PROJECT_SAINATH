module code8_top_fsm_joint_tb;
reg clk,rst;
wire flag ;
wire [30:0]s1, s2,s3, s4 ;

code8_top_fsm_joint j1 (.clk(clk),.rst(rst),.flag(flag),.s1(s1),.s2(s2),.s3(s3),.s4(s4));

always #10 clk = ~clk ;
initial begin 
$dumpfile ("code9_top.vcd");
$dumpvars(0,code8_top_fsm_joint_tb);
clk = 0;
rst = 1 ;
#50;
rst = 0 ;
#140;
    $display("Results: s1=%d, s2=%d, s3=%d, s4=%d", s1, s2, s3, s4);
$finish;
end
endmodule 
