module code3_varible_pipeline_outa(
input reset,
output [3:0]out_a);
reg [3:0] a ;
reg [3:0] b;
reg clk = 0 ;
reg [3:0]aout = 0 ;
reg [15:0]acc_sum = 0 ; 

always #10 clk = ~clk ;
always @(posedge clk )begin 
if (reset)
aout <= 0 ;
else begin
acc_sum <= acc_sum + ( a * b ) ;
aout <= a ;
end end
assign out_a = aout;

initial begin 
a = 4'b0101;
b = 4'b1100;
#30;
$display("aout value = %b,%d",out_a,out_a);
$finish;
end 
endmodule 


