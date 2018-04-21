`include "mux.v"
`include "im.v"

module pipeIF(NPCOp,pc,bpc,rpc,jpc,pc4,npc,ins);

input [1:0] NPCOp;
input [31:0] pc,bpc,rpc,jpc;
output [31:0] ins,npc,pc4;

mux4 New_PC(pc4,bpc,rpc,jpc,NPCOp,npc);
assign pc4=pc+4;
im inst_MEM(pc[11:2],ins);

endmodule

