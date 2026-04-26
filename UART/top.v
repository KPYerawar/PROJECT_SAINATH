module top(
input clk , rst ,tx_req,
output  tx , tx_busy );

wire brate ;

bauderategen b1 (
.clk(clk),.rst(rst),.brate(brate));

tx t1 (
.clk(clk),.rst(rst),.tx_req(tx_req),.tx_busy(tx_busy),.brate(brate),.tx(tx));
 initial begin 
               #100;
               $monitor (" tx = %b " ,tx );
               
               end 
endmodule 
