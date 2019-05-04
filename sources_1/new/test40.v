`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/18 16:07:48
// Design Name: 
// Module Name: test40
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


module test40(
    input               clk     , 
    input               rst_n   , 
    input       [1:0]   mode    , 
    input       [7:0]   din     , 
    output      [7:0]   dout    
    );

reg [7:0] tap [6:0];
reg [8:0] product [3:0];
reg [7:0] dout_r;

integer i;
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        for (i = 0; i <= 6; i = i + 1) begin
            tap[i] <= 8'd0;
        end
    end else begin
        for (i = 6; i > 0; i = i - 1) begin
            tap[i] <= tap[i-1];
        end
        tap[0] <= din;
    end
end

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        for (i = 0; i <= 3; i = i + 1) begin
            product[i] <= 8'd0;
        end
    end else begin
        case (mode)
            2'd1: begin
                product[0] = (tap[0] + tap[2]) >> 2;
                // product[0] = (tap[0] >> 2) + (tap[2]>> 2) ;
                product[1] = tap[1] >> 1;
            end
            2'd2: begin
                product[0] = (tap[0] + tap[4]) >> 3;
                product[1] = (tap[1] + tap[2] + tap[3]) >> 2;
            end
            2'd3: begin
                product[0] = (tap[0] + tap[6]) >> 4;
                product[1] = (tap[1] + tap[5]) >> 3;
                product[2] = ((tap[2] + tap[4]) * 3) >> 4;
                product[3] = tap[3] >> 2;
            end
            default: ;
        endcase
    end
end

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        dout_r <= 8'd0;
    end else begin
        case (mode)
            2'd1: dout_r <= product[0] + product[1];
            2'd2: dout_r <= product[0] + product[1];
            2'd3: dout_r <= (product[0] + product[1]) + (product[2] + product[3]);
            default: dout_r <= din;
        endcase
    end
end

assign dout = dout_r;
endmodule
