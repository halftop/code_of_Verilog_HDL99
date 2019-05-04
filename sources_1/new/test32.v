`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/04 17:47:12
// Design Name: 
// Module Name: test32
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


module test32
#(
	parameter WD = 4'd8,			//数据位宽
	parameter DP = 5'd16,			//深度
  parameter ADDR_WD = clogb2(DP)	//地址位宽
)
(
	input				i_en		,
  input   [ADDR_WD-1:0]	i_addr		,
	output		[WD-1:0]	o_data		
    );
	

reg [WD-1:0] buffer [DP-1:0];

integer i;

initial begin
  for (i = 0; i < DP; i = i + 1) begin
	buffer[i] <= i + 8'hA0;
  end
end

assign o_data = i_en ? buffer[i_addr] : 'hz ;

function integer clogb2 (input integer depth);
    begin
        for(clogb2=0; depth>1; clogb2=clogb2+1)
        depth = depth >> 1;
    end
endfunction

endmodule