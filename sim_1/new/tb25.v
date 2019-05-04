`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/26 21:07:23
// Design Name: 
// Module Name: tb25
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


module tb25;
reg clk     ;
reg enable  ;
reg data    ;
reg clr     ;
wire latch_q;
wire ff_q   ;

initial fork
    clk = 1'b1;
    enable = 1'b1;
    clr = 1'b1;
    data = 1'b0;
join

always #10 clk = ~ clk;

initial begin
    #30 data = 1'b1;
    #20 data = 1'b0;
    #20 data = 1'b1;
    #30 data = 1'b0;
end

latch_ff latch_ff(
    .clk        (clk    ),
    .enable     (enable ),
    .data       (data   ),
    .clr        (clr    ),
    .latch_q    (latch_q),
    .ff_q       (ff_q   )
    );
endmodule
