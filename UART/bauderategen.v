module bauderategen (
input clk , rst ,
output reg brate);

reg [31:0] cycle = 0 ;
// maths 
   // here we need to set the brate at 9600
   // so the time will be 
   // 100Mz / 9600 = 10416 cycles 
   always @(posedge clk ) begin 
        if (rst ) begin 
        cycle <= 0 ;
        brate <= 0 ; end 
        else if ( cycle == 10416 ) begin
        cycle <= 0  ;
        brate <= 1 ; end
        else begin
        cycle = cycle + 1 ;
        brate <= 0 ;
        end end
        
  
        
     initial begin 
     #4000;
     $monitor ("cycle = %d , brate = %d" , cycle , brate   );
     end 
        endmodule 
