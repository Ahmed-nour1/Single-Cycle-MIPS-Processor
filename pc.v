module pc (
    input wire [31:0] in, 
    input wire clk,
    input wire rst,
    output reg [31:0] pc 
);
    
always @(posedge clk or negedge rst) 
    begin
        if(!rst)
            pc <= 32'd0;
        else
            pc <= in;
    end
endmodule