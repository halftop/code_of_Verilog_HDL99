//***********************************************************//
// File Name: mem_array.v
// Module Name: mem_array
// Description: FIFO internal memory to store incoming data. It is implemented as flop-array
// Author: Asim Anand
// Place: Cadence Design Systems, Inc.
// Date: July 10, 2008
//***********************************************************//

module mem_array #(parameter ADDR_WIDTH = 4,parameter DEPTH = 16,parameter DATA_WIDTH = 16)
(
input [ADDR_WIDTH-1:0] write_addr,input [ADDR_WIDTH-1:0] read_addr,
input write_enable,input read_enable,input clk,input [DATA_WIDTH-1:0] write_data,

output reg [DATA_WIDTH-1:0] read_data); 

reg [DATA_WIDTH-1:0] mem [0:DEPTH-1];

// Mem write
always @(posedge clk)
begin
	if (write_enable)
		mem[write_addr] <= write_data;
end 
// Mem Read
always @(posedge clk)
begin
	if (read_enable)
	begin
		read_data <= mem[read_addr];
	end
end

endmodule

