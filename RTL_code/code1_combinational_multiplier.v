module code1_combinational_multiplier();
reg [3:0] A = 4'b1010;
reg [3:0] B = 4'b0011;
//now we will do multiplication 
reg [7:0] mul ;

initial begin 
mul = A*B;
$display("multiplicatiion is :%b,%d", mul,mul);
end

always@(*) begin 
   mul = A * B ;
   end 
endmodule
