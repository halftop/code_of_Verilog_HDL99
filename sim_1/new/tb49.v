`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/13 21:24:20
// Design Name: 
// Module Name: tb49
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


module tb49();
reg                    clk0        ;
reg                    clk1        ;
reg                    rst_n       ;
reg                    select      ;
wire                   outclk      ;

initial begin
    clk1 = 1;
    forever #10 clk1 = ~clk1;
  end

initial begin
    clk0 = 1;
    forever #20 clk0 = ~clk0;
  end

initial begin
    select = 1'b1;
    #102 select = 1'b0;
    #360 select = 1'b1;
end

initial begin
    rst_n = 1'b0;
    #22 rst_n = 1'b1;
  end

clk_switch clk_switch(
    .clk0        ( clk0   ),
    .clk1        ( clk1   ),
    .rst_n       ( rst_n  ),
    .select      ( select ),
    .outclk      ( outclk )
    );  
endmodule
