`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/21 21:51:49
// Design Name: 
// Module Name: tb
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


module tb();
reg		[63:0]	i_data = 64'hABCD_EFAB_CDEF_ABCD	;
reg		[ 3:0]	i_sel = 4'b0000	;
wire	[ 7:0]	o_data = 8'd0	;

initial begin
//i_data = 64'hABCD_EFAB_CDEF_ABCD;
//i_sel = 4'b0000;
#20
i_sel = 4'b0001;
#20
i_sel = 4'b0010;
#20
i_sel = 4'b0011;
#20
i_sel = 4'b0100;
#20
i_sel = 4'b0101;
#20
i_sel = 4'b0110;
#20
i_sel = 4'b0111;
end


test 
#(
	.N(4'd8),
	.M(4'd8)
)
mux64to1
(
	.i_data	( i_data	),
	.i_sel	( i_sel		),
	.o_data ( o_data	)
);

endmodule
