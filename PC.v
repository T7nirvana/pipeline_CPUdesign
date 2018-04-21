module PC( clk, rst, PCWr, NPC, pc );
           
   input         clk;
   input         rst;
   input         PCWr;
   input  [31:0] NPC;
   output [31:0] pc;
   
   reg [31:0] pc;
               
   always @(posedge clk or negedge rst) begin
      if ( rst==0 ) 
         pc<= 32'h0000_3000;   //???32'0000_3000
      else if ( PCWr ) 
         pc <= NPC;
   end // end always
           
endmodule
