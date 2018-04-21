`include "dm.v"

module pipeMEM(clk,rst,mwmem,malu,mb,mmo);

input clk,rst,mwmem;
input [31:0] malu,mb;

output [31:0] mmo;

dm data_MEM( malu[11:2], mb, mwmem, ~clk, rst , mmo );
//注意在时钟下降沿写DM，对寄存器堆也是如此，这样可以保证前半个周期写的值后半个周期就可以读到

endmodule