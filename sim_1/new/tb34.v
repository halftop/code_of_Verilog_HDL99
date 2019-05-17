// --------------------------------------------------------------------
// >>>>>>>>>>>>>>>>>>>>>>>>> COPYRIGHT NOTICE <<<<<<<<<<<<<<<<<<<<<<<<<
// --------------------------------------------------------------------
// Author: halftop
// Github: https://github.com/halftop
// Email: yu.zh@live.com
// Description: 
// Dependencies: 
// Since: 2019-04-09 10:37:15
// LastEditors: halftop
// LastEditTime: 2019-04-09 10:37:15
// ********************************************************************
// Module Function:
`timescale 1ns / 1ps

// memory inst hierachy name
`define MEM_INST      tb34.spram16_8.buffer
// memory initilazation file (hex format)
`define MEM_INIT_FILE "E:/verilog/test/test.srcs/sources_1/new/sp_mem_init.hex"

module tb34(    );
reg             clk     ;
reg             cs_n    ;
reg             w_r_n   ;
reg     [4:1]   addr    ;
reg     [8:1]   din     ;
wire    [8:1]   dout    ;

initial begin
    clk = 1;
    forever #10 clk = ~clk;
  end

// memory initilization
integer fp_dmem;

initial begin
    fp_dmem = $fopen(`MEM_INIT_FILE, "r");  //open for read
    if(fp_dmem)
        #5 $readmemh(`MEM_INIT_FILE, `MEM_INST);
    else begin
        $display("%s open failed.",`MEM_INIT_FILE);
        $finish;
    end
end

integer i;
initial begin
    cs_n = 1'b1;
    w_r_n = 1'b0;
    addr = 4'd0;
    din = 8'h00;
    #100
    @(negedge clk)//read
        cs_n = 1'b0;
    for (i = 0; i<16; i=i+1) begin
        @(negedge clk)
            addr = i;
    end
    @(negedge clk)//write
        w_r_n = 1'b1;
    for (i = 0; i<16; i=i+1) begin
        @(negedge clk) begin
            addr = i;
            din = i + 'ha0;
        end
    end
    @(negedge clk)//read
        w_r_n = 1'b0;
    for (i = 0; i<16; i=i+1) begin
        @(negedge clk)
            addr = i;
    end
    @(negedge clk)
        cs_n = 1'b1;
    // #100 $finish;
    #100 $stop;
end

/* initial begin
    $dumpfile("spram_tb.vcd");
    $dumpvars();
end */
spram #(
    .WD ( 8),
    .AD ( 4)
)
spram16_8
(
    .clk     ( clk   ),
    .cs_n    ( cs_n  ),
    .w_r_n   ( w_r_n ),
    .addr    ( addr  ),
    .din     ( din   ),
    .dout    ( dout  )
    );
endmodule