module code2_mac_logic( );
reg [3:0] A = 4'b1010;
reg [3:0] B = 4'b0011;
//now we will do multiplication 
reg [7:0] mul ;
reg [15:0] acc_sum=0;
reg [15:0] acc_sum1= 0;
reg clk = 0 ;

initial begin 
mul = A*B;
#20;
$display("multiplicatiion is :%b,%d", mul,mul);#20;
$display("acc=%b,%b",acc_sum,acc_sum1);
end
always #5 clk = ~clk ; 
always@(posedge clk) begin 
   mul <= A * B ;
   acc_sum <= acc_sum + mul;
      acc_sum1 <= acc_sum + (A*B);
   end 
endmodule
