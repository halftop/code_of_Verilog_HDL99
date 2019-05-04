`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/02 10:39:36
// Design Name: 
// Module Name: test29
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


module test29(
input clk, rst_n, data,
output reg flag_101
    );
parameter   ST0 = 4'b0001,
            ST1 = 4'b0010,
            ST2 = 4'b0100,
            ST3 = 4'b1000;

reg [3:0] c_st;
reg [3:0] n_st;
//FSM-1
always @(posedge clk or negedge rst_n) begin
  if (!rst_n) begin
    c_st <= ST0;
  end else begin
    c_st <= n_st;
  end
end
//FSM-2
always @(*) begin
  case (c_st)
    ST0: n_st = data ? ST1 : ST0;
    ST1: n_st = data ? ST1 : ST2;
    ST2: n_st = data ? ST3 : ST0;
    ST3: n_st = data ? ST1 : ST2;
    default: n_st = ST0;
  endcase
end
//FSM-3
always @(posedge clk or negedge rst_n) begin
  if (!rst_n) begin
    flag_101 <= 1'b0;
  end else begin
    case (n_st)
      ST3: flag_101 <= 1'b1;
      ST0,ST1,ST2: flag_101 <= 1'b0;
      default: flag_101 <= 1'b0;
    endcase
  end
end
endmodule
