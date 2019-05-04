`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/11 09:38:18
// Design Name: 
// Module Name: tb37
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


module tb37(    );
reg              clk     ;
reg              cs_n    ;
reg              aw_r_n  ;
reg     [3:0] addr_a  ;
reg     [7:0] din_a   ;
wire    [7:0] dout_a  ;
reg              bw_r_n  ;
reg     [3:0] addr_b  ;
reg     [7:0] din_b   ;
wire    [7:0] dout_b  ;

initial fork
    clk = 1'b1;
    cs_n = 1'b1;
    aw_r_n = 1'b0;
    bw_r_n = 1'b0;
    addr_a = 4'd0;
    // addr_b = 4'd15;
    addr_b = 4'd0;
    din_a = 8'd0;
    din_b = 8'd0;
join

always #10 clk = ~clk;

initial begin
    #100 {cs_n,aw_r_n,bw_r_n} = 3'b011;     //A写B写
    #180 {cs_n,aw_r_n,bw_r_n} = 3'b000;     //A读B读
    #180 {cs_n,aw_r_n,bw_r_n} = 3'b010;     //A写B读
    #300 {cs_n,aw_r_n,bw_r_n} = 3'b001;     //A读B写
    #160 {cs_n,aw_r_n,bw_r_n} = 3'b100;
end

initial fork
    //A写B写
    #100 repeat (9) #20 addr_a = addr_a + 1'b1;
    #100 repeat (8) #20 addr_b = addr_b + 1'b1;
    //A读B读
    #280 repeat (9) #20 addr_a = addr_a - 1'b1;
    #300 repeat (8) #20 addr_b = addr_b + 1'b1;
    //A写B读
    #460 repeat (15) #20 addr_a = addr_a + 2'd1;
    // #480 repeat (7) #20 addr_b = addr_b - 1'b1;
    //A读B写
    #760 repeat (8) #20 addr_a = addr_a - 1'b1;
    #760 repeat (8) #20 addr_b = addr_b - 1'b1;
join

initial fork
    //A写B写
    #80 repeat (9) #20 din_a = addr_a + 8'ha0;
    #100 repeat (8) #20 din_b = addr_b + 8'hd0;
    //A读B读
    // #280 repeat (9) #20 din_a = din_a - 1'b1;
    // #300 repeat (8) #20 din_b = din_b + 1'b1;
    //A写B读
    #440 repeat (8) #20 din_a = addr_a + 8'hb0;
    // #480 repeat (7) #20 addr_b = addr_b - 1'b1;
    //A读B写
    // #620 repeat (8) #20 din_a = din_a - 1'b1;
    #740 repeat (8) #20 din_b = addr_b + 8'hc0;
join

sy_ture_dpram #(
    .WD(8 ),       
    .AD(4 )      
)
sy_ture_dpram
(
    .clk     ( clk    ), 
    .cs_n    ( cs_n   ),

    .aw_r_n  ( aw_r_n ),
    .addr_a  ( addr_a ),
    .din_a   ( din_a  ),
    .dout_a  ( dout_a ), 

    .bw_r_n  ( bw_r_n ),
    .addr_b  ( addr_b ),
    .din_b   ( din_b  ), 
    .dout_b  ( dout_b ) 
  
    );
endmodule


