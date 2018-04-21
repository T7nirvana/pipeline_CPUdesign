module DE(clk,rst,dwreg,dm2reg,dwmem,djal,daluc,daluimm,dshift,dpc4,da,db,dimm,dGPR,ewreg,em2reg,ewmem,ejal,ealuc,ealuimm,eshift,epc4,ea,eb,eimm,eGPR_org);

input clk,rst,dwreg,dm2reg,dwmem,djal,daluimm,dshift;
input [2:0] daluc;
input [31:0]dpc4,da,db,dimm;
input [4:0]dGPR;

output ewreg,em2reg,ewmem,ejal,ealuimm,eshift;
output [2:0] ealuc;
output [31:0]epc4,ea,eb,eimm;
output [4:0]eGPR_org;

reg [31:0] epc4,ea,eb,eimm;
reg [4:0]eGPR_org;
reg [2:0]ealuc;
reg  ewreg,em2reg,ewmem,ejal,ealuimm,eshift;

always @(negedge rst or posedge clk) begin
if(rst==0)
begin
ewreg<=0; em2reg<=0;
ewmem<=0; ejal<=0;
ealuimm<=0; eshift<=0;
ealuc<=0; epc4<=0;
ea<=0; eb<=0;
eimm<=0; eGPR_org<=0;
end
else
begin
ewreg<=dwreg; em2reg<=dm2reg;
ewmem<=dwmem; ejal<=djal;
ealuimm<=daluimm; eshift<=dshift;
ealuc<=daluc; epc4<=dpc4;
ea<=da; eb<=db;
eimm<=dimm; eGPR_org<=dGPR;
end
end //end always

endmodule