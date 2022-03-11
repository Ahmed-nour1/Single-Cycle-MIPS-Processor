module dataMem (

output wire [31: 0] out,
output wire [15:0] testValue,

input wire [31: 0] in,
input wire [31: 0] addr,
input wire  we, clk, rst
);
    
reg [31: 0] mem[99: 0];
integer i;

always @(posedge clk or negedge rst)
    begin
        if(!rst)
            for(i = 8'b0; i < 100; i = i + 1'b1)
                mem[i] <= {(32){1'b0}};
        else if(we) //Write active low
                mem[addr] <= in;            
    end

assign out = mem [addr] ;
assign testValue = mem[32'd0];

endmodule