`include "global_def.v"
module rf( rna, rnb, wn, d, clk, rst, RFWr, qa, qb );//没有rst复位信号，因为老师的代码里有个initial语句——改了，加上了rst信号，去掉了initial以便统一
    
   input  [4:0]  rna, rnb, wn;
   input  [31:0] d;
   input         clk,rst;
   input         RFWr;
   output [31:0] qa, qb;
   
   reg [31:0] rf[31:0];
   integer i;
   
   always @(negedge rst or posedge clk) begin
      if (rst==0)
      begin
         
         for (i=0; i<32; i=i+1)
          rf[i] = 32'b0;
       end
       else if(RFWr & (wn!=0))             //!!注意必须要有wreg信号！！
       begin
         rf[wn] = d;
      `ifdef DEBUG                   //??DEBUG模式？？打印有什么区别
         $display("R[00-07]=%8X, %8X, %8X, %8X, %8X, %8X, %8X, %8X", 0, rf[1], rf[2], rf[3], rf[4], rf[5], rf[6], rf[7]);
         $display("R[08-15]=%8X, %8X, %8X, %8X, %8X, %8X, %8X, %8X", rf[8], rf[9], rf[10], rf[11], rf[12], rf[13], rf[14], rf[15]);
         $display("R[16-23]=%8X, %8X, %8X, %8X, %8X, %8X, %8X, %8X", rf[16], rf[17], rf[18], rf[19], rf[20], rf[21], rf[22], rf[23]);
         $display("R[24-31]=%8X, %8X, %8X, %8X, %8X, %8X, %8X, %8X", rf[24], rf[25], rf[26], rf[27], rf[28], rf[29], rf[30], rf[31]);
      `endif
       end
   end // end always
   
   assign qa = (rna == 0) ? 32'd0 : rf[rna];
   assign qb = (rnb == 0) ? 32'd0 : rf[rnb];
   
endmodule


