// --------------------------------------------------------------------
// >>>>>>>>>>>>>>>>>>>>>>>>> COPYRIGHT NOTICE <<<<<<<<<<<<<<<<<<<<<<<<<
// --------------------------------------------------------------------
// Author: halftop
// Github: https://github.com/halftop
// Email: yu.zh@live.com
// Description: LED通过PWM调亮度,实现呼吸灯，https://halftop.github.io/post/verilog-day10/
// Dependencies: 
// LastEditors: halftop
// Since: 2019-05-08 11:24:52
// LastEditTime: 2019-05-08 16:08:10
// ********************************************************************
// Module Function:呼吸灯
`define SIMULATION;
module pwm_genrate
#(
    parameter CLK_FREQUENCE	= 24,	//MHz
            PWM_PRECISION	= 1,	//us
            PWM_PERIOD		= 1,	//ms
            BREATH_CYCLE	= 2		//s
)
(
    input					clk     ,
    input					rst_n	,
    output	reg				pwm_sig	
);

`ifdef	SIMULATION
localparam	PRECISION_CNT	= CLK_FREQUENCE*PWM_PRECISION,
            PERIOD_CNT		= PWM_PERIOD*10/PWM_PRECISION,
            CYCLE_CNT		= BREATH_CYCLE*5/PWM_PRECISION/PWM_PERIOD,
            PRECISION_WD	= clogb2(PRECISION_CNT),
            PERIOD_WD		= clogb2(PERIOD_CNT),
            CYCLE_WD		= clogb2(CYCLE_CNT);
`else
localparam	PRECISION_CNT	= CLK_FREQUENCE*PWM_PRECISION,
            PERIOD_CNT		= PWM_PERIOD*1000/PWM_PRECISION,
            CYCLE_CNT		= BREATH_CYCLE*500/PWM_PRECISION/PWM_PERIOD,
            PRECISION_WD	= clogb2(PRECISION_CNT),
            PERIOD_WD		= clogb2(PERIOD_CNT),
            CYCLE_WD		= clogb2(CYCLE_CNT);
`endif

reg     [PRECISION_WD-1:0]  cnt_pre;//精度计数
reg     [PERIOD_WD-1:0]     cnt_per;//pwm周期计数
reg     [CYCLE_WD-1:0]      cnt_cyc;//呼吸周期计数
wire                        time_pre;//精度标志
wire                        time_per;//pwm周期标志
wire                        time_cyc;//半个呼吸周期计数
reg                         turn_flag;//默认低亮高灭；1为逐渐变暗，0为逐渐变亮

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        cnt_pre <= 'd0;
    end else if (cnt_pre<PRECISION_CNT) begin
        cnt_pre <= cnt_pre + 1'b1;
    end else begin
        cnt_pre <= 'd1;
    end
end
assign time_pre = cnt_pre == PRECISION_CNT;

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        cnt_per <= 'd0;
    end else if (time_pre) begin
        cnt_per <= (cnt_per<PERIOD_CNT)?(cnt_per+1'b1):1'd1;
    end else begin
        cnt_per <= cnt_per;
    end
end
assign time_per = cnt_per == PERIOD_CNT && time_pre;

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        cnt_cyc <= 'd0;
    end else if (time_per) begin
        cnt_cyc <= (cnt_cyc<CYCLE_CNT)?(cnt_cyc+1'b1):1'd1;
    end else begin
        cnt_cyc <= cnt_cyc;
    end
end
assign time_cyc = cnt_cyc == CYCLE_CNT && time_per;

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        turn_flag <= 1'b0;
    end else if (time_cyc) begin
        turn_flag <= ~turn_flag;
    end else begin
        turn_flag <= turn_flag;
    end
end

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        pwm_sig <= 1'b1;
    end else begin
        case (turn_flag)
            1'b0: pwm_sig <= (cnt_per>cnt_cyc)?1'b1:1'b0;
            1'b1: pwm_sig <= (cnt_per<cnt_cyc)?1'b1:1'b0;
            default: pwm_sig <= pwm_sig;
        endcase
    end
end

function integer clogb2 (input integer depth);
    begin
        for(clogb2=0; depth>0; clogb2=clogb2+1)
        depth = depth >> 1;
    end
endfunction
endmodule