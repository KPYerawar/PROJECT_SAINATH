module test;
reg clk ;
reg rst ;
wire tx ;
wire tx_busy;
reg tx_req;

top t1  (
.clk(clk),.rst(rst),.tx(tx),.tx_busy(tx_busy),.tx_req(tx_req));

always #500 clk = ~clk ;   // 100 Mz = 50% duty = 5ns toggle

 
initial begin 
$dumpfile ("gtkwave.vcd");
$dumpvars(0,test);
end 
initial begin 

rst = 1 ;
clk = 0 ;
tx_req = 0;
#3000 ;
rst = 0 ;
tx_req = 1 ;


#100000000;
rst = 0 ;

$finish ;
end 
endmodule  
