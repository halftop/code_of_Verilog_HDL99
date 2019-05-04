`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/24 15:42:41
// Design Name: 
// Module Name: test18
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


module test18(
    input   [4:0] data      ,
    output  [3:0] data_ceil ,
    output  [3:0] data_floor,
    output  [3:0] data_round
    );
    assign data_ceil = data[4] == 1'b0 ? {1'b0,data[3:1]+1'b1} : data[4:1];
    assign data_floor = data[4] == 1'b0 ? data[4:1] : data[4:1]-1'b1;
    assign data_round = data[0] == 1'b0 ? data[4:1] : data[4:1]+1'b1;
endmodule
