`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/26 09:55:42
// Design Name: 
// Module Name: count1s
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


module count1s(
	input 	[7:0]	i_data,
	output	[3:0]	o_count
);
// assign o_count = ( ( (i_data[0] + i_data[1]) + (i_data[2] + i_data[3]) ) + ( (i_data[4] +  i_data[5]) + (i_data[6] + i_data[7]) ) );
assign o_count = ((i_data[0] + i_data[1] + i_data[2]) + (i_data[3] + i_data[4] +  i_data[5]) + i_data[6]) + i_data[7];
endmodule
