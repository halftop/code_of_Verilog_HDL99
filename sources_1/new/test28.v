`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/02 09:33:56
// Design Name: 
// Module Name: test28
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


/* module test28(
    input clk, rst_n, data_i,
    output [7:0] data_o
    );
    reg [7:0] data_r;
    reg [2:0] cnt;
//lsb
always @(posedge clk or negedge rst_n) begin
  if (!rst_n) begin
    data_r <= 8'd0;
    cnt <= 3'b0;
  end else begin
    data_r <= {data_r[6:0],data_i};
    cnt <= cnt + 1'b1;
  end
end
//msb
always @(posedge clk or negedge rst_n) begin
  if (!rst_n) begin
    data_r <= 8'd0;
    cnt <= 3'b0;
  end else begin
    data_r <= {data_i,data_r[7:1]};
    cnt <= cnt + 1'b1;
  end
end

assign data_o = (cnt == 3'd7) ? data_r : data_o;
endmodule */
module s_p_conver
#(
	parameter	WIDTH	=	4
)
(
	input						clk			,
	input						rst_n		,
	input		[WIDTH-1:0]		data_in		,
	output	reg	[WIDTH-1:0]		data_out	,
	input		[1:0]			mode		
);

localparam CNT_WIDTH = clogb2(WIDTH);

reg	[WIDTH-1:0]	data_out_r;

reg	[CNT_WIDTH-1:0]	cnt;
reg   [1:0] mode_r;
wire change;

always @(posedge clk or negedge rst_n)begin
    if(!rst_n)
      mode_r <= 2'b00;
    else 
      mode_r <= mode;
end
assign change = (mode_r ^ mode)? 1'b1: 1'b0;

always @(posedge clk or negedge rst_n)begin
    if(!rst_n)
      cnt <= 'd0;
    else if(change == 1'b1)
      cnt <= 'd0;
    else if(mode[1] == 1'b0) begin
		case (mode[0])
          1'b0: if(cnt == WIDTH) cnt <= 'd1;else cnt <= cnt + 1'b1;
          1'b1: if(cnt == WIDTH-1) cnt <= 'd0;else cnt <= cnt + 1'b1;
			default: cnt <= cnt;
		endcase
	end
	else
		cnt <= cnt;
end
//serial_parallel_convertion
always @(posedge clk or negedge rst_n) begin
	if (!rst_n) begin
		data_out_r <= 'd0;
	end else begin:s_p
		integer i;
		case (mode)
			2'b00: begin
				for (i = WIDTH-1; i>0; i=i-1) begin
					data_out_r[i] <= data_out_r[i-1];
				end
				data_out_r[0] <= data_in[0];
			end
			2'b01: begin
              if(cnt == 'd0)
              data_out_r <= data_in;
              else
                data_out_r <= {1'b0,data_out_r[WIDTH-1:1]};
			end
			2'b10: begin
				/* for (i = 0; i<=WIDTH-1; i=i+1) begin
					data_out_r[i] <= data_in[i];
				end */
				data_out_r <= data_in;
			end
			2'b11: begin
				for (i = 0; i<=WIDTH-1; i=i+1) begin
					data_out_r[WIDTH-1-i] <= data_in[i];
				end
			end
			default: data_out_r <= data_out_r;
		endcase
	end
end
//output
always @(*) begin
	case (mode)
		2'b00: data_out = (cnt == 'd1) ? data_out_r : data_out;
		2'b01: data_out = data_out_r;
		default: data_out = data_out_r;
	endcase
end

function integer clogb2 (input integer depth);
	begin
      for(clogb2=0; depth>0; clogb2=clogb2+1)
		depth = depth >> 1;
	end
endfunction

endmodule