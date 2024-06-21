//`include "channel_counter.v"
//`include "FSM.v"
//`include "time_counter.v"
//`include "PISO_register.v"
//`include "mux_16to1.v"

/*
clk : clock for PISO_register and FSM
RTC : clock for time counter
ch1 to ch15 : cloks for channel counters
reset : when ('1') reset all components 
serial_out : main output, active periodically (when ovf_global is hight). serialization of counter values.
ovf_global : hight if one channel overflow or if the time_counter reaches 59:59
ovf_RTC_out : hight if the time_counter reaches 59:59
a0_out to a3_out : selection bits of the MUX (use for debuging) 
SL_out : Shift/load signal for PISO_register
*/

module top(input clk, ch1, ch2, ch3, ch4, ch5, ch6, ch7, ch8, ch9, ch10, ch11, ch12, ch13, ch14, ch15, reset,RTC,
           output wire serial_out, ovf_global, ovf_RTC_out, a0_out, a1_out, a2_out, a3_out, SL_out
           );


  wire [3:0] selection_bits;
  wire [11:0] data [15:0]; //RTC_counter = data[0], ch1_counter = data[1] etc...
  wire ovf1, ovf2, ovf3, ovf4, ovf5,ovf6,ovf7,ovf8,ovf9,ovf10,ovf11,ovf12,ovf13,ovf14,ovf15,ovf_RTC;
  wire [11:0] mux_data_out;
  wire SL;
  wire out_rst; 
  wire  ovf_ch_out;

  assign ovf_RTC_out = ovf_RTC;
  assign ovf_ch_out = ovf1||ovf2||ovf3||ovf4||ovf5||ovf6||ovf7||ovf8||ovf9||ovf10||ovf11||ovf12||ovf13||ovf14||ovf15;
  assign {a3_out, a2_out , a1_out, a0_out} = selection_bits[3:0];
  assign SL_out = SL;
  
  assign ovf_global = ovf_ch_out||ovf_RTC;


  time_counter time_c(.clk(RTC), .reset(reset), .rst_ovf(out_rst),
                        .min(data[0][11:6]),.sec(data[0][5:0]),.ovf(ovf_RTC))/* synthesis syn_noprune=1 */;

  channel_counter ch1c(.impulse(ch1), .reset(reset||out_rst), .enable(ovf_global), 
                        .data(data[1]), .ovf(ovf1))/* synthesis syn_noprune=1 */;
  channel_counter ch2c(.impulse(ch2), .reset(reset||out_rst), .enable(ovf_global),
                        .data(data[2]), .ovf(ovf2))/* synthesis syn_noprune=1 */;
  channel_counter ch3c(.impulse(ch3), .reset(reset||out_rst), .enable(ovf_global),
                        .data(data[3]), .ovf(ovf3))/* synthesis syn_noprune=1 */;
  channel_counter ch4c(.impulse(ch4), .reset(reset||out_rst), .enable(ovf_global),
                        .data(data[4]), .ovf(ovf4))/* synthesis syn_noprune=1 */; 
  channel_counter ch5c(.impulse(ch5), .reset(reset||out_rst), .enable(ovf_global),
                        .data(data[5]), .ovf(ovf5))/* synthesis syn_noprune=1 */;
  channel_counter ch6c(.impulse(ch6), .reset(reset||out_rst), .enable(ovf_global),
                        .data(data[6]), .ovf(ovf6))/* synthesis syn_noprune=1 */;
  channel_counter ch7c(.impulse(ch7), .reset(reset||out_rst), .enable(ovf_global),
                        .data(data[7]), .ovf(ovf7))/* synthesis syn_noprune=1 */;
  channel_counter ch8c(.impulse(ch8), .reset(reset||out_rst), .enable(ovf_global),
                        .data(data[8]), .ovf(ovf8))/* synthesis syn_noprune=1 */;
  channel_counter ch9c(.impulse(ch9), .reset(reset||out_rst), .enable(ovf_global),
                        .data(data[9]), .ovf(ovf9))/* synthesis syn_noprune=1 */;
  channel_counter ch10c(.impulse(ch10), .reset(reset||out_rst), .enable(ovf_global),
                        .data(data[10]), .ovf(ovf10))/* synthesis syn_noprune=1 */;
  channel_counter ch11c(.impulse(ch11), .reset(reset||out_rst), .enable(ovf_global),
                        .data(data[11]), .ovf(ovf11))/* synthesis syn_noprune=1 */;
  channel_counter ch12c(.impulse(ch12), .reset(reset||out_rst), .enable(ovf_global),
                        .data(data[12]), .ovf(ovf12))/* synthesis syn_noprune=1 */;
  channel_counter ch13c(.impulse(ch13), .reset(reset||out_rst), .enable(ovf_global),
                        .data(data[13]), .ovf(ovf13))/* synthesis syn_noprune=1 */;
  channel_counter ch14c(.impulse(ch14), .reset(reset||out_rst), .enable(ovf_global),
                        .data(data[14]), .ovf(ovf14))/* synthesis syn_noprune=1 */;
  channel_counter ch15c(.impulse(ch15), .reset(reset||out_rst), .enable(ovf_global),
                        .data(data[15]), .ovf(ovf15))/* synthesis syn_noprune=1 */;


  
FSM FSM1(.clk(clk),.reset(reset),.ovf(ovf_global),.selection_bits(selection_bits),.SL(SL),.rst(out_rst))/* synthesis syn_noprune=1 */;
  
  mux_16to1 mux(.data0(data[0][11:0]),.data1(data[1][11:0]),.data2(data[2][11:0]),.data3(data[3][11:0]),.data4(data[4][11:0]),.data5(data[5][11:0]),
.data6(data[6][11:0]),.data7(data[7][11:0]),.data8(data[8][11:0]),.data9(data[9][11:0]),.data10(data[10][11:0]),.data11(data[11][11:0]),.data12(data[12][11:0]),
.data13(data[13][11:0]),.data14(data[14][11:0]),.data15(data[15][11:0]) ,.select(selection_bits[3:0]), .data_out(mux_data_out[11:0]));               

  
  PISO_register PISO_register1(.clk(clk),.parallel_in(mux_data_out[11:0]),.SL(SL),.serial_out(serial_out));

 
  

  
endmodule
