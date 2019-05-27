// --------------------------------------------------------------------
// >>>>>>>>>>>>>>>>>>>>>>>>> COPYRIGHT NOTICE <<<<<<<<<<<<<<<<<<<<<<<<<
// --------------------------------------------------------------------
// Author: halftop
// Github: https://github.com/halftop
// Email: yu.zh@live.com
// Description: 
// Dependencies: 
// Since: 2019-05-26 11:14:13
// LastEditors: halftop
// LastEditTime: 2019-05-26 11:14:13
// ********************************************************************
// Module Function:
module tb_pwm_led;
reg clk;
reg rst_n;
wire pwm_sig;

initial begin
    clk = 1;
    forever #1 clk = ~clk;
  end

initial begin
    rst_n = 1'b0;
    #22 rst_n = 1'b1;
    #20000 $finish;
  end

pwm_genrate
#(
    5,	//MHz
    1,	//us
    1,	//ms
    2		//s
)
pwm_led
(
    .clk		(clk	),
    .rst_n		(rst_n	),
    .pwm_sig	(pwm_sig)	
);
endmodule