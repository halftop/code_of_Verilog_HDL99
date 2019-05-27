// --------------------------------------------------------------------
// >>>>>>>>>>>>>>>>>>>>>>>>> COPYRIGHT NOTICE <<<<<<<<<<<<<<<<<<<<<<<<<
// --------------------------------------------------------------------
// Author: halftop
// Github: https://github.com/halftop
// Email: yu.zh@live.com
// Description: 
// Dependencies: 
// Since: 2019-05-26 11:04:41
// LastEditors: halftop
// LastEditTime: 2019-05-26 11:04:41
// ********************************************************************
// Module Function:
module tb_cnt(    );
reg clk,rst_n;
wire [3:0]  o_cnt;

initial fork
  clk = 1'b0;
  rst_n = 1'b0;
  #20 rst_n = 1'b1;
  #455 rst_n = 1'b0;
  #475 rst_n = 1'b1;
  #600 $finish;
join

always #10 clk = ~ clk;

cnt**  cnt4(
    .clk    (clk  ),
    .rst_n  (rst_n),
    .o_cnt  (o_cnt)
    );
endmodule