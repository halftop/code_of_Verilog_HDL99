`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/10 09:0AD-1:06
// Design Name: 
// Module Name: s_dpram
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


module sy_dpram
#(
    parameter WD = 8,       //位宽
    parameter DP = 16,      //深度
    parameter AD = clogb2(DP)
)
(
    input                   clk     , 
    input                   cs_n    ,
    input                   wr_n    ,
    input                   rd_n    ,
    input       [WD-1:0]    din_b   ,       //B口写入
    input       [AD-1:0]    addr_b  ,
    input       [AD-1:0]    addr_a  ,       //A口读出
    output  reg [WD-1:0]    dout_a  
    );
reg [WD-1:0] buffer [DP-1:0];

/* always @(posedge clk) begin
    if (!cs_n && !rd_n) begin
        dout_a <= buffer[addr_a];
    end
end

always @(posedge clk) begin
    if (!cs_n && !wr_n) begin
        buffer[addr_b] <= din_b;
    end
end */

always @(posedge clk) begin
    casex ({cs_n,wr_n,rd_n})
        3'b1xx: dout_a <= 'hx;
        3'b000: begin   dout_a <= buffer[addr_a]; buffer[addr_b] <= din_b;  end
        3'b001: buffer[addr_b] <= din_b;
        3'b010: dout_a <= buffer[addr_a];
        default: ;
    endcase
end

function integer clogb2 (input integer depth);
    begin
        for(clogb2=0; depth>1; clogb2=clogb2+1)
        depth = depth >> 1;
    end
endfunction
endmodule
