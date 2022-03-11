module aluControl (
    input  wire [1:0] aluOp,
    input  wire [5:0] funct,
    output reg  [2:0] aluCntrl
    
);
always @(*) begin
    casex ({aluOp,funct})
    
        8'b00xxxxxx: aluCntrl = 3'b010; // ADD FOR THE ADDRESS OFFSET

        8'b01xxxxxx: aluCntrl = 3'b100;

        8'b10100000: aluCntrl = 3'b010;  // ADD " R TYPE "

        8'b10100010: aluCntrl = 3'b100;  // SUB " R TYPE "

        8'b10101010: aluCntrl = 3'b110;  // SLT

        8'b10011100: aluCntrl = 3'b101;  // Mul

        default: aluCntrl = 3'b010;
    endcase
end
endmodule