`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/31 11:02:07
// Design Name: 
// Module Name: test26
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


module test26(
    input   clk, rst_n, data,
    output  rise_edge,  //上升沿
    output  fall_edge,  //下降沿
    output  data_edge   //边沿
    );

reg data_r,data_rr;

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        data_r  <= 1'b0;
        data_rr <= 1'b0;     
    end else begin
      data_r    <= data;
      data_rr   <= data_r;
    end
end

assign rise_edge = ( ~data_rr && data_r ) ? 1'b1 : 1'b0 ;
assign fall_edge = ( data_rr && ~data_r ) ? 1'b1 : 1'b0 ;
assign data_edge = ( data_rr^data_r ) ? 1'b1 : 1'b0 ;
endmodule
