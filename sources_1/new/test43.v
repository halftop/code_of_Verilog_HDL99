// --------------------------------------------------------------------
// >>>>>>>>>>>>>>>>>>>>>>>>> COPYRIGHT NOTICE <<<<<<<<<<<<<<<<<<<<<<<<<
// --------------------------------------------------------------------
// Author: halftop
// Github: https://github.com/halftop
// Email: yu.zh@live.com
// Description: 
// Dependencies: 
// LastEditors: halftop
// Since: 2019-05-09 10:30:00
// LastEditTime: 2019-05-09 15:58:20
// ********************************************************************
// Module Function:
`timescale 1ns / 1ps

module test43
#(
    parameter WIDTH	= 8 ,
                DEPTH = 8   ,
                YWD = WIDTH+clogb2(DEPTH)
)
(
    input					clk			,
    input					rst_n		,
    input       [WIDTH-1:0] i_data      ,
    output  reg [YWD-1:0]   o_y 
);

reg     [WIDTH-1:0]     data_r      [DEPTH-1:0];

integer i;
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        for ( i=0 ;i<DEPTH ;i=i+1 ) begin
            data_r[i] <= 'd0;
        end
    end else begin
        data_r[0] <= i_data;
        for ( i=1 ;i<DEPTH ;i=i+1 ) begin
            data_r[i] <= data_r[i-1];
        end
    end
end

reg     [YWD-1:0] sum_comb;
always @(*) begin
    sum_comb = 'd0;
    for ( i=0 ;i<DEPTH ; i=i+1) begin
        sum_comb = sum_comb + data_r[i];
    end
end

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        o_y <= 'd0;
    end else begin
        o_y <= sum_comb;
    end
end

function integer clogb2 (input integer depth);
    begin
        for(clogb2=0; depth>1; clogb2=clogb2+1)
        depth = depth >> 1;
    end
endfunction
endmodule
