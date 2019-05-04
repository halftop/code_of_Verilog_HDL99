`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/25 15:51:20
// Design Name: 
// Module Name: tb19
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


/* module tb19(    );
reg     [ 7:0]  i_a     ;
reg     [ 7:0]  i_b     ;
wire    [15:0]  o_y     ;

initial begin
  i_a = 8'd0;
  #20 i_a = 8'd10;
  #20 i_a = 8'd128;
  #20 i_a = 8'd255;
end

initial begin
  i_b = 8'd255;
  #20 i_b = 8'd128;
  #20 i_b = 8'd128;
  #20 i_b = 8'd255;
end

test19 unsigned_mul(
    .i_a ( i_a )    ,
    .i_b ( i_b )    ,
    .o_y ( o_y )
);
endmodule */

/* module tb19(    );
reg signed    [ 7:0]  i_a     ;
reg signed    [ 7:0]  i_b     ;
wire    signed      [14:0]  o_y     ;

initial begin
  i_a = 8'sd0;
  #20 i_a = -8'sd10;
  #20 i_a = -8'sd128;
  #20 i_a = 8'sd127;
end

initial begin
  i_b = 8'sd127;
  #20 i_b = +8'sd100;
  #20 i_b = -8'sd128;
  #20 i_b = 8'sd127;
end

test19 unsigned_mul(
    .i_a ( i_a )    ,
    .i_b ( i_b )    ,
    .o_y ( o_y )
);
endmodule */

module tb19(    );
reg signed    [ 7:0]  i_a     ;
reg           [ 7:0]  i_b     ;
wire    signed      [15:0]  o_y     ;

initial begin
  i_a = 8'sd0;
  #20 i_a = -8'sd10;
  #20 i_a = -8'sd128;
  #20 i_a = 8'sd127;
end

initial begin
  i_b = 8'd127;
  #20 i_b = 8'd100;
  #20 i_b = 8'd255;
  #20 i_b = 8'd255;
end

test19 unsigned_mul(
    .i_a ( i_a )    ,
    .i_b ( i_b )    ,
    .o_y ( o_y )
);
endmodule 