`include "ctrl_encode_def.v"
module alu(A, B, ALUOp, C);
    
   input   [31:0] A, B;
   input   [2:0]  ALUOp;
   output  [31:0] C;
   reg [31:0] C;
   integer i;
   
   always @( A or B or ALUOp ) begin
      case ( ALUOp )
          
          `ALU_ADDU: C = A + B;                    // ADDU,lw,sw
          `ALU_SUBU: C = A - B;                    // SUBU
          `ALU_ORI:   C = A | B;                    // ORI
          `ALU_SLL:  C = (B << A[4:0]);            // SLL
          `ALU_SRL:  C = (B >> A[4:0]);	           // SRL
          `ALU_SRA:  begin                         // SRA
		      for(i=1; i<=A[4:0]; i=i+1)
			     C[32-i] = B[31];
			    for(i=31-A[4:0]; i>=0; i=i-1)
			     C[i] = B[i+A[4:0]];
          end 
          `ALU_LUI:  C = {B[15:0],16'b0};          // LUI
             
          /*`ALU_SRA: begin                   s      // SRA/SRAV
		      for(i=1; i<=A[4:0]; i=i+1)
			     C[32-i] = B[31];
			    for(i=31-A[4:0]; i>=0; i=i-1)
			     C[i] = B[i+A[4:0]];
          end 
          C = {{A[4:0]{B[31]}},{(B>>A[4:0])[(31-A[4:0]):0]}} */ 

          default: C=32'b0;                 	   // BEQ,JR,J,JAL
      endcase
   end // end always
   

endmodule
    
