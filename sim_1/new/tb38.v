`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/17 20:59:45
// Design Name: 
// Module Name: tb38
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


module tb38(    );
reg         clk     ;
reg         rst_n   ;
reg [7:0]   din     ;
wire [7:0]  dout    ;

initial fork
    clk = 1'b1;
    rst_n = 1'b0;
    #20 rst_n = 1'b1;
    din= 8'd0;
join

always #10 clk = ~clk;

always #20 din = din + 8'd5;

fir_lpf_3tap fir_lpf_3tap(
    .clk     ( clk   ), 
    .rst_n   ( rst_n ), 
    .din     ( din   ), 
    .dout    ( dout  )
    );
endmodule
