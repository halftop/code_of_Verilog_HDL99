`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/22 21:34:51
// Design Name: 
// Module Name: BDC_decoder
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

module BCD_Decoder(
	input		[3:0]	A,
	//output	reg	[9:0]	Y_L
	output		[9:0]	Y_L
);

/* always @ (*)
	case(A)
		4'd0:Y_L=10'b11_1111_1110;
		4'd1:Y_L=10'b11_1111_1101;
		4'd2:Y_L=10'b11_1111_1011;
		4'd3:Y_L=10'b11_1111_0111;
		4'd4:Y_L=10'b11_1110_1111;
		4'd5:Y_L=10'b11_1101_1111;
		4'd6:Y_L=10'b11_1011_1111;
		4'd7:Y_L=10'b11_0111_1111;
		4'd8:Y_L=10'b10_1111_1111;
		4'd9:Y_L=10'b01_1111_1111;
		default:Y_L=10'b11_1111_1111;
	endcase */

assign Y_L[0] = ~(~A[3] & ~A[2] & ~A[1] & ~A[0]);
assign Y_L[1] = ~(~A[3] & ~A[2] & ~A[1] & A[0]);
assign Y_L[2] = ~(~A[3] & ~A[2] & A[1]  & ~A[0]);
assign Y_L[3] = ~(~A[3] & ~A[2] & A[1]  & A[0]);
assign Y_L[4] = ~(~A[3] & A[2]  & ~A[1] & ~A[0]);
assign Y_L[5] = ~(~A[3] & A[2]  & ~A[1] & A[0]);
assign Y_L[6] = ~(~A[3] & A[2]  & A[1]  & ~A[0]);
assign Y_L[7] = ~(~A[3] & A[2]  & A[1]  & A[0]);
assign Y_L[8] = ~(A[3]  & ~A[2] & ~A[1] & ~A[0]);
assign Y_L[9] = ~(A[3]  & ~A[2] & ~A[1] & A[0]);

endmodule
