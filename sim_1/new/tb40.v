`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/18 17:25:08
// Design Name: 
// Module Name: tb40
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


module tb40(    );

reg         clk     ;
reg         rst_n   ;
reg [1:0]   mode    ;
reg [7:0]   din     ;
wire [7:0]  dout    ;

initial fork
    clk = 1'b1;
    rst_n = 1'b0;
    #20 rst_n = 1'b1;
    mode = 2'd3;
    din= 8'd0;
join

always #10 clk = ~clk;

always #20 din = din + 8'd5;

initial begin
    #20 repeat (4) #300 mode = mode - 1'b1;
end

test40 fir_lpf(
    .clk     ( clk   ), 
    .rst_n   ( rst_n ), 
    .mode    ( mode  ), 
    .din     ( din   ), 
    .dout    ( dout  )
    );
endmodule
