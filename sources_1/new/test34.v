`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/09 09:40:23
// Design Name: 
// Module Name: sram
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


module spram
#(
    parameter WD = 8,       //位宽
    parameter DP = 16,       //深度
    parameter AD = clogb2(DP)
)
(
    input               clk     ,
    input               cs_n    ,
    input               w_r_n   ,
    input       [AD-1:0]  addr    ,
    input       [WD-1:0]  din     ,
    output  reg [WD-1:0]  dout    
    );
reg [WD-1:0]  buffer  [DP-1:0];

always @(posedge clk) begin
    casex ({cs_n,w_r_n})
        2'b1x: dout <= 'hx;
        2'b01: buffer[addr] <= din;
        2'b00: dout <= buffer[addr];
        default: ;
    endcase
end

function integer clogb2 (input integer depth);
    begin
        for(clogb2=0; depth>1; clogb2=clogb2+1)
        depth = depth >> 1;
    end
endfunction
endmodule
/* module single_port_ram
(
	input [7:0] data,
	input [5:0] addr,
	input we, clk,
	output [7:0] q
);

	// Declare the RAM variable
	reg [7:0] ram[63:0];
	
	// Variable to hold the registered read address
	reg [5:0] addr_reg;
	
	always @ (posedge clk)
	begin
	// Write
		if (we)
			ram[addr] <= data;
		
		addr_reg <= addr;
		
	end
		
	// Continuous assignment implies read returns NEW data.
	// This is the natural behavior of the TriMatrix memory
	// blocks in Single Port mode.  
	assign q = ram[addr_reg];
	
endmodule */
