// --------------------------------------------------------------------
// >>>>>>>>>>>>>>>>>>>>>>>>> COPYRIGHT NOTICE <<<<<<<<<<<<<<<<<<<<<<<<<
// --------------------------------------------------------------------
// Author: halftop
// Github: https://github.com/halftop
// Email: yu.zh@live.com
// Description: 二分频
// Dependencies: 
// LastEditors: halftop
// Since: 2019-05-10 10:37:19
// LastEditTime: 2019-05-10 11:04:06
// ********************************************************************
// Module Function:二分频
`timescale 1ns / 1ps

module div_2(
    input					clk			,
    input					rst_n		,
    output  reg             clk_out     
);

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        clk_out <= 1'b0;
    end else begin
        clk_out <= ~clk_out;
    end
end

endmodule
