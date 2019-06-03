//***********************************************************//
// File Name: sync_fifo.v
// Module Name: sync_fifo
// Description: Synchronous FIFO
// Author: Asim Anand
// Place: Cadence Design Systems, Inc.
// Date: July 10, 2008
//***********************************************************//
module sync_fifo #(parameter ADDR_WIDTH = 4,parameter DATA_WIDTH = 16,parameter DEPTH = 16,parameter AEMPTY = 3,parameter AFULL = 3)
(// Inputs
input clk,
input reset_n,
input flush,
input read_req,
input [DATA_WIDTH-1:0] write_data,
input wdata_valid,
// Outputs
output [DATA_WIDTH-1:0] read_data,
output rdata_valid,
output fifo_empty,
output fifo_aempty,
output fifo_full,
output fifo_afull,
output write_ack
);
wire [ADDR_WIDTH:0] read_ptr;
wire [ADDR_WIDTH:0] write_ptr;
wire read_enable;
wire write_enable;

write_control_logic U_WRITE_CTRL (
.read_ptr(read_ptr),
.flush(flush),
.reset_n(reset_n),
.clk(clk),
.wdata_valid(wdata_valid),
.write_ack(write_ack),
.write_enable(write_enable),
.write_ptr(write_ptr),
.fifo_full(fifo_full),
.fifo_afull(fifo_afull)
);

read_control_logic U_READ_CTRL (
.write_ptr(write_ptr),
.clk(clk),
.reset_n(reset_n),
.flush(flush),
.read_req(read_req),
.read_enable(read_enable),
.rdata_valid(rdata_valid),
.fifo_empty(fifo_empty),
.read_ptr(read_ptr),
.fifo_aempty(fifo_aempty)
);

mem_array U_MEM_ARRAY (
.write_addr(write_ptr[ADDR_WIDTH-1:0]),
.read_addr(read_ptr[ADDR_WIDTH-1:0]),
.write_enable(write_enable),
.read_enable(read_enable),.clk(clk),//.reset_n(reset_n),
.write_data(write_data),.read_data(read_data));

endmodule

