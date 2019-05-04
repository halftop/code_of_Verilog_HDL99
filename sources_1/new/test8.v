`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/26 10:55:21
// Design Name: 
// Module Name: mux2com
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


module mux2com(
    input       a,
    input       b,
    input       c,
    input       d,

    input       s0,s1,

    output      f_inv,
    output      f_buffer,
    output      f_and2,
    output      f_or2,
    output      f_mux4,

    output      adder_sum,
    output      adder_carry
    );

assign f_inv = a ? 0 : 1;

assign f_buffer = a ? 1 : 0;

assign f_and2 = a ? b : 0;

assign f_or2 = a ? 1 : b;

assign f_mux4 = s1 ? (s0?a:b) : (s0?c:d);

assign adder_sum = (a?(b?0:1):b)?(c?0:1):c;     
assign adder_carry = (c?b:0)?1:((c?a:0)?1:(b?a:0));
endmodule
