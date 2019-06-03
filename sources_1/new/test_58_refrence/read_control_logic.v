//***********************************************************//
// File Name: read_control_logic.v
// Module Name: read_control_logic
// Description: Controls the read operation of sync_fifo. Generates FIFO empty & almost empty flags.
// Author: Asim Anand
// Place: Cadence Design Systems, Inc.
// Date: July 8, 2008
//***********************************************************//

module read_control_logic #(parameter ADDR_WIDTH = 4,parameter AEMPTY = 3,parameter DEPTH = 16)
(// Inputs
input [ADDR_WIDTH:0] write_ptr,
input clk,
input reset_n,
input flush,
input read_req,
// Outputs
output read_enable,
output reg rdata_valid,
output fifo_empty,
output reg fifo_aempty,
output reg [ADDR_WIDTH:0] read_ptr );

wire [ADDR_WIDTH-1:0] read_addr;
wire [ADDR_WIDTH-1:0] write_addr;

// Extracting read and write address from corresponding pointers 
assign read_addr = read_ptr [ADDR_WIDTH-1:0];
assign write_addr = write_ptr [ADDR_WIDTH-1:0];

//FIFO is empty when read pointer is same as write pointer 
assign fifo_empty = (read_ptr == write_ptr);

// No read when FIFO is empty
assign read_enable = read_req && (~fifo_empty);

// Logic to generate almost empty flag
always @*
begin
	if (read_ptr[ADDR_WIDTH] == write_ptr[ADDR_WIDTH])
		fifo_aempty = ((write_addr - read_addr) <= AEMPTY);
	else
	fifo_aempty = ((read_addr - write_addr) >= (DEPTH - AEMPTY));
end

// Read pointer and read data valid generation logic
always @(posedge clk or negedge reset_n)
begin
	if (~reset_n)
		read_ptr <= {(ADDR_WIDTH+1){1'b0}};
	else if (flush)
		read_ptr <= {(ADDR_WIDTH+1){1'b0}};
	else if (read_enable)
		begin
			read_ptr <= read_ptr + {{ADDR_WIDTH{1'b0}},1'b1};
			rdata_valid <= 1'b1;
		end
	else
		rdata_valid <= 1'b0;
end

endmodule

