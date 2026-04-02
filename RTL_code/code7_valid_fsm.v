`timescale 1ns / 1ps
module code7_valid_fsm (
input clk , rst,
output reg [3:0]  A_in_0  , A_in_1, B_in_0 , B_in_1,
output reg valid  ,
output reg finish_flag);




reg [1:0]state = 0 ;
parameter  IDLE = 2'b00 , SETUP = 2'b01 , COMPUTE = 2'b10 , DONE = 2'b11 ;
reg [3:0]counter = 0 ;
reg [3:0] a00 , a01 , b00 , b11 ,a10,a11,b01,b10; // this used for reading the text file 

reg [3:0] mem [7:0] ;
initial begin 
                $readmemh ("matrix.txt",mem);
                end

always @(posedge clk ) begin 
if (rst) begin 
state <= IDLE;

finish_flag<=0;
counter <=0;
valid<= 0 ;
end
else begin 
  case (state) 
     IDLE : begin  // this is idle state where no task is started 
              A_in_0  <= 0 ;A_in_1 <= 0 ;
               B_in_0 <=0 ;B_in_1 <= 0 ;
               valid <= 0 ;
               state <= SETUP ;
               finish_flag <=0 ;
               counter <= 0 ;
               end 
      
      SETUP : begin 
         // reading a text file of matrix 
                a00 <= mem [0];a01 <= mem [1];
                a10 <= mem [2];a11 <= mem [3];
                b00 <= mem [4];b01 <= mem [5];
                b10 <= mem [6];b11 <= mem [7];
               state <= COMPUTE ; end 
        
       COMPUTE : begin 
                  if ( counter == 0 ) begin 
                     A_in_0 <= a00; B_in_0 <= b00 ;
                     A_in_1 <= 0; B_in_1 <= 0;
                     valid <= 1 ;
                     counter <= counter+1 ;
                     end 
                   else if (counter == 1 ) begin 
                      A_in_0 <= a01; B_in_0 <= b10;
                      A_in_1 <= a10; B_in_1 <= b01;
                      counter <= counter +1 ;
                      end 
                    else if (counter == 2 ) begin 
                       A_in_0 <= 0; B_in_0 <= 0;
                       A_in_1 <=a11; B_in_1 <= b11;
                       counter <= counter + 1 ;
                       end 
                     else begin  
                     A_in_0 <= 0 ;B_in_0 <=0;
                     A_in_1 <= 0 ;B_in_1 <= 0 ; 
                    counter <= 0 ; state <= DONE ;
                                     valid <= 0 ;
                    end end
         
         DONE : begin 

                 state<= DONE ;
                 finish_flag<= 1 ;
                 end 
       endcase 
       end end
       
       initial begin
       #100;

       $display ("a00 = %h",a00);
       end 
       endmodule 
           
                      
                     
                

