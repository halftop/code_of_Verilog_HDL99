`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/05 15:35:41
// Design Name: 
// Module Name: test42
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
    input               clk     , 
    input               rst_n   , 
    input       [7:0]   yin     , 
    output      [7:0]   yout    ,
    input       [7:0]   cin     ,
    output      [7:0]   cout    
    );

reg [7:0] tap [0:2];
reg [8:0] product [0:1];
reg [7:0] yout_r    ;

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        tap[0] <= 8'd0;
        tap[1] <= 8'd0;
        tap[2] <= 8'd0;
    end else begin
        tap[2] <= tap[1];
        tap[1] <= tap[0];
        tap[0] <= yin;
    end
end

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        product[0] <= 9'd0;
        product[1] <= 9'd0;
    end else begin
        product[0] = (tap[0] + tap[2]) >> 2;
        product[1] = tap[1] >> 1;        
    end
end

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        yout_r <= 8'd0;
    end else begin
        yout_r <= product[0] + product[1];
    end
end

assign yout = yout_r;
assign cout = cin;

endmodule

