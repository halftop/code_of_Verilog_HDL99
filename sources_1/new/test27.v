`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/01 16:07:43
// Design Name: 
// Module Name: test27
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


module test27(
    input clk, rst_n,
    output [3:0] o_cnt
    );
    reg [3:0] cnt;
//异步复位
/* always @ (posedge clk or negedge rst_n) begin
    if ( !rst_n )
        cnt <= 4'b0000;
    else if ( cnt == 4'b1111 )
        cnt <= 4'b0000;
    else
        cnt <= cnt + 1'b1;
end */
//同步复位
always @ (posedge clk) begin
    if ( !rst_n )
        cnt <= 4'b0000;
    else if ( cnt == 4'b1111 )
        cnt <= 4'b0000;
    else
        cnt <= cnt + 1'b1;
end

assign o_cnt = cnt;

endmodule
