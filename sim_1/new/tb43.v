// --------------------------------------------------------------------
// >>>>>>>>>>>>>>>>>>>>>>>>> COPYRIGHT NOTICE <<<<<<<<<<<<<<<<<<<<<<<<<
// --------------------------------------------------------------------
// Author: halftop
// Github: https://github.com/halftop
// Email: yu.zh@live.com
// Description: 
// Dependencies: 
// LastEditors: halftop
// Since: 2019-05-09 11:40:30
// LastEditTime: 2019-05-09 15:58:40
// ********************************************************************
// Module Function:
`timescale 1ns / 1ps

module tb43();
reg     			clk			;
reg     			rst_n		;
reg     [ 7:0]      i_data      ;
wire    [10:0]      o_y         ;

initial begin
    clk = 1;
    forever #10 clk = ~clk;
  end

initial begin
    rst_n = 1'b0;
    #22 rst_n = 1'b1;
    #3000  $finish;
  end


always @(posedge clk)
        i_data = {$random};


  test43
#(
     8 ,
     8
)
test43
(
    .clk		(clk	)	,
    .rst_n	(rst_n	)	,
    .i_data  (i_data  )  ,
    .o_y     (o_y     )   
);
endmodule
