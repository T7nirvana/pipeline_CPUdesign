// NPC control signal
`define NPC_PLUS4   2'b00    //pc+4
`define NPC_BRANCH  2'b01    //beq地址
`define NPC_JR      2'b10    //jr地址
`define NPC_JUMP    2'b11    //j&jal地址




// EXT control signal
`define EXT_ZERO    1'b0   //零扩展
`define EXT_SIGNED  1'b1   //符号扩展
//`define EXT_HIGHPOS 2'b10   //lui指令移至高16位




// ALU control signal         //*指令的code*

`define ALU_NOP   3'b000// beq,j,jr,jal不做任何处理的aluop

`define ALU_ADDU  3'b001// ADDU,LW,SW
//`define ALU_LW    3'b001
//`define ALU_SW    3'b001

`define ALU_SUBU  3'b010

`define ALU_ORI   3'b011

`define ALU_SLL   3'b100
`define ALU_SRL   3'b101
`define ALU_SRA   3'b110
`define ALU_LUI   3'b111





// GPR control signal
/*`define GPRSel_RD   2'b00
`define GPRSel_RT   2'b01
`define GPRSel_31   2'b10

`define WDSel_FromALU 2'b00
`define WDSel_FromMEM 2'b01
`define WDSel_FromPC  2'b10 
*/