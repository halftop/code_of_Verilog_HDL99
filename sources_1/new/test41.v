`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Xidian University
// Engineer: halftop（ZhangYu）
// 
// Create Date: 2019/04/20 15:51:21
// Design Name: 
// Module Name: fir
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 基于SOP（乘积和）的转置结构的FIR滤波器。load_sw为低时为缓存系数过程，load_sw为高时为计算和输出过程。
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module fir
#(
    parameter   DIN_WIDTH    = 8    ,   //输入数据位宽
                FIR_TAP      = 4    ,   //滤波器阶数
                COEF_WIDTH   = 8    ,   //系数位宽
                DOUT_WIDTH   = 8       //输出数据位宽
)
(
    input           clk         ,
    input           rst_n       ,
    input           load_sw     ,               // load/run switch
    input       [ DIN_WIDTH-1:0]    data_in ,   //数据
    input       [COEF_WIDTH-1:0]    coff_in ,   //系数
    output      [DOUT_WIDTH-1:0]    data_out    //输出
    );

localparam  PROD_WIDTH   = DIN_WIDTH + COEF_WIDTH, //乘积位宽
            ADD_WIDTH    = PROD_WIDTH + clogb2(FIR_TAP) ;//乘积和位宽

reg [DIN_WIDTH-1:0] data_in_r;
wire [ADD_WIDTH-1:0] data_out_w;

reg [COEF_WIDTH-1:0] coff [FIR_TAP-1:0];    //系数
wire [PROD_WIDTH-1:0] prod [FIR_TAP-1:0];   //乘积
reg [ADD_WIDTH-1:0] sum [FIR_TAP-1:0];      //乘积和
//----> Load Data or Coefficient
always @(posedge clk or negedge rst_n) begin: LOAD
    integer i;
    if (!rst_n) begin
        for (i = 0; i <= FIR_TAP-1; i = i +1) begin
            coff[i] <= 'd0;
        end
        data_in_r <= 'd0;
    end else if(!load_sw) begin     //缓存系数
        coff[FIR_TAP-1] <= coff_in;
        for (i = FIR_TAP-1; i > 0; i = i -1) begin
            coff[i-1] <= coff[i];
        end
    end else begin
        data_in_r <= data_in;       //缓存数据
    end
end
//----> Compute productss
genvar k;
generate
    for (k = 0; k < FIR_TAP; k = k + 1) begin
        assign prod[k] = data_in_r * coff[k];
    end
endgenerate
//----> Compute sum-of-products
always @(posedge clk or negedge rst_n) begin: SOP
    integer m;
    if (!rst_n) begin
        for (m = 0; m < FIR_TAP; m = m + 1) begin
            sum[m] <= 'd0;
        end
    end else begin
        sum[FIR_TAP-1] <= prod[FIR_TAP-1];
        for (m = FIR_TAP-1; m > 0; m = m - 1) begin
            sum[m-1] <= prod[m-1] + sum[m];
        end
        /* for (m = 0; m < FIR_TAP - 1; m = m + 1) begin
            sum[m] <= prod[m] + sum[m+1];
        end
        sum[FIR_TAP-1] <= prod[FIR_TAP-1]; */
    end
end
assign data_out_w = sum[0];

assign data_out = data_out_w[ADD_WIDTH-1:ADD_WIDTH-DOUT_WIDTH];

function integer clogb2 (input integer depth);
    begin
        for(clogb2=0; depth>1; clogb2=clogb2+1)
        depth = depth >> 1;
    end
endfunction
endmodule
