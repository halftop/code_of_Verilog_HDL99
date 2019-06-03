//***********************************************************//
// File Name: sync_fifo_tb.v
// Module Name: sync_fifo_tb
// Description: This is testbench for verifying sync_fifo. It  implements source logic for pumping in data to
// FIFO, destination logic to read data from FIFO. It// implements source and destination data buffers to
// compare the data pumped into FIFO with data// pumped out of FIFO
// Author: Asim Anand
// Place: Cadence Design Systems, Inc.
// Date: July 10, 2008
//***********************************************************//
module sync_fifo_tb; 
reg clk;
reg reset_n;
reg [15:0] lfsr_count;
reg[15:0] data_in;
reg data_valid;
wire ready;
wire flush = 1'b0;
wire read_req;
wire count_enable;
wire write_ack;
wire fifo_full;
wire fifo_afull; 

//generating clk signal;
initial
	begin
		clk=1'b0;
		forever 
			begin
			#100 clk=~clk;
			end
	end

//generating reset signal
initial
begin
	reset_n=1'b0;
	#550;reset_n=1'b1;
end 

// LFSR Counter 
always @(posedge clk or negedge reset_n)
begin
	if(~reset_n)
		lfsr_count <= 16'h70f0;
	else
		lfsr_count <= {lfsr_count[14:0],~(lfsr_count[15] ^ lfsr_count[14] ^lfsr_count[12] ^ lfsr_count[3])};
end 

// generating ready, count_enable and read request signal
assign ready = lfsr_count[0] | lfsr_count[3];
assign read_req = lfsr_count[7] | lfsr_count[13];
assign count_enable = (ready) && (~fifo_full);

//generating 16 bit input data
always @(posedge clk or negedge reset_n)
begin
	if(~reset_n)
		data_in<={{15{1'b0}},1'b1};
	else if(count_enable)
		data_in[15:0]<={data_in[14:0],data_in[15]^data_in[14]};
	else
	data_in<=data_in;
end 
//destination logic.... clk,reset_n,flush are same as in source logic
wire [15:0] data_out;
wire rdata_valid;
wire fifo_empty;
wire fifo_aempty;

//instantiating DUT
sync_fifo #(.ADDR_WIDTH(4),.DATA_WIDTH(16),.DEPTH(16),.AEMPTY(3),.AFULL(3))DUT (.clk(clk),.reset_n(reset_n),.flush(flush),
.read_req(read_req),.write_data(data_in),.wdata_valid(data_valid),.read_data(data_out),.fifo_empty(fifo_empty),
.fifo_aempty(fifo_aempty),.fifo_full(fifo_full),.fifo_afull(fifo_afull),.write_ack(write_ack),
.rdata_valid(rdata_valid)); 

//source array
reg [15:0] source_array[0:2047];
reg [10:0] counter;

always @(posedge clk or negedge reset_n)
begin
	if(~reset_n)
		counter <= {11{1'b0}};
	else if(data_valid && (~fifo_full))
		begin
			source_array[counter] <= data_in;
			counter <= counter + {{10{1'b0}},1'b1};
		end
end

//destination array
reg [15:0] destination_array[0:2047];
reg [10:0] counter1; 
always @(posedge clk or negedge reset_n)
begin
	if(~reset_n)counter1 <= {11{1'b0}};
	else if(rdata_valid)
		begin
			destination_array[counter1] <= data_out;
			counter1 <= counter1 + {{10{1'b0}},1'b1};
		end
end

integer i;
//reg [2047:0] match;
reg match;
always @(counter1) 
begin
	match = 1'b1;
	for (i=0; i < counter1; i=i+1)
	//comparing source and destination array
	match = match && (source_array[i] == destination_array[i]);
end 
// FSM to generate data valid signal
reg cs;
reg ns;
localparam idle = 1'b0;
localparam active = 1'b1; 
always @*
begin
	ns = cs;
	data_valid = 1'b0; 
	
	case(cs)
	idle: 
		begin
			if(ready)
				begin
					ns = active;
					data_valid = 1'b1 ;
				end
		end 
	
	active: 
		begin
			if((~fifo_full) && (~ready))
			begin
				ns = idle;
				data_valid = 1'b0;
			end
			else
				data_valid = 1'b1;
		end 
	
	default: 
		cs = idle;
	endcase
end 

always @(posedge clk or negedge reset_n) 
begin
	if (~reset_n)
		cs <= idle;
	else
		cs <= ns;
end 

endmodule