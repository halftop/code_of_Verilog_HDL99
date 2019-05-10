`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/05 15:27:36
// Design Name: 
// Module Name: test39
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


module fir_lpf_3tap(
    input               clk         , 
    input               rst_n       , 
    input               fir_bypass  ,
    input       [7:0]   din         , 
    output  reg [7:0]   dout        
    );

reg [7:0] tap [0:2];
integer i;
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        for (i = 0; i<=2; i=i+1) begin
            tap[i] <= 0;
        end
        dout <= 8'd0;
    end else if (!fir_bypass)begin
        // dout <= (tap[0] >> 2) + (tap[1]  >> 1) + (tap[2] >> 2);
        dout <= tap[0][7:2] + tap[1][7:1] + tap[2][7:2];
        /* for (i = 2; i > 0; i=i-1) begin
            tap[i] <= tap[i-1];
        end */
        tap[2] <= tap[1];
        tap[1] <= tap[0];
        tap[0] <= din;
    end else begin
        dout <= din;
    end
end
endmodule
