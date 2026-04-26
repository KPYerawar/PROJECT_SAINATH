module tx(
input clk , rst ,
input tx_req,
input brate,
output reg tx ,
output reg tx_busy );

parameter idle = 0 , start = 1 , data = 2 , stop = 3 ;
reg [1:0] state  = 0 ;
reg [7:0] tx_data = 8'b01010101;
reg [3:0] counter = 0 ;
always @(posedge clk ) begin 
  if ( rst ) begin 
  tx <= 1 ;
  tx_busy <= 0 ;
  state <= idle ;
  counter <= 0 ;
  end 
  else if ( brate == 0 )begin
  tx_data <= tx_data ;
  tx <= tx ;end 
  else begin
      case (state ) 
          idle : begin 
          if (tx_req == 0 ) begin 
             tx  <=  1 ;
             tx_busy <= 0 ;
             counter <= 0 ;
             state <= idle ;
             end 
             else begin 
             state <= start ;
             tx  <=  1 ;
             tx_busy <= 1 ;
             counter <= 0 ;
             end  end 
           start : begin 
                  tx <= 0;
                  tx_busy <= 1 ;
                  state <= data ;
                  end 
            data : begin 
                  if (counter < 7 ) begin 
                     tx <= tx_data [counter];
                     counter <= counter + 1 ;
                     state <= data ;
                     end 
                   else begin 
                      tx <= tx_data[counter];
                      counter <= 0 ;
                      state <= stop;
                      end  end 
              stop : begin 
                    tx <= 1;
                    tx_busy <= 0 ;
                    state <= idle ; end 
                   endcase 
               end 
               end 
              
               endmodule 
