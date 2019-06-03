//***********************************************************//
// File Name: write_control_logic.v
// Module Name: write_control_logic
// Description: Controls the write operation of sync_fifo.Generates FIFO full & almost full flags.
// Author: Asim Anand
// Place: Cadence Design Systems, Inc.
// Date: July 10, 2008
//***********************************************************//
module write_control_logic #(parameter ADDR_WIDTH = 4,parameter AFULL = 3,parameter DEPTH = 16)
(
// Inputs
input [ADDR_WIDTH:0] read_ptr,input wdata_valid,input flush,input reset_n,input clk,
// Outputs
output reg write_ack,output write_enable,output reg [ADDR_WIDTH:0] write_ptr,output fifo_full,output reg fifo_afull); 
wire [ADDR_WIDTH-1:0] write_addr;
wire [ADDR_WIDTH-1:0] read_addr; 

// Extracting read and write addresses
assign read_addr = read_ptr[ADDR_WIDTH-1:0];
assign write_addr = write_ptr[ADDR_WIDTH-1:0]; 

// Generating write enable
// No write when FIFO is full
assign write_enable = wdata_valid && (~fifo_full); 

// Generating fifo full status
// FIFO full is asserted when both pointers point to same address but their MSBs are different
assign fifo_full = ( (write_addr == read_addr) &&(write_ptr[ADDR_WIDTH] ^ read_ptr[ADDR_WIDTH]) ); 

// Generating fifo almost full status
always @*
begin
	if (write_ptr[ADDR_WIDTH] == read_ptr[ADDR_WIDTH])
		fifo_afull = ((write_addr - read_addr) >= (DEPTH - AFULL));
	else
		fifo_afull = ((read_addr - write_addr) <= AFULL);
end 

// Write pointer generation logic
always @(posedge clk or negedge reset_n)
begin
	if (~reset_n)
		begin
			write_ptr <= {(ADDR_WIDTH+1){1'b0}};
			write_ack <= 1'b0;
		end
	else if (flush)
		begin
			write_ptr <= {(ADDR_WIDTH+1){1'b0}};
			write_ack <= 1'b0;
		end
	else if (write_enable)
			begin
			write_ptr <= write_ptr + {{ADDR_WIDTH{1'b0}},1'b1};
			write_ack<= 1'b1;
			end
	else
		begin
			write_ack <= 1'b0;
		end
end

endmodule