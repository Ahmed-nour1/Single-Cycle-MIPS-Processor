module topmodule (      
    input  wire  clock , reset ,
    output wire [15:0] test_value
);
wire we,clk,rst ;
wire [31:0] addr, in , out; 
wire [31:0] pc  , instr ;


Mips M1 (
    .clock(clock),
    .reset(reset),
    .Instr(instr),
    .PC(pc),
    .ReadData(out),
    .ALUOut(addr),
    .WriteData(in),
    .MemWrite(we)
);

instMem i1(
    .pc(pc),
    .instr(instr)
);

dataMem dm1(
    .clk(clock),
    .rst(reset),
    .testValue(test_value),
    .in(in),
    .out(out),
    .addr(addr),
    .we(we)
);

endmodule