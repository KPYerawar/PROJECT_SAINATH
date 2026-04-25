module bratetest;
reg clk ;
reg rst ;
wire brate ;

bauderategen b1 (
.clk(clk),.rst(rst),.brate(brate));

always #500 clk = ~clk ;   // 100 Mz = 50% duty = 5ns toggle

 
initial begin 
$dumpfile ("gtkwave.vcd");
$dumpvars(0,bratetest);
end 
initial begin 

rst = 1 ;
clk = 0 ;
#3000 ;
rst = 0 ;

$monitor("values are = %d  | %d ",clk , brate );
#100000000;

$finish ;
end 
endmodule  
