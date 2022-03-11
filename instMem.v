module instMem (
    input  wire  [31:0] pc, 
    output wire  [31:0] instr
);
reg [31:0] rom [99:0];

initial 
    begin
        // READING THE TEST MACHINE CODE (" Should be given")
        $readmemh("m1.txt",rom); 
    end
assign instr = rom [pc>>2] ; // SHIFT RIGHT By 2

endmodule