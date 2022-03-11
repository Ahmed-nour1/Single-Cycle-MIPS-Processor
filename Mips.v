module Mips (
    input  wire clock , reset , 
    input  wire [31:0] ReadData , Instr ,
    output wire [31:0] PC ,ALUOut ,WriteData ,
    output wire MemWrite 
);
//internal wires 

 wire zeroFlagW;
 wire PCsrcW;
 wire Bracnh_W;
 wire MemtoReg,Branch,ALUSrc,RegDst,RegWrite,Jump;
 wire [1:0] aluOp ;
 wire [2:0]aluCntrl; 

// instantiating hardware modules
datapath D1 (
    .clock(clock),
    .reset(reset),
    .ReadData(ReadData),
    .Instr(Instr),
    .MemtoRegW(MemtoReg),
    .PCsrc(PCsrcW), // 
    .ALUSrcW(ALUSrc),
    .RegDs1W(RegDst),
    .RegWriteW(RegWrite),
    .JumpW(Jump),
    .ALUcontrol(aluCntrl),
    .zeroFlag(zeroFlagW),
    .PC(PC),
    .ALUOut(ALUOut),
    .WriteData(WriteData)
    );

control CU(
    .Opcode(Instr[31:26]),
    .ALUOp(aluOp),//
    .MemWrite(MemWrite),
    .Branch(BranchW),
    .MemtoReg(MemtoReg),
    .RegDst(RegDst),
    .Jump(Jump),
    .ALUSrc(ALUSrc),
    .RegWrite(RegWrite)
    );

aluControl ALUCU(
     .funct(Instr[5:0]),
     .aluOp(aluOp),
     .aluCntrl(aluCntrl)
     );
     

assign PCsrcW = BranchW & zeroFlagW ;

endmodule