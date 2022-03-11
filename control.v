module control (
    
    input [5:0]  Opcode,
    output reg [1:0] ALUOp ,
    output reg MemtoReg,MemWrite,Branch,ALUSrc,RegDst,RegWrite,Jump

);
   always @(*)
      begin
         case (Opcode)
            6'b100011 :begin  //  LOAD WORD 
               
                Jump     = 0 ;
                ALUOp    = 00 ;
                MemWrite = 0 ;
                RegWrite = 1 ;
                RegDst   = 0 ;
                ALUSrc   = 1 ;
                MemtoReg = 1 ;
                Branch   = 0 ;
                   
                      end 

           6'b101011 : begin // STORE WORD 
                
                Jump     = 0 ;
                ALUOp    = 00 ;
                MemWrite = 1 ;
                RegWrite = 0 ;
                RegDst   = 0 ;
                ALUSrc   = 1 ;
                MemtoReg = 1 ;
                Branch   = 0 ;
                   
                     end

          6'b000000 : begin // r_Type instructions 

                Jump     = 0 ;
                ALUOp    = 10 ;
                MemWrite = 0 ;
                RegWrite = 1 ;
                RegDst   = 1 ;
                ALUSrc   = 0 ;
                MemtoReg = 0 ;
                Branch   = 0 ;

                     end    

           6'b001000 : begin // add Immediate 
                Jump     = 0 ;
                ALUOp    = 00 ;
                MemWrite = 0 ;
                RegWrite = 1 ;
                RegDst   = 0 ;
                ALUSrc   = 1 ;
                MemtoReg = 0 ;
                Branch   = 0 ;
               
                     end

           6'b000100: begin // BEQ 
                Jump     = 0 ;
                ALUOp    = 01 ;
                MemWrite = 0 ;
                RegWrite = 0 ;
                RegDst   = 0 ;
                ALUSrc   = 0 ;
                MemtoReg = 0 ;
                Branch   = 1 ;
               
           end

           6'b000010: begin // Jump_inst
                Jump     = 1 ;
                ALUOp    = 00 ;
                MemWrite = 0 ;
                RegWrite = 0 ;
                RegDst   = 0 ;
                ALUSrc   = 0 ;
                MemtoReg = 0 ;
                Branch   = 0 ;
               
           end
                    
             default: begin // default case act as a reset to all the signals
                Jump     = 0 ;
                ALUOp    = 00 ;
                MemWrite = 0 ;
                RegWrite = 0 ;
                RegDst   = 0 ;
                ALUSrc   = 0 ;
                MemtoReg = 0 ;
                Branch   = 0 ;
            
           end 

         endcase
       
      end
endmodule