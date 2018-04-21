`include "mips.v"

 module mips_tb();
    
   reg clk, rst;
   
   mips MYMIPS(.clk(clk), .rst(rst));
    
   initial begin
      $readmemh( "D:\code_pipeline.txt" , MYMIPS.IF_stage.inst_MEM.imem ) ;
      $monitor("第%2d条指令，PC = 0x%8X, ins=0x%8X, inst = 0x%8X", (MYMIPS.prog_count.pc-32'h00003000)/4+1,MYMIPS.prog_count.pc,MYMIPS.IF_stage.ins, MYMIPS.INST_REG.inst ); 
      clk = 1 ;
      rst = 1 ;
      //force MYMIPS.ID_stage.ctrl_unit.pcsource = 0;
      //force MYMIPS.ID_stage.RF_indata=0;
      /*force MYMIPS.wmo=0;
      force MYMIPS.walu=0;
      force MYMIPS.wm2reg=0;
      force MYMIPS.wreg=0;*/
      /*force MYMIPS.INST_REG.dpc4 = 0;
      force MYMIPS.dimm = 0;
      force MYMIPS.daluc = 0;
      force MYMIPS.daluimm = 0;
      force MYMIPS.dshift = 0;
      force MYMIPS.dwmem = 0;
      force MYMIPS.dwreg = 0;
      force MYMIPS.dm2reg = 0;
      force MYMIPS.djal = 0;
      force MYMIPS.mmo = 0;
      force MYMIPS.RF_indata =0;
      force MYMIPS.EXTOp =0;
      force MYMIPS.ID_stage.funct = 0;
      force MYMIPS.ID_stage.regrt = 0;
      force MYMIPS.ealu = 0;
      force MYMIPS.ID_stage.SEL_da.d1=0;
      force MYMIPS.ID_stage.SEL_db.d1=0;
      force MYMIPS.EXE_stage.ealu_org=0;
      force MYMIPS.EXE_stage.ALU_unit.C=0;
      force MYMIPS.EXE_stage.ALU_unit.i=0;
      force MYMIPS.EXE_stage.save_pc8.d0=0;
      force MYMIPS.ID_stage.ctrl_unit.dwreg=0;
      force MYMIPS.ID_stage.ctrl_unit.r_sll=0;*/
      #5 ;
      rst = 0 ;
      #20 ;
      rst = 1 ;
      //#75 ;
      //release MYMIPS.ID_stage.ctrl_unit.pcsource;
      //release MYMIPS.ID_stage.RF_indata;
      /*release MYMIPS.wmo;
      release MYMIPS.walu;
      release MYMIPS.wm2reg;
      release MYMIPS.wwreg;*/
      /*release MYMIPS.INST_REG.dpc4;
      release MYMIPS.dimm;
      release MYMIPS.daluc;
      release MYMIPS.daluimm;
      release MYMIPS.dshift;
      release MYMIPS.dwmem;
      release MYMIPS.dwreg;
      release MYMIPS.dm2reg;
      release MYMIPS.djal;
      release MYMIPS.mmo;
      release MYMIPS.RF_indata;
      release MYMIPS.EXTOp;
      release MYMIPS.ID_stage.funct;
      release MYMIPS.ID_stage.regrt;
      release MYMIPS.ealu;
      release MYMIPS.ID_stage.SEL_da.d1;
      release MYMIPS.ID_stage.SEL_db.d1;
      release MYMIPS.EXE_stage.ealu_org;
      release MYMIPS.EXE_stage.ALU_unit.C;
      release MYMIPS.EXE_stage.ALU_unit.i;
      release MYMIPS.EXE_stage.save_pc8.d0;
      release MYMIPS.ID_stage.ctrl_unit.dwreg;
      release MYMIPS.ID_stage.ctrl_unit.r_sll;*/
      
      //force MYMIPS.wpcir = 1 ;
      //#102 ;
      //release MYMIPS.wpcir;
   end
   
   always
	   #(50) clk = ~clk;
   
endmodule
