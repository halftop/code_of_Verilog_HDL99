// --------------------------------------------------------------------
// >>>>>>>>>>>>>>>>>>>>>>>>> COPYRIGHT NOTICE <<<<<<<<<<<<<<<<<<<<<<<<<
// --------------------------------------------------------------------
// Author: halftop
// Github: https://github.com/halftop
// Email: yu.zh@live.com
// Description: 异步复位，同步释放并支持测试模式的复位信号切换
// Dependencies: 
// Since: 2019-05-20 10:57:39
// LastEditors: halftop
// LastEditTime: 2019-05-20 10:57:39
// ********************************************************************
// Module Function: 异步复位，同步释放并支持测试模式的复位信号切换
module reset_gen (
    input					clk			, 
    input					rst_async_n	,
    input                   test_shift  ,
    output					rst_sync_n	
);
reg rst_s1;
reg rst_s2;
wire tmrst;

assign  tmrst = rst_async_n | test_shift;

always @ (posedge clk or negedge tmrst)
    if (!tmrst)
         begin 
            rst_s1 <= 1'b0;
            rst_s2 <= 1'b0;
        end
    else 
        begin
            rst_s1 <= 1'b1;
            rst_s2 <= rst_s1;
        end

assign rst_sync_n = rst_s2;

endmodule 