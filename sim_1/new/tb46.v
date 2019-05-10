`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/10 15:23:08
// Design Name: 
// Module Name: tb46
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


module tb46(    );
reg clk;
reg rst_n;
wire clk_out;

initial begin
    clk = 1;
    forever #10 clk = ~clk;
  end

initial begin
    rst_n = 1'b0;
    #22 rst_n = 1'b1;
  end

div_odd
#(
    3
    
)
div_odd
(
    .clk			(clk	),
    .rst_n		    (rst_n	),
    .clk_out        (clk_out)
);
endmodule
