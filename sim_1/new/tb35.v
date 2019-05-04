`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/10 10:32:00
// Design Name: 
// Module Name: tb35
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


module tb35(    );
reg                 clk     ;
reg                 cs_n    ;
reg                 wr_n    ;
reg                 rd_n    ;
reg     [7:0]       din_b   ;
reg     [3:0]       addr_b  ;
reg     [3:0]       addr_a  ;
wire    [7:0]       dout_a  ;


initial fork
    clk = 1'b1;
    {cs_n,wr_n,rd_n} = 3'b111;
    din_b = 8'd0;
    addr_b = 4'd0;
    addr_a = 4'd0;
join

always #10 clk = ~ clk ;

initial begin
    #20  {cs_n,wr_n,rd_n} = 3'b001;   //写
    #320 {cs_n,wr_n,rd_n} = 3'b010;   //读
    #320 {cs_n,wr_n,rd_n} = 3'b000;   //读写
    #320 {cs_n,wr_n,rd_n} = 3'b011;
    #20  {cs_n,wr_n,rd_n} = 3'b111;
end

initial #20 begin
        repeat(15) #20 begin din_b = addr_b + 8'ha0; addr_b = addr_b + 1'b1; end
    #20 repeat(15) #20 begin addr_a = addr_a + 1'b1; addr_b = addr_b - 1'b1; end
    #20 repeat(15) #20 begin din_b = addr_b + 8'hB0; addr_b = addr_b + 1'b1; addr_a = addr_a - 1'b1;end
end

sy_dpram #(
    .WD (8 ),       //位宽
    .DP (16)       //深度
)
sy_dpram
(
    .clk    ( clk    ), 
    .cs_n   ( cs_n   ),
    .wr_n   ( wr_n   ),
    .rd_n   ( rd_n   ),
    .din_b  ( din_b  ),       //B口写入
    .addr_b ( addr_b ),
    .addr_a ( addr_a ),       //A口读出
    .dout_a ( dout_a )
    );
endmodule
