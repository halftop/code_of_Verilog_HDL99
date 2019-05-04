`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/25 15:41:29
// Design Name: 
// Module Name: test19
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


/* module test19(
    input       [ 7:0]  i_a     ,
    input       [ 7:0]  i_b     ,
    output      [15:0]  o_y
    );

    assign o_y = i_a * i_b;
endmodule
 */

/*  module test19(
    input    signed   [ 7:0]  i_a     ,
    input    signed   [ 7:0]  i_b     ,
    output   signed   [14:0]  o_y
    );

    assign o_y = i_a * i_b;
endmodule */

 module test19(
    input    signed   [ 7:0]  i_a     ,
    input             [ 7:0]  i_b     ,
    output   signed   [15:0]  o_y
    );
/*     wire    signed  [8:0]   b_r;
    assign b_r = {1'b0,i_b}; */

    
    // assign o_y = i_a * b_r;
    assign o_y = i_a * $signed({1'b0,i_b});
endmodule