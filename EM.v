module EM(clk,rst,ewreg,em2reg,ewmem,ealu,eb,eGPR,mwreg,mm2reg,mwmem,malu,mb,mGPR);

input clk,rst,ewreg,em2reg,ewmem;
input [31:0] ealu,eb;
input [4:0] eGPR;

output mwreg,mm2reg,mwmem;
output [31:0] malu,mb;
output [4:0] mGPR;

reg mwreg,mm2reg,mwmem;
reg [31:0] malu,mb;
reg [4:0] mGPR;

always @(negedge rst or posedge clk) begin
if(rst==0)
begin
mwreg<=0; mm2reg<=0;
mwmem<=0; malu<=0;
mb<=0; mGPR<=0;
end
else
begin
mwreg<=ewreg; mm2reg<=em2reg;
mwmem<=ewmem; malu<=ealu;
mb<=eb; mGPR<=eGPR;
end
 end  //end always

endmodule
