`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/10 17:22:33
// Design Name: 
// Module Name: as_dpram
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


module as_dpram
#(
    parameter WD = 8,       //位宽
    parameter DP = 16,      //深度
    parameter AD = clogb2(DP)
)
(
    input                  clk_a   , 
    input                  rda_n   ,
    input         [AD-1:0] addr_a  , 
    output  reg   [WD-1:0] dout_a  , 

    input                  clk_b   , 
    input                  wrb_n   ,
    input         [WD-1:0] din_b   , 
    input         [AD-1:0] addr_b  , 

    input                  cs_n     
    );
reg [WD-1:0] buffer [DP-1:0];

/* always @(posedge clk_a) begin
    if (!cs_n && !rda_n) begin
        dout_a <= buffer[addr_a];
    end 
end */

always @(posedge clk_a) begin
    casex ({cs_n,rda_n})
        2'b1x: dout_a <= 'hx;
        2'b00: dout_a <= buffer[addr_a];
        default: ;
    endcase
end

always @(posedge clk_b) begin
    if (!cs_n && !wrb_n) begin
        buffer[addr_b] <= din_b;
    end
end

function integer clogb2 (input integer depth);
    begin
        for(clogb2=0; depth>1; clogb2=clogb2+1)
        depth = depth >> 1;
    end
endfunction

endmodule
