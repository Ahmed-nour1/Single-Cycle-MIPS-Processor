`timescale 1ns/100ps
module  Mips_tb ();

 reg clk_tb ; 
 reg reset_tb ;

 wire [15:0] test_value;

localparam clk_period = 50 ;

//------ generating a clock ------//

always #(clk_period/2)  clk_tb =~clk_tb ; 

//------ instantiating the top module ------//

topmodule t1(
    .clock(clk_tb),
    .reset(reset_tb),
    .test_value(test_value)
);

initial 
begin
    clk_tb=  1'b0;
    reset_tb=1'b0;
// reset 
#(0.3*clk_period)
reset_tb=1'b0;

#(0.7*clk_period)
reset_tb=1'b1;

#(50*clk_period)
$display ("Test Value = %h",test_value);

$stop;


end



    
endmodule