/* `timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/31 11:13:05
// Design Name: 
// Module Name: tb26
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


module tb26(    );
reg     clk, rst_n, data;
wire    rise_edge;
wire    fall_edge;
wire    data_edge;

initial fork
  clk = 1'b0;
  rst_n = 1'b0;
  #50 rst_n = 1'b1;
  data = 1'b0;
join

initial begin
  #60 data = 1'b1;
  #40 data = 1'b0;
  #40 data = 1'b1;
  #40 data = 1'b0;
end

always #10 clk = ~clk;

test26  edge_dec(
    .clk        ( clk       ), 
    .rst_n      ( rst_n     ),
    .data       ( data      ),
    .rise_edge  ( rise_edge ),
    .fall_edge  ( fall_edge ),
    .data_edge  ( data_edge )
    );

endmodule
 */

module tb_edge_det;
reg     clk, rst_n, data;
wire    rise_edge;
wire    fall_edge;
wire    data_edge;

initial begin
    clk = 0;
    forever #10 clk = ~clk;
  end

initial begin
    rst_n = 1'b0;
    #22 rst_n = 1'b1;
  end

initial begin
    repeat(100)begin
      @(posedge clk)
	      data = {$random};
    end
    $finish;
end
  
initial begin
    $dumpfile("seq101_tb.vcd");
    $dumpvars();
end

edge_det  edge_det(
    .clk        ( clk       ), 
    .rst_n      ( rst_n     ),
    .data       ( data      ),
    .rise_edge  ( rise_edge ),
    .fall_edge  ( fall_edge ),
    .data_edge  ( data_edge )
    );
endmodule