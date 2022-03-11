module alu (
    input  wire [31:0] a,      // srcA
    input  wire [31:0] b,      // srcB 
    input  wire [2:0]  s,      // function_sel
    output wire zero,   // Zero flag
    output  reg [31:0] result   // ALU Result
);
     
  always @(*) 
   begin
      case (s)
         3'b000:  result = a  &  b ;  // srcA & srcB
         
         3'b001:  result = a  |  b ;  // srcA or srcB

         3'b010:  result = a  +  b ;  // srcA + srcB

         3'b100:  result = a  -  b ;  // srcA - srcB 

         3'b101:  result = a  *  b ;  // srcA * srcB

         3'b110: result = (a < b)? 1'b1 : 1'b0; // SLT  function
                        
         default: result = a  +  b; // to handle the not used cases that happen at s~> 011 & 111
      endcase 
  end

  assign zero = (result==16'b0) ? 1'b1 : 1'b0; // check the value in the result if it is '0' we return 1 to the zero flag
endmodule