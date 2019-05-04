`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/27 16:03:31
// Design Name: 
// Module Name: test21
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


/* module test21(
    input   signed [3:0] a,b,c,
    output  reg [3:0] max
    );
    always @ (*) begin
        if (a >= b && a >= c)
            max = a;
        else if (b >= a && b >= c)
            max = b;
        else if (c >= b && c >= a)
            max = c;
        else
            max = max;
    end
endmodule
 */

 module DFF(
     input      clk,
     input      rst_n,
     input      i_D,
     output reg o_Q,
     output     o_Qn
 );
always @ (posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        o_Q <= 1'b1;
    end else    begin
        o_Q <= i_D;
    end
end

assign o_Qn = ~ o_Q;
 endmodule