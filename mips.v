`include "pc.v"
`include "pipeIF.v"
`include "IR.v"
`include "pipeID.v"
`include "DE.v"
`include "pipeEXE.v"
`include "EM.v"
`include "pipeMEM.v"
`include "MW.v"
`include "pipeWB.v"
`include "mux.v"


module mips( clk, rst );
   input   clk,rst;
  // wire  [31:0] ealu,malu,walu;
  
  //pc寄存器和IF级用到的变量
   wire  [31:0] pc,npc,pc4,bpc,da,jpc,ins;
   wire  wpcir;
   wire  [1:0] pcsource;
   
   //IR寄存器和ID级用到的变量
   wire  [31:0] inst,dpc4,db,dimm;
   wire  [4:0] dGPR;
   wire  [2:0] daluc;
   wire  daluimm,dshift,dwmem,dwreg,dm2reg,djal;

   //ID/EX级寄存器和EX级用到的变量
   wire  [31:0] ea,eb,eimm,epc4,ealu;
   wire  [4:0]eGPR_org,eGPR;
   wire  [2:0] ealuc;
   wire  ealuimm,eshift,ejal,ewmem,ewreg,em2reg;

   //EX/MEM级寄存器和mem级用到的 变量
   wire  [31:0] mb,mmo,malu;
   wire  [4:0] mGPR;
   wire  mwmem,mwreg,mm2reg;

   //MEM/WB级寄存器和WB级用到的变量
   wire  [31:0] wmo,RF_indata,walu;
   wire  [4:0] wGPR;
   wire  wwreg,wm2reg;   

   //wire [15:0] Imm16; 
   //wire [31:0] Imm32;
   //wire [25:0] IMM;

PC prog_count(clk,rst,wpcir,npc,pc);
pipeIF IF_stage(pcsource,pc,bpc,da,jpc,pc4,npc,ins);

IR INST_REG(clk,rst,ins,inst,pc4,dpc4,wpcir);
pipeID ID_stage(clk,rst,inst,dpc4,wGPR,RF_indata,wwreg,dshift,daluimm,daluc,djal,dwmem,dwreg,dm2reg,ewreg,em2reg,eGPR,mwreg,mm2reg,mGPR,da,db,dimm,dGPR,ealu,malu,mmo,bpc,jpc,pcsource,wpcir);

DE de_reg(clk,rst,dwreg,dm2reg,dwmem,djal,daluc,daluimm,dshift,dpc4,da,db,dimm,dGPR,ewreg,em2reg,ewmem,ejal,ealuc,ealuimm,eshift,epc4,ea,eb,eimm,eGPR_org);
pipeEXE EXE_stage(ejal,ealuc,ealuimm,eshift,epc4,ea,eb,eimm,eGPR_org,eGPR,ealu);

EM em_reg(clk,rst,ewreg,em2reg,ewmem,ealu,eb,eGPR,mwreg,mm2reg,mwmem,malu,mb,mGPR);
pipeMEM MEM_stage(clk,rst,mwmem,malu,mb,mmo);        //??dm的时钟信号

MW mw_stage(clk,rst,mwreg,wwreg,mm2reg,wm2reg,mmo,wmo,malu,walu,mGPR,wGPR);
mux2 #(32)WB_stage(walu,wmo,wm2reg,RF_indata);



/*
   PC U_PC (
      .clk(clk), .rst(rst), .PCWr(PCWr), .NPC(NPC), .PC(PC)
   ); 
   
   im U_IM ( 
      .addr(PC[9:0]) , .dout(im_dout)
   );
   
   IR U_IR ( 
      .clk(clk), .rst(rst), .IRWr(IRWr), .im_dout(im_dout), .instr(instr)
   );
   
   RF U_RF (
      .A1(rs), .A2(rt), .A3(A3), .WD(WD), .clk(clk), 
      .RFWr(RFWr), .RD1(RD1), .RD2(RD2)
   );
   
   EXT U_EXT ( 
      .Imm16(Imm16), .EXTOp(EXTOp), .Imm32(Imm32) 
   );
   
   alu U_ALU ( 
      .A(RD1_r), .B(B), .ALUOp(ALUOp), .C(C), .Zero(Zero)
   );
   
   dm U_DM ( 
      .addr(C_r[11:2]), .din(RD2_r), .DMWr(DMWr), .clk(clk), .dout(dm_dout)
   );
*/
endmodule