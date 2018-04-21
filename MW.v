module MW(clk,rst,mwreg,wwreg,mm2reg,wm2reg,mmo,wmo,malu,walu,mGPR,wGPR);

input clk,rst,mwreg,mm2reg;
input [31:0]mmo,malu;
input [4:0]mGPR;

output wwreg,wm2reg;
output [31:0]wmo,walu;
output [4:0]wGPR;

reg wwreg,wm2reg;
reg [31:0]wmo,walu;
reg [4:0]wGPR;

always @(negedge rst or posedge clk)
begin
if(rst==0)
begin
wwreg<=0; wm2reg<=0;
wmo<=0; walu<=0;
wGPR<=0;
end
else
begin
wwreg<=mwreg; wm2reg<=mm2reg;
wmo<=mmo; walu<=malu;
wGPR<=mGPR;
end
 end //end always

endmodule
