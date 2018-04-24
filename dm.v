`include "global_def.v"
module dm( addr, din, DMWr, clk, rst , dout );
   
   input  [11:2] addr;
   input  [31:0] din;		
   input         DMWr;
   input         clk,rst;
   output [31:0] dout;
     
   reg [31:0] dmem[1023:0];
   integer i;
   always @(negedge rst or posedge clk) 
   begin
     if(rst==0)
   begin
         for (i=0; i<1024; i=i+1)
          dmem[i] = 32'b0;
   end
    else if (DMWr) 
   begin
      dmem[addr] = din;
	 `ifdef DEBUG
	   $display("dmem[%4d]=%8X",addr,dmem[addr]);
	 `endif
	 end
   end // end always
    
   assign dout = dmem[addr];
    
endmodule    
