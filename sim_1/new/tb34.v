`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/09 10:37:18
// Design Name: 
// Module Name: tb34
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


module tb34(    );
reg             clk     ;
reg             cs_n    ;
reg             w_r_n   ;
reg     [4:1]   addr    ;
reg     [8:1]   din     ;
wire    [8:1]   dout    ;

initial fork
clk = 1'b1;

cs_n = 1'b1;
#20 cs_n = 1'b0;
#660 cs_n = 1'b1;

w_r_n = 1'b0;
#20 w_r_n = 1'b1;
#340 w_r_n = 1'b0;

addr = 4'd0;
din = 8'h00;
join

always #10 clk = ~clk;

initial #20 begin
    repeat(15) #20 begin din = addr + 8'ha0; addr = addr + 1'b1; end
    #20 repeat(15) #20 addr = addr - 1'b1;
end

spram #(
    .WD ( 8),
    .DP (16)
)
spram16_8
(
    .clk     ( clk   ),
    .cs_n    ( cs_n  ),
    .w_r_n   ( w_r_n ),
    .addr    ( addr  ),
    .din     ( din   ),
    .dout    ( dout  )
    );
endmodule
