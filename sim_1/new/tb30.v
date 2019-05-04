`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/03 22:19:41
// Design Name: 
// Module Name: tb30
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


module tb30(    );
reg            clk             ;
reg            rst_n           ;
reg            sel_x           ;
reg     [ 7:0] da_x            ;
reg     [ 7:0] da_y            ;
reg     [ 7:0] db_x            ;
reg     [ 7:0] db_y            ;
wire    [15:0] dout_x_y        ;

initial fork
    clk = 1'b0          ;
    rst_n = 1'b0        ;
    #20 rst_n  = 1'b1   ;
    sel_x = 1'b0        ;
    da_x = 8'd0         ;
    da_y = 8'd0         ;
    db_x = 8'd255       ;
    db_y = 8'd127       ;
join

always #10 clk = ~clk;

always #20 sel_x = ~sel_x;

initial fork
  repeat(40) #40 da_x = da_x + 1'b1;
  repeat(80) #20 da_y = da_y + 1'b1;
  repeat(27) #60 db_x = db_x - 1'b1;
  repeat(20) #80 db_y = db_y - 1'b1;
join

test30 test30(
    .clk             (clk     ),
    .rst_n           (rst_n   ),
    .sel_x           (sel_x   ),
    .da_x            (da_x    ), 
    .da_y            (da_y    ), 
    .db_x            (db_x    ), 
    .db_y            (db_y    ), 
    .dout_x_y        (dout_x_y) 
    );
endmodule
