`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/02 11:22:59
// Design Name: 
// Module Name: tb29
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


module tb29(    );
reg     clk, rst_n, data;
wire    flag_101;

  initial begin
    clk = 0;
    forever #10 clk = ~clk;
  end
  
  initial begin
    rst_n = 1'b0;
    #22 rst_n = 1'b1;
  end

  initial begin
    repeat(100)begin
      @(negedge clk)
	      data = {$random};
    end
    $finish;
  end
  
/*   initial begin
    $dumpfile("seq101_tb.vcd");
    $dumpvars();
  end */

test29 test29(
    .clk        (clk     ), 
    .rst_n      (rst_n   ), 
    .data       (data    ),
    .flag_101   (flag_101)
    );
endmodule
