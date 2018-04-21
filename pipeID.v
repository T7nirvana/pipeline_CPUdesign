`include "instruction_def.v"
`include "ID_CTRL.v"
`include "rf.v"
`include "mux.v"
`include "ID_EXT.v"


module pipeID(clk,rst,inst,dpc4,wGPR,RF_indata,wwreg,dshift,daluimm,daluc,djal,dwmem,dwreg,dm2reg,ewreg,em2reg,eGPR,mwreg,mm2reg,mGPR,da,db,dimm,dGPR,ealu,malu,mmo,bpc,jpc,pcsource,wpcir);

input clk,rst,wwreg,ewreg,em2reg,mwreg,mm2reg;
input [31:0]inst,dpc4,RF_indata,ealu,malu,mmo;
input [4:0]wGPR,eGPR,mGPR;

output dshift,daluimm,djal,dwmem,dwreg,dm2reg;
output [31:0]da,db,dimm,bpc,jpc;
output [4:0]dGPR;
output [2:0]daluc;
output wpcir,dwreg,dm2reg,dwmem,daluimm,dshift,djal;
output [1:0]pcsource;

wire [5:0] op,funct;
wire [4:0] rs,rt,rd;
wire [15:0] imm16;
assign imm16 = inst[15:0];

assign op=inst[31:26];
assign rs=inst[25:21];
assign rt=inst[20:16];
assign rd=inst[15:11];
assign funct=inst[5:0];
wire rsrtequ,regrt;                //rsrtequ判断rs，rt寄存器值是否相等，regrt判断是选择rt还是rd作目的寄存器号（regrt=1，dGPR=rt,else,dGPR=rd)
assign rsrtequ=~|(da^db);  //rsrtequ=(a==b)

wire [1:0]fwda,fwdb;
wire EXTOp;
ID_CTRL ctrl_unit(inst,rs,rt,op,funct,rsrtequ,ewreg,em2reg,eGPR,mwreg,mm2reg,mGPR,dwreg,dm2reg,dwmem,djal,daluc,daluimm,dshift,EXTOp,regrt,fwda,fwdb,pcsource,wpcir);

wire [31:0] qa,qb;
rf regfile(rs, rt, wGPR, RF_indata, ~clk, rst,wwreg, qa, qb);
    //注意在时钟下降沿写寄存器堆，对DM也是如此，这样可以保证前半个周期写的值后半个周期就可以读到

mux4 SEL_da(qa,ealu,malu,mmo,fwda,da);
mux4 SEL_db(qb,ealu,malu,mmo,fwdb,db);
reg [4:0] dGPR;
always@(*) dGPR=regrt?rt:rd;
ID_EXT immextender(imm16,EXTOp,dimm);
assign jpc={dpc4[31:28],inst[25:0],2'b00};
assign bpc=dpc4+(dimm<<2);                             //!!beq的分支指令也要符号位扩展

endmodule