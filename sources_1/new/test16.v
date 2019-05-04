`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/21 21:45:59
// Design Name: 
// Module Name: test
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


module test
#(
	parameter N	= 8,
	parameter M	= 8
)
(
	input	[N*M-1:0]	i_data,
	input	[log2(N)-1:0]	i_sel,
	output reg	[M-1:0]	o_data
);
wire [log2(N)*log2(N)-1:0] ojbk;
assign ojbk = i_sel << log2(N);
//assign o_data = i_data[ojbk+:M];
//wire [1:0]log_result = log2(N);
//assign o_data = i_data[7:0];

// function integer clogb2 (input integer depth);
// 	begin
// 		for(clogb2=0; depth>0; clogb2=clogb2+1)
// 		depth = depth >> 1;
// 	end
// endfunction
always @ (*)
begin
  o_data = i_data[ojbk+:M];
end

function integer log2;
  input integer value;
  begin
    value = value-1;
    for (log2=0; value>0; log2=log2+1)
      value = value>>1;
  end


endfunction
endmodule
