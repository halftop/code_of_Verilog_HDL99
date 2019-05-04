`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/24 16:07:00
// Design Name: 
// Module Name: tb18
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


module tb18(    );

reg             [4:0] data      ;
wire            [3:0] data_ceil ;
wire            [3:0] data_floor;
wire            [3:0] data_round;

reg signed [3:0] data_int = -4'sd8;
reg              data_dec = 1'b1;

initial
fork
  repeat(15) #20 data_int = data_int + 2'sd1;
  repeat(30) #10 data_dec = ~ data_dec;
join

always @ (*) data = {data_int,data_dec};

test18 int_get(
  .data        ( data      ),
  .data_ceil   ( data_ceil ),
  .data_floor  ( data_floor),
  .data_round  ( data_round)
);

endmodule