module regFile (
    input wire rst, 
    input wire clk,
    // write port 
    input wire we, // Write Enable 
    input wire [4:0]   wAddr, // Write Destination 
    input wire [31:0]  wData, // Write Data 
    // Read port 1
    input  wire  [4:0]  rAddr1,  // Read ADDRESS 1 
    output wire  [31:0] rData1, // Read DATA 1
     // Read port 2
    input  wire  [4:0]  rAddr2 ,  // Read ADDRESS 2 
    output wire [31:0]  rData2 // Read DATA 2
);
reg [31:0] array [31:0]; // define a memory of 32 BITS Width & 100 Locations
integer i;

always @(posedge clk or negedge rst )
    begin
        if (!rst)
            begin
                for ( i = 5'b0; i < 32; i = i + 1'b1)
                    array[i] <= 32'b0;
            end
        else
            begin
                if (we) //Write Active Low
                begin
                    array[wAddr] <= wData;
                end
            
            end
    end
    
assign rData1 = array[rAddr1];
assign rData2 = array[rAddr2];
endmodule