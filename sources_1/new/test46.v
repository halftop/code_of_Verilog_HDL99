`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/10 11:04:54
// Design Name: 
// Module Name: test46
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


module div_odd
#(
    parameter N	= 5
    
)
(
    input					clk			,
    input					rst_n		,
    output                  clk_out     
);

localparam  WD = clogb2(N);

reg                 clk_out_p   ;
reg                 clk_out_n   ;
reg     [WD-1:0]    count       ;

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        count <= 'd0;
    end else if (count==N-1) begin
        count <= 'd0;
    end else begin
        count <= count + 1'b1;
    end
end

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        clk_out_p <= 1'b1;
    end else if (count>N/2) begin
        clk_out_p <= 1'b0;
    end else begin
        clk_out_p <= 1'b1;
    end
end

always @(negedge clk or negedge rst_n) begin
    if (!rst_n) begin
        clk_out_n <= 1'b0;
    end else begin
        clk_out_n <= clk_out_p;
    end
end

assign clk_out = clk_out_p&clk_out_n;

function integer clogb2 (input integer depth);
    begin
        for(clogb2=0; depth>0; clogb2=clogb2+1)
        depth = depth >> 1;
    end
endfunction

endmodule
