module mac(
input clk , reset ,
input [7:0] a_in , 
input [7:0] b_in ,
output reg [7:0] a_out , 
output reg [7:0] b_out ,
output reg [15:0] sum_out );

always @(posedge clk ) begin 
  if (reset )  begin 
   a_out<= 8'b0;
   b_out <= 8'b0;
   sum_out <= 16'b0 ;
    end 
    
    else begin 
    a_out<= a_in ;
    b_out <= b_in ;
    sum_out <= sum_out + ( a_in * b_in ) ;
    end 
    end 
    endmodule 


