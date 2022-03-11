module datapath (
    // control unit outputs // 
input  wire   MemtoRegW, PCsrc,
input  wire   ALUSrcW, RegDs1W, RegWriteW, JumpW,
input  wire   [2:0] ALUcontrol, 
input  wire   clock , reset ,
input  wire   [31:0] ReadData ,Instr ,
output wire   zeroFlag ,
output wire   [31:0] PC, ALUOut, WriteData

);

//internal wires 


// RegFile PART //
wire [31:0] RReg1, RReg2; 
wire [4:0]  A3;   

// ALU PART // 
wire [31:0] srcB; //mux output 
wire [31:0] ALUResult;
wire [31:0] signImm, signImmSH;
wire [31:0] result; //mux output
wire [31:0] outDM;

//instr M PART // 
wire [31:0] pcIn, PCPlus4, instrSH, PCBranch, PCLd;




// instantiating hardware modules
pc PC1(
     .clk(clock),
     .rst(reset),
     .in(pcIn),
     .pc(PC)
     );
alu ALU(
     .a(RReg1),
     .b(srcB), 
     .s(ALUcontrol), 
     .zero(zeroFlag), 
     .result(ALUResult)
     );

regFile RF(
     .clk(clock) ,
     .rst(reset), 
     .we(RegWriteW) ,
     .wAddr(A3) ,
     .wData(result),
     .rAddr1(Instr[25:21]),
     .rData1(RReg1), 
     .rAddr2(Instr[20:16]),
     .rData2(RReg2)
     );

signExtend SE(
     .in(Instr[15:0]),
     .out(signImm)
     );

adder A1(
     .A(PC), 
     .B(32'd4),
     .Res(PCPlus4)
     );

shiftLeft SL1(
     .in(Instr),
     .out(instrSH)
     ); 

shiftLeft SL2(
    .in(signImm),
    .out(signImmSH)
     );

adder A2(
    .A(PCPlus4),
    .B(signImmSH),
    .Res(PCBranch)
     );
    
// Muxs // 
mux M1(
    .sel(JumpW),
    .in1(PCLd), 
    .in2({PCPlus4[31:28], instrSH[27:0]}) ,
    .out(pcIn)
     ) ;

mux M2(
    .sel(PCsrc),
    .in1(PCPlus4),
    .in2(PCBranch),
    .out(PCLd)
     ) ;

mux M3(
    .sel(RegDs1W),
    .in1({27'd0,Instr[20:16]}),
    .in2({27'd0,Instr[15:11]}),
    .out(A3)
     );

mux M4(
    .sel(ALUSrcW),
    .in1(RReg2),
    .in2(signImm),
    .out(srcB)
     ) ;
    
mux M5(
    .sel(MemtoRegW),
    .in1(ALUResult), 
    .in2(outDM),
    .out(result)
     ) ;
//
assign ALUOut    = ALUResult;
assign outDM     = ReadData ;
assign WriteData = RReg2;

endmodule