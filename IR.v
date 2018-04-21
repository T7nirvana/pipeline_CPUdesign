module IR (clk,rst,ins,inst,pc4,dpc4,IRWr);
               
   input         clk;
   input         rst;
   input         IRWr; 
   input  [31:0] ins,pc4;
   output [31:0] inst,dpc4;
   
   reg [31:0] inst;
   reg [31:0] dpc4;
               
   always @(posedge clk or negedge rst) begin
      if ( rst==0 ) 
        begin
         inst <= 0;
         dpc4 <= 0;
        end
      else if (IRWr)
        begin
         inst <= ins;
         dpc4 <= pc4;
        end
   end // end always
      
endmodule
