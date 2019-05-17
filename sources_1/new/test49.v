`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/13 21:15:45
// Design Name: 
// Module Name: test49
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


module clk_switch(
    input                   clk0        ,
    input                   clk1        ,
    input                   rst_n       ,
    input                   select      ,
    output                  outclk      
    );

    // assign outclk = select ? clk1 : clk0;
    //assign outclk = (clk1 & select) | (~select & clk0);

reg out0;
reg out1;

always @(negedge clk1 or negedge rst_n) begin
    if (!rst_n) begin
        out1 <= 1'b0;
    end else begin
        out1 <= ~out0 & select;
    end
end

always @(negedge clk0 or negedge rst_n) begin
    if (!rst_n) begin
        out0 <= 1'b0;
    end else begin
        out0 <= ~out1 & ~select;
    end
end

assign outclk = (out1 & clk1) | (out0 & clk0);

/* reg     out_r1;
reg     out1;
reg     out_r0;
reg     out0;
 
 always @(posedge clk1 or negedge rst_n)begin
     if(rst_n == 1'b0)begin
         out_r1 <= 0;
     end
     else begin
         out_r1 <= ~out0 & select;
     end
 end
 
 always @(negedge clk1 or negedge rst_n)begin
     if(rst_n == 1'b0)begin
         out1 <= 0;
     end
     else begin
         out1 <= out_r1;
     end
 end
 
 always @(posedge clk0 or negedge rst_n)begin
     if(rst_n == 1'b0)begin
         out_r0 <= 0;
     end
     else begin
         out_r0 <= ~select & ~out1;
     end
 end
 
 always @(negedge clk0 or negedge rst_n)begin
     if(rst_n == 1'b0)begin
         out0 <= 0;
     end
     else begin
         out0 <= out_r0;
     end
 end
 
 assign outclk = (out1 & clk1) | (out0 & clk0); */
endmodule
