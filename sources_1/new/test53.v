// --------------------------------------------------------------------
// >>>>>>>>>>>>>>>>>>>>>>>>> COPYRIGHT NOTICE <<<<<<<<<<<<<<<<<<<<<<<<<
// --------------------------------------------------------------------
// Author: halftop
// Github: https://github.com/halftop
// Email: yu.zh@live.com
// Description: 
// Dependencies: 
// Since: 2019-05-26 11:01:32
// LastEditors: halftop
// LastEditTime: 2019-05-26 11:01:32
// ********************************************************************
// Module Function: 约翰逊计数器
module cnt_johnson(
    input clk, rst_n,
    output [3:0] o_cnt
    );
    reg [3:0] cnt;
always @(posedge clk or negedge rst_n) begin
	if (!rst_n) begin
		cnt <= 4'b0000;
	end else begin
		cnt <= {~cnt[0],cnt[3:1]};
	end
end

assign o_cnt = cnt;

endmodule