`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/03 15:23:49
// Design Name: 
// Module Name: test30
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


module test30(
    input              clk             ,
    input              rst_n           ,
    input              sel_x           ,
    input       [ 7:0] da_x            , 
    input       [ 7:0] da_y            , 
    input       [ 7:0] db_x            , 
    input       [ 7:0] db_y            , 
    output  reg [15:0] dout_x_y
    );
    wire    [ 7:0] da;
    wire    [ 7:0] db;
    wire    [15:0] dout;
assign da = sel_x ? da_x : da_y;
assign db = sel_x ? db_y : db_x;
assign dout = da * db ;

always @(posedge clk or negedge rst_n) begin
  if (!rst_n) begin
    dout_x_y <= 16'd0;
  end else begin
    dout_x_y <= dout;
  end
end
endmodule
