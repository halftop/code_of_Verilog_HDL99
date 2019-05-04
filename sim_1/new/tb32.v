`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/08 14:52:04
// Design Name: 
// Module Name: tb32
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


module tb32(    );
reg        i_en;
reg  [3:0] i_addr;
wire [7:0] o_data;

initial fork
i_en = 1'b0;
#20 i_en = 1'b1;
i_addr = 4'd0;
#100 i_en = 1'b0;
#160 i_en = 1'b1;
repeat(15) #20 i_addr = i_addr + 1'b1;
join

// always @(*) begin
//     if (i_en == 1'b1 && i_addr <= 4'd15) begin
//         i_addr = i_addr + 1'b1;
//     end else begin

//     end
// end

test32  rom16_8
(
	.i_en		( i_en	    ),
    .i_addr		( i_addr	),
	.o_data		( o_data	)
    );
endmodule
