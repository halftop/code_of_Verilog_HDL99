`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/28 15:37:22
// Design Name: 
// Module Name: test58
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module synch_fifo
#(
    parameter FIFO_WIDTH    = 16    ,
              FIFO_DEPTH    = 16     
)
(
    input					clk			,
    input					rst_n		,
    
    input                   wr_en       ,
    input       [FIFO_WIDTH-1:0]    write_data  ,
    output                  fifo_full   ,

    input                   rd_en       ,
    output      [FIFO_WIDTH-1:0]    read_data   ,
    output                  fifo_empty   
);

localparam  ADDR_WIDTH = clogb2(FIFO_DEPTH);

reg [ADDR_WIDTH:0] wr_ptr;  //写指针
reg [ADDR_WIDTH:0] rd_ptr;  //读指针

wire [ADDR_WIDTH-1:0] write_addr;
wire [ADDR_WIDTH-1:0] read_addr; 

assign write_addr = wr_ptr[ADDR_WIDTH-1:0];
assign read_addr = rd_ptr[ADDR_WIDTH-1:0];

//有效的读写信号
wire valid_wr;
wire valid_rd;
assign valid_wr = wr_en && !fifo_full;
assign valid_rd = rd_en && !fifo_empty;
//满、空标志
assign fifo_full = ( (write_addr==read_addr) && (wr_ptr[ADDR_WIDTH]^rd_ptr[ADDR_WIDTH]) );
assign fifo_empty = wr_ptr == rd_ptr;

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) 
        wr_ptr <= 'd0;
    else if(valid_wr)
        wr_ptr <= wr_ptr + 1'b1;
    else
        wr_ptr <= wr_ptr;
end

always @(posedge clk or negedge rst_n) begin
    if (!rst_n)
        rd_ptr <= 'd0;
    else if (valid_rd)
        rd_ptr <= rd_ptr + 1'b1;
    else
        rd_ptr <= rd_ptr;
end

function integer clogb2 (input integer depth);
    begin
        for(clogb2=0; depth>1; clogb2=clogb2+1)
        depth = depth >> 1;
    end
endfunction

as_dpram    //test36
#(
    .WD(FIFO_WIDTH),       //数据位宽
    .AD(ADDR_WIDTH)        //地址位宽
)
fifo_sram
(
    .clk_a   ( clk ), 
    .rda_n   ( !valid_rd ),
    .addr_a  ( read_addr ), 
    .dout_a  ( read_data ), 

    .clk_b   ( clk ), 
    .wrb_n   ( !valid_wr ),
    .din_b   ( write_data ), 
    .addr_b  ( write_addr ), 

    .cs_n    ( !rst_n ) 
    );
endmodule