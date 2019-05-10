`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/09 16:00:27
// Design Name: 
// Module Name: test44
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


module test44(
    input					clk			,
    input					rst_n		,
    input       [7:0]       i_data      ,
    output      [7:0]       o_y         
);
// y(n) = 0.75x(n) + 0.25y(n-1) 
//0.75*4 = 3，0.25*4 = 1

reg [9:0] dout;
reg [9:0] dout_r;

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        dout <= 'd0;
    end else begin
        dout <= 3*i_data + dout_r;
    end
end

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        dout_r <= 'd0;
    end else begin
        dout_r <= dout;
    end
end

assign o_y = dout>>2;

endmodule
