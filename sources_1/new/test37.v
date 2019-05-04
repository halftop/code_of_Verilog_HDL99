`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/10 21:56:07
// Design Name: 
// Module Name: sy_ture_dpram
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


module sy_ture_dpram
#(
    parameter WD = 8,       //数据位宽
    parameter AD = 4        //地址位宽
)
(
    input                  clk     , 
    input                  cs_n    ,

    input                  aw_r_n  ,
    input         [AD-1:0] addr_a  ,
    input         [WD-1:0] din_a   ,
    output  reg   [WD-1:0] dout_a  , 

    input                  bw_r_n  ,
    input         [AD-1:0] addr_b  ,
    input         [WD-1:0] din_b   , 
    output  reg   [WD-1:0] dout_b   
  
    );

localparam  DP = 2**AD;
reg [WD-1:0] buffer [DP-1:0];

always @(posedge clk) begin
    casex ({cs_n,aw_r_n})
        2'b1x: dout_a <= 'hx;
        2'b01: buffer[addr_a] <= din_a;
        2'b00: dout_a <= buffer[addr_a];
        default: ;
    endcase
end

always @(posedge clk) begin
    casex ({cs_n,bw_r_n})
        2'b1x: dout_b <= 'hx;
        2'b01: buffer[addr_b] <= din_b;
        2'b00: dout_b <= buffer[addr_b];
        default: ;
    endcase
end

/* always @(posedge clk) begin
    casex ({cs_n,aw_r_n,bw_r_n})
        3'b1xx: begin dout_a <= 'hx; dout_b <= 'hx; end
        3'b000: begin dout_a <= buffer[addr_a]; dout_b <= buffer[addr_b]; end   //A读B读
        3'b001: begin dout_a <= buffer[addr_a]; buffer[addr_b] <= din_b; end    //A读B写
        3'b010: begin buffer[addr_a] <= din_a; dout_b <= buffer[addr_b]; end    //A写B读
        3'b011: begin                                                           //A写B写
            if (addr_a == addr_b) begin
                buffer[addr_a] <= din_a;
            end else begin
                buffer[addr_a] <= din_a;
                buffer[addr_b] <= din_b;
            end 
        end
        default: ;
    endcase
end */

endmodule
