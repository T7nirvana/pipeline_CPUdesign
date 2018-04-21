`include "alu.v"
`include "mux.v"

module pipeEXE(ejal,ealuc,ealuimm,eshift,epc4,ea,eb,eimm,eGPR_org,eGPR,ealu);

input ejal,ealuimm,eshift;
input [2:0]ealuc;
input [31:0]epc4,ea,eb,eimm;
input [4:0]eGPR_org;

output [4:0]eGPR;
output [31:0]ealu;

wire [31:0]sa;
assign sa={eimm[5:0],eimm[31:6]};

wire [31:0]alu_a,alu_b;
mux2 #(32) SELalu_a(ea,sa,eshift,alu_a);
mux2 #(32) SELalu_b(eb,eimm,ealuimm,alu_b);

wire [31:0]ealu_org,epc8;
alu ALU_unit(alu_a, alu_b, ealuc, ealu_org);
assign epc8=epc4+4;
mux2 #(32) save_pc8(ealu_org,epc8,ejal,ealu);

mux2 SEL_eGPR(eGPR_org,5'd31,ejal,eGPR);  //assign eGPR=eGPR_org|{5{ejal}};也可代替这句功能，妙哉妙哉，位运算符的魔力
endmodule