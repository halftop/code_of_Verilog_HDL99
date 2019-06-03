`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/31 22:54:46
// Design Name: 
// Module Name: tb58
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


//verilog code for the test_bench
`timescale     1 ns/100 ps 
`define          DELAY 10  
 module     tb_fifo_32;  
 // 4. Parameter definitions  
 parameter     ENDTIME      = 40000;  
 // 5. DUT Input regs  
 reg     clk;  
 reg     rst_n;  
 reg     wr;  
 reg     rd;  
 reg     [7:0] data_in;  
 // 6. DUT Output wires  
 wire     [7:0] data_out;  
 wire     fifo_empty;  
 wire     fifo_full;  
 
 integer i; 
 integer j; 
 // 7. DUT Instantiation
synch_fifo
#(
    .FIFO_WIDTH    (8 )   ,
    .FIFO_DEPTH    (16 )  
)
DUT
(
    .clk		 ( clk		   ),
    .rst_n		 ( rst_n	   ),
    .wr_en       ( wr       ),
    .write_data  ( data_in  ),
    .fifo_full   ( fifo_full   ),
    .rd_en       ( rd       ),
    .read_data   ( data_out   ),
    .fifo_empty  ( fifo_empty  ) 
);
 // 8. Initial Conditions  
 initial  
      begin  
        $dumpfile("dump.vcd");
    $dumpvars(1,tb_fifo_32);
           clk     = 1'b0;  
           rst_n     = 1'b0;  
           wr     = 1'b0;  
           rd     = 1'b0;  
           data_in     = 8'd0;  
      end  
 // 9. Generating Test Vectors  
 initial  
      begin  
           main;  
      end  
 task main;  
      fork  
           clock_generator;  
           reset_generator;  
           operation_process;  
           debug_fifo;  
           endsimulation;  
      join  
 endtask  
 task clock_generator;  
      begin  
           forever #`DELAY clk = !clk;  
      end  
 endtask  
 task reset_generator;  
      begin  
           #(`DELAY*2)  
           rst_n = 1'b1;  
      end  
 endtask  
 task operation_process;  //此过程自校验为pass，若均为不定值，则为fail
      begin  
           for (i = 0; i < 17; i = i + 1) begin: WRE  
                #(`DELAY*5)
                @(negedge clk)
                begin
                wr = 1'b1;  
                data_in = i + 8'hA0;
                end
                #(`DELAY*2)  
                wr = 1'b0;  
           end  
           #(`DELAY)  
           for (i = 0; i < 17; i = i + 1) begin: RDE  
                #(`DELAY*2)
                @(negedge clk)
                rd = 1'b1;  
                #(`DELAY*2)  
                rd = 1'b0;  
           end
           #(`DELAY)
           operation_process1;
           #(`DELAY) $finish;
      end  
 endtask
  task operation_process1;  //此过程自教研为fail
      fork
           for (i = 0; i < 17; i = i + 1) begin: WRE  
                #(`DELAY*5)
                @(negedge clk)
                begin
                wr = 1'b1;  
                data_in = i + 8'hc0;
                end
                #(`DELAY*2)  
                wr = 1'b0;  
           end  
           #(`DELAY*40)  begin
           for (j = 0; j < 17; j = j + 1) begin: RDE  
                #(`DELAY*2)
                @(negedge clk)
                rd = 1'b1;  
                #(`DELAY*2)  
                rd = 1'b0;  
           end
           end
      join
 endtask 
 // 10. Debug fifo  
 task debug_fifo;  
      begin  
           $display("----------------------------------------------");  
           $display("------------------   -----------------------");  
           $display("----------- SIMULATION RESULT ----------------");  
           $display("--------------       -------------------");  
           $display("----------------     ---------------------");  
           $display("----------------------------------------------");  
           $monitor("TIME = %d, wr = %b, rd = %b, data_in = %h",$time, wr, rd, data_in);  
      end  
 endtask  
 // 11. Self-Checking  
 reg [5:0] waddr, raddr;  
 reg [7:0] mem[15:0]; 
 reg [7:0] mem_r;

 always @(posedge clk) begin
	if (~rst_n) begin
	mem_r = 'hx;
     end
	else if (rd & (~fifo_empty) ) begin
		 mem_r <= mem[raddr] ;
     end
	 else
	 ;
 end

 always @ (posedge clk) begin  
      if (~rst_n) begin  
           waddr     <= 6'd0;  
      end  
      else if (wr) begin  
           mem[waddr] <= data_in; 
           if(waddr<6'd17) 
           waddr <= waddr + 1; 
           else
            waddr     <= 6'd0;
      end  
      $display("TIME = %d, data_out = %d, mem_r = %d",$time, data_out,mem_r);  
      if (~rst_n) raddr     <= 6'd0;  
      else if (rd & (~fifo_empty)) 
      if(raddr<17)
      raddr <= raddr + 1;
      else
      raddr     <= 6'd0;
      if (rd & (~fifo_empty)) begin  
           if (mem_r  == data_out) begin  
                $display("=== PASS ===== PASS ==== PASS ==== PASS ===");  
                //if (raddr == 16) $finish;  
           end  
           else begin  
                $display ("=== FAIL ==== FAIL ==== FAIL ==== FAIL ===");  
                $display("-------------- THE SIMUALTION FINISHED ------------");  
                //if (raddr == 16) $finish;  
           end  
      end  
 end  
 //12. Determines the simulation limit  
 task endsimulation;  
      begin  
           #ENDTIME  
           $display("-------------- THE SIMUALTION FINISHED ------------");  
           $finish;  
      end  
  endtask  
endmodule  