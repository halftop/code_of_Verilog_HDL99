`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/26 20:50:20
// Design Name: 
// Module Name: latch_ff
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


module latch_ff(
    input clk,
    input enable,
    input data,
    input clr,
    output latch_q,
    output ff_q
    );

    LDCE #(
      .INIT(1'b0) // Initial value of latch (1'b0 or 1'b1)
   ) LDCE_inst (
      .Q(latch_q),      // Data output
      .CLR(clr),  // Asynchronous clear/reset input
      .D(data),      // Data input
      .G(clk),      // Gate input
      .GE(enable)     // Gate enable input
   );

    FDCE #(
      .INIT(1'b0),            // Initial value of register, 1'b0, 1'b1
      // Programmable Inversion Attributes: Specifies the use of the built-in programmable inversion
      .IS_CLR_INVERTED(1'b0), // Optional inversion for CLR
      .IS_C_INVERTED(1'b0),   // Optional inversion for C
      .IS_D_INVERTED(1'b0)    // Optional inversion for D
   )
   FDCE_inst (
      .Q(ff_q),     // 1-bit output: Data
      .C(clk),     // 1-bit input: Clock
      .CE(enable),   // 1-bit input: Clock enable
      .CLR(clr), // 1-bit input: Asynchronous clear
      .D(data)      // 1-bit input: Data
   );
endmodule
