// --------------------------------------------------------------------
// >>>>>>>>>>>>>>>>>>>>>>>>> COPYRIGHT NOTICE <<<<<<<<<<<<<<<<<<<<<<<<<
// --------------------------------------------------------------------
// Author: halftop
// Github: https://github.com/halftop
// Email: yu.zh@live.com
// Description: 
// Dependencies: 
// LastEditors: halftop
// Since: 2019-05-09 16:00:24
// LastEditTime: 2019-05-11 15:11:47
// ********************************************************************
// Module Function:
`timescale 1ns / 1ps

module test44(
    input					clk			,
    input					rst_n		,
    input       [7:0]       i_data      ,
    output      [7:0]       o_y         
);
// y(n) = 0.75x(n) + 0.25y(n-1) 
//0.75*4 = 3，0.25*4 = 1

reg [9:0] dout;

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        dout <= 'd0;
    end else begin
        dout <= 3*i_data + dout;
    end
end

assign o_y = dout>>2;

endmodule
