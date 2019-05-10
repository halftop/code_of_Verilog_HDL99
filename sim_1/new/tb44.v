`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/09 16:13:30
// Design Name: 
// Module Name: tb44
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
  end


always @(posedge clk)
        i_data = {$random};

test44 test44
(
    .clk		(clk	)	,
    .rst_n	    (rst_n	)	,
    .i_data     (i_data )   ,
    .o_y        (o_y    )   
);
endmodule
