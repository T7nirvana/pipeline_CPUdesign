`include "instruction_def.v"
`include "ctrl_encode_def.v"

module ID_CTRL(inst,rs,rt,op,funct,rsrtequ,ewreg,em2reg,eGPR,mwreg,mm2reg,mGPR,dwreg,dm2reg,dwmem,djal,daluc,daluimm,dshift,EXTOp,regrt,fwda,fwdb,pcsource,wpcir);

input [31:0]inst;
input [4:0]rs,rt,eGPR,mGPR;
input [5:0]op,funct;
input rsrtequ,ewreg,em2reg,mwreg,mm2reg;

output dwreg,dm2reg,dwmem,djal,daluimm,dshift,EXTOp,regrt,wpcir;
output [2:0]daluc;
output [1:0]fwda,fwdb,pcsource;


reg r_addu,r_subu,r_sll,r_srl,r_sra,r_jr,NOP;
reg i_ori,i_lw,i_sw,i_lui,i_beq,i_j,i_jal;        


//指令译码，确定是哪种类型的指令
always @( * ) begin
if( inst==0 )
  begin r_addu=0;r_subu=0;r_sll=0;r_srl=0;r_sra=0;r_jr=0;NOP=1; i_ori=0;i_lw=0;i_sw=0;i_lui=0;i_beq=0;i_j=0;i_jal=0;end
else 
begin
if( op==`INST_RTYPE_OP )    //为R_type指令
  
  begin
    case(funct)
     `INST_ADDU_FUNCT:begin r_addu=1;r_subu=0;r_sll=0;r_srl=0;r_sra=0;r_jr=0;NOP=0; i_ori=0;i_lw=0;i_sw=0;i_lui=0;i_beq=0;i_j=0;i_jal=0;end
     `INST_SUBU_FUNCT:begin r_addu=0;r_subu=1;r_sll=0;r_srl=0;r_sra=0;r_jr=0;NOP=0; i_ori=0;i_lw=0;i_sw=0;i_lui=0;i_beq=0;i_j=0;i_jal=0; end
     `INST_SLL_FUNCT:begin r_addu=0;r_subu=0;r_sll=1;r_srl=0;r_sra=0;r_jr=0;NOP=0; i_ori=0;i_lw=0;i_sw=0;i_lui=0;i_beq=0;i_j=0;i_jal=0;end
     `INST_SRL_FUNCT:begin r_addu=0;r_subu=0;r_sll=0;r_srl=1;r_sra=0;r_jr=0;NOP=0; i_ori=0;i_lw=0;i_sw=0;i_lui=0;i_beq=0;i_j=0;i_jal=0;end
     `INST_SRA_FUNCT:begin r_addu=0;r_subu=0;r_sll=0;r_srl=0;r_sra=1;r_jr=0;NOP=0; i_ori=0;i_lw=0;i_sw=0;i_lui=0;i_beq=0;i_j=0;i_jal=0;end
     `INST_JR_FUNCT:begin r_addu=0;r_subu=0;r_sll=0;r_srl=0;r_sra=0;r_jr=1;NOP=0; i_ori=0;i_lw=0;i_sw=0;i_lui=0;i_beq=0;i_j=0;i_jal=0;end
     default: ;
    endcase
  end

else                       //为I_type指令
  begin
    case(op)
    `INST_ORI_OP:begin i_ori=1;i_lw=0;i_sw=0;i_lui=0;i_beq=0;i_j=0;i_jal=0;r_addu=0;r_subu=0;r_sll=0;r_srl=0;r_sra=0;r_jr=0;NOP=0; end
    `INST_LW_OP:begin i_ori=0;i_lw=1;i_sw=0;i_lui=0;i_beq=0;i_j=0;i_jal=0;r_addu=0;r_subu=0;r_sll=0;r_srl=0;r_sra=0;r_jr=0;NOP=0; end
    `INST_SW_OP:begin i_ori=0;i_lw=0;i_sw=1;i_lui=0;i_beq=0;i_j=0;i_jal=0;r_addu=0;r_subu=0;r_sll=0;r_srl=0;r_sra=0;r_jr=0;NOP=0; end
    `INST_LUI_OP:begin i_ori=0;i_lw=0;i_sw=0;i_lui=1;i_beq=0;i_j=0;i_jal=0;r_addu=0;r_subu=0;r_sll=0;r_srl=0;r_sra=0;r_jr=0;NOP=0; end
    `INST_BEQ_OP:begin i_ori=0;i_lw=0;i_sw=0;i_lui=0;i_beq=1;i_j=0;i_jal=0;r_addu=0;r_subu=0;r_sll=0;r_srl=0;r_sra=0;r_jr=0;NOP=0; end
    `INST_J_OP:begin i_ori=0;i_lw=0;i_sw=0;i_lui=0;i_beq=0;i_j=1;i_jal=0;r_addu=0;r_subu=0;r_sll=0;r_srl=0;r_sra=0;r_jr=0;NOP=0; end
    `INST_JAL_OP:begin i_ori=0;i_lw=0;i_sw=0;i_lui=0;i_beq=0;i_j=0;i_jal=1;r_addu=0;r_subu=0;r_sll=0;r_srl=0;r_sra=0;r_jr=0;NOP=0; end
    default: ;
    endcase
  end
end
  end  //end always



//npc的选择，控制冒险之分支，pcsource的信号如何产生
assign pcsource[1]=r_jr|i_j|i_jal;
assign pcsource[0]=(i_beq&rsrtequ)|i_j|i_jal;



//wpcir，数据冒险之lw—use
wire rs_use,rt_use;
assign rs_use=r_addu|r_subu|r_jr|i_ori|i_lw|i_sw|i_beq;     //rs_use代表rs寄存器的源值需要被用到
assign rt_use=r_addu|r_subu|r_sll|r_srl|r_sra|i_sw|i_beq;   //rt_use代表rt寄存器的源值需要被用到
assign wpcir=~(ewreg & em2reg & (eGPR!=0) & (rs_use&(rs==eGPR)|rt_use&(rt==eGPR)));




//fwda，fwdb数据冒险之旁路单元
reg [1:0] fwda,fwdb;
always @(eGPR or ewreg or em2reg or mGPR or mwreg or mm2reg or rs_use or rt_use  )
begin
fwda<=2'b00;
fwdb<=2'b00;

if( ewreg & (eGPR!=0) & (rs==eGPR) & ~em2reg & rs_use )
  
  begin
   fwda<=2'b01;
  end

else

  begin
   if( mwreg & (mGPR!=0) & (rs==mGPR) & ~mm2reg & rs_use )
     begin
      fwda<=2'b10;
     end
   else
     begin
      if( mwreg & (mGPR!=0) & (rs==mGPR) & mm2reg & rs_use )
      fwda<=2'b11;
     end
  end

if( ewreg & (eGPR!=0) & (rt==eGPR) & ~em2reg & rt_use )
 
  begin
   fwdb<=2'b01;
  end

else
  
  begin
    if( mwreg & (mGPR!=0) & (rt==mGPR) & ~mm2reg & rt_use )
     begin
      fwdb<=2'b10;
     end
   else
     begin
      if( mwreg & (mGPR!=0) & (rt==mGPR) & mm2reg & rt_use )
      fwdb<=2'b11;
     end
  end
  

end   //end always



//基本的几个控制信号输出regrt，EXTOp，dshift,dwreg,dm2reg,dwmem,djal,daluimm
reg dwreg,dm2reg,dwmem;
assign regrt=i_ori|i_lw|i_sw|i_lui;
assign EXTOp=i_lw|i_sw|i_beq;
assign dshift=r_sll|r_srl|r_sra;
always@(*) dwreg=(r_addu|r_subu|i_ori|i_lw|i_jal|i_lui|r_sll|r_srl|r_sra)&wpcir;
always@(*) dm2reg=i_lw;
always@(*) dwmem=i_sw & wpcir;
assign djal=i_jal;
assign daluimm=i_ori|i_lw|i_sw|i_lui;


//根据指令设置daluc信号
reg [2:0] daluc;
always @(*)
begin
 if(i_beq|r_jr|i_j|i_jal|NOP)
  daluc<=`ALU_NOP;
 if(r_addu|i_lw|i_sw)
  daluc<=`ALU_ADDU;
 if(r_subu)
  daluc<=`ALU_SUBU;
 if(i_ori)
  daluc<=`ALU_ORI;
 if(r_sll)
  daluc<=`ALU_SLL;
 if(r_srl)
  daluc<=`ALU_SRL;
 if(r_sra)
  daluc<=`ALU_SRA;
 if(i_lui)
  daluc<=`ALU_LUI;

end   //end always

endmodule