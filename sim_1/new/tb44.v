// --------------------------------------------------------------------
// >>>>>>>>>>>>>>>>>>>>>>>>> COPYRIGHT NOTICE <<<<<<<<<<<<<<<<<<<<<<<<<
// --------------------------------------------------------------------
// Author: halftop
// Github: https://github.com/halftop
// Email: yu.zh@live.com
// Description: 
// Dependencies: 
// LastEditors: halftop
// Since: 2019-05-09 16:13:27
// LastEditTime: 2019-05-11 15:12:19
// ********************************************************************
// Module Function:
`timescale 1ns / 1ps

module tb44();
reg     			clk			;
reg     			rst_n		;
reg     [ 7:0]      i_data      ;
wire    [ 7:0]      o_y         ;

initial begin
    clk = 1;
    forever #10 clk = ~clk;
  end

initial begin
    rst_n = 1'b0;
    #22 rst_n = 1'b1;
//    #1000 $finish;
  end


always @(negedge clk)
        i_data = {$random};

test44 test44
(
    .clk		(clk	)	,
    .rst_n	    (rst_n	)	,
    .i_data     (i_data )   ,
    .o_y        (o_y    )   
);
endmodule
