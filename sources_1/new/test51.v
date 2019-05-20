// --------------------------------------------------------------------
// >>>>>>>>>>>>>>>>>>>>>>>>> COPYRIGHT NOTICE <<<<<<<<<<<<<<<<<<<<<<<<<
// --------------------------------------------------------------------
// Author: halftop
// Github: https://github.com/halftop
// Email: yu.zh@live.com
// Description: 异步复位，同步释放
// Dependencies: 
// Since: 2019-05-20 10:57:39
// LastEditors: halftop
// LastEditTime: 2019-05-20 10:57:39
// ********************************************************************
// Module Function: 异步复位，同步释放
module reset_gen (
    input					clk			, 
    input					rst_async_n	,
    output					rst_sync_n	
);
reg rst_s1, rst_s2;

always @ (posedge clk or negedge rst_async_n)
    if (!rst_async_n)
         begin 
            rst_s1 <= 1'b0;
            rst_s2 <= 1'b0;
        end
    else 
        begin
            rst_s1 <= 1'b1;
            rst_s2 <= rst_s1;
        end

assign rst_sync_n = rst_s2; //rst_sync_n才是我们真正对系统输出的复位信号

endmodule 