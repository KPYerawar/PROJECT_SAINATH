module code4_processing_element(
input [3:0] a_in , b_in,
input clk , rst ,
output reg [15:0]acc_sum,
output [3:0] a_out,b_out );
reg [3:0] aout ;
reg [3:0] bout ;

always @(posedge clk ) begin 
if (rst ) begin 
aout <= 0 ;
bout <= 0 ; 
acc_sum <= 0 ;end 

else begin 
acc_sum <= acc_sum + ( a_in * b_in );
aout <= a_in ;
bout <= b_in ;
end 
end 

assign a_out = aout ;
assign b_out = bout ;
endmodule 

 
