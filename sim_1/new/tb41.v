`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/24 16:58:37
// Design Name: 
// Module Name: tb41
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


module tb41;
reg                clk      ;
reg                rst_n    ;
reg                load_sw  ;            
reg       [7:0]    data_in  ;
reg       [7:0]    coff_in  ;
wire      [7:0]    data_out ;

initial fork
    clk = 1'b1;
    rst_n = 1'b0;
    #20 rst_n = 1'b1;
    load_sw = 1'b0;
    #100 load_sw = 1'b1;
    data_in = 8'd0;
join

initial begin
    #20 coff_in = 8'd124;
    #20 coff_in = 8'd214;
    #20 coff_in = 8'd57;
    #20 coff_in = 8'd33;
end

initial begin #100
    forever begin
        #20 data_in = data_in + 8'd100;
    end
end

always #10 clk = ~ clk;

fir
#(
    8    ,   //输入数据位宽
    4    ,   //滤波器阶数
    8    ,   //系数位宽
    8       //输出数据位宽
)
fir
(
    .clk         ( clk      ),
    .rst_n       ( rst_n    ),
    .load_sw     ( load_sw  ),               // load/run switch
    .data_in     ( data_in  ),   //数据
    .coff_in     ( coff_in  ),   //系数
    .data_out    ( data_out )    //输出
    );
endmodule
