// OP
`define INST_RTYPE_OP      6'b000000
`define INST_NOP_OP        6'B000000
`define INST_ORI_OP        6'b001101

`define INST_LW_OP         6'b100011
`define INST_SW_OP         6'b101011

`define INST_LUI_OP        6'b001111

`define INST_BEQ_OP        6'b000100
`define INST_J_OP          6'b000010
`define INST_JAL_OP        6'b000011


// FUNCT

`define INST_ADDU_FUNCT    6'b100001
`define INST_SUBU_FUNCT    6'b100011


`define INST_SLL_FUNCT     6'b000000
`define INST_SRL_FUNCT     6'b000010
`define INST_SRA_FUNCT     6'b000011
   
`define INST_JR_FUNCT      6'b001000
`define INST_NOP_FUNCT     6'B000000   

