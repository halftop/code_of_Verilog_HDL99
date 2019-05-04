`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/26 09:58:14
// Design Name: 
// Module Name: tb20
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


module tb20;
reg     [7:0]	i_data  ;
wire    [3:0]	o_count ;

initial begin
    i_data = 8'b1111_1111;
    #100 repeat (51) #20 i_data = i_data - 'd5;
end

count1s count1s(
	.i_data     (i_data ),
	.o_count    (o_count)
);
endmodule
