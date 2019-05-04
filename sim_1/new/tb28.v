`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/02 10:05:03
// Design Name: 
// Module Name: tb28
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


/* module tb28(    );
reg clk, rst_n, data_i;
wire [7:0] data_o;

initial fork
    clk = 1'b0;
    rst_n = 1'b0;
    #20 rst_n = 1'b1;
    #10 data_i = 1'b1;
join

always #10 clk = ~clk;
always #15 data_i = ~data_i;

test28 test28(
    .clk     ( clk    ), 
    .rst_n   ( rst_n  ), 
    .data_i  ( data_i ),
    .data_o  ( data_o )
    );
endmodule */

module tb28;

parameter tWIDTH = 6;

reg 				clk			;
reg 				rst_n		;
reg [5:0]	        data_in		;
reg [1:0]			mode		;
wire [5:0]	        data_out	;

initial begin
    clk = 1;
    forever #10 clk = ~clk;
  end

initial begin
    rst_n = 1'b0;
    #22 rst_n = 1'b1;
  end

initial fork 
    data_in = 'h0;
    #22
    repeat(2*tWIDTH+1)begin	//2*mode0+1*mode1
      @(negedge clk)
	      data_in = {$random};
    end
    #(30+(3*tWIDTH+2)*20)   data_in = {$random};	//1*mode1
    #(30+(4*tWIDTH+3)*20) 
    repeat(2*tWIDTH+1)begin	//1*mode2+1*mode3
      @(negedge clk)
	      data_in = {$random};
    end
	#(30+(6*tWIDTH+4)*20) 
    repeat(2*tWIDTH)begin	//2*mode0
      @(negedge clk)
	      data_in = {$random};
    end
    #(30+(8*tWIDTH+7)*20)   $finish;
join

initial fork 
mode = 2'b00;
#(30+(2*tWIDTH+1)*20) mode = 2'b01;
#(30+(4*tWIDTH+3)*20) mode = 2'b10;
#(30+(5*tWIDTH+4)*20) mode = 2'b11;
#(30+(6*tWIDTH+5)*20) mode = 2'b00;
join

initial begin
    $dumpfile("s_q_con.vcd");
    $dumpvars();
end

s_p_conver 
#(
	.WIDTH(tWIDTH)
)
s_p_conver
(
	.clk			( clk	  ),
	.rst_n		    ( rst_n	  ),
	.data_in		( data_in ),
	.data_out	    ( data_out),
	.mode		    ( mode	  )
);
endmodule
