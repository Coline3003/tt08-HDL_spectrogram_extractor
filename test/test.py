# SPDX-FileCopyrightText: © 2024 Tiny Tapeout
# SPDX-License-Identifier: Apache-2.0

import cocotb
from cocotb.clock import Clock
from cocotb.triggers import ClockCycles


@cocotb.test()
async def test_project(dut):
    dut._log.info("Start")

    # Set the clock period to 1 us (1 MHz)
    clock = Clock(dut.clk, 1, units="us")
    cocotb.start_soon(clock.start())

    # Reset
    dut._log.info("Reset")
    dut.ena.value = 1
    dut.ui_in.value = 0
    dut.uio_in.value = 0
    dut.rst_n.value = 0
    await ClockCycles(dut.clk, 10)
    dut.rst_n.value = 1

    dut._log.info("Test project behavior")

    # Set the input values you want to test
    # set the RTC_clk to 3600 Hz to have a sending each second instead of each hour
    RTC_clk = Clock(dut.ui_in[0], 277777778, units="ps")
    cocotb.start_soon(RTC_clk.start())

    
    #set values for channels 
    #channel 1 => 1 pulse 
    ch1 = Clock(dut.ui_in[1], 1, units="sec")
    cocotb.start_soon(ch1.start())
    #channel 2 => 2 pulses 
    ch2 = Clock(dut.ui_in[2], 500, units="ms")
    cocotb.start_soon(ch2.start())
    #channel 3 => 4 pulses 
    ch3 = Clock(dut.ui_in[3], 250, units="ms")
    cocotb.start_soon(ch3.start())
    #channel 4 => 8 pulses 
    ch4 = Clock(dut.ui_in[4], 125, units="ms")
    cocotb.start_soon(ch4.start())
    #channel 5 => 16 pulses 
    ch5 = Clock(dut.ui_in[5], 62500, units="us")
    cocotb.start_soon(ch5.start())
    #channel 6 => 32 pulses 
    ch6 = Clock(dut.ui_in[6],31250 , units="us")
    cocotb.start_soon(ch6.start())
    #channel 7 => 64 pulses 
    ch7 = Clock(dut.ui_in[7],15625 , units="us")
    cocotb.start_soon(ch7.start())
    #channel 8 => 128 pulses 
    ch8 = Clock(dut.uio_in[0],7812500 , units="ns")
    cocotb.start_soon(ch8.start())
    #channel 9 => 256 pulses 
    ch9 = Clock(dut.uio_in[1], 3906250, units="ns")
    cocotb.start_soon(ch9.start())
     #channel 10 => 512 pulses 
    ch10 = Clock(dut.uio_in[2], 1953125, units="ns")
    cocotb.start_soon(ch10.start())
      #channel 11 => 1024 pulses 
    ch11 = Clock(dut.uio_in[3], 976562500, units="ps")
    cocotb.start_soon(ch11.start())
     #channel 12 => 2048 pulses 
    ch12 = Clock(dut.uio_in[4],488281250 , units="ps")
    cocotb.start_soon(ch12.start())
     #channel 13 => 2730 pulses (1010 1010 1010)b
    ch13 = Clock(dut.uio_in[5], 366300, units="ns")
    cocotb.start_soon(ch13.start())
     #channel 14 => 240 pulses (0000 1111 0000)b
    ch14 = Clock(dut.uio_in[6], 4166666, units="ns")
    cocotb.start_soon(ch14.start())
     #channel 15 => 4095 pulses (1111 1111 1111)b
    ch15 = Clock(dut.uio_in[7], 244200, units="ns")
    cocotb.start_soon(ch15.start())


    # Wait for one clock cycle to see the output values
    await ClockCycles(dut.clk,2100000)


# test ovf channel

     #channel 15 => 4096 pulses (1111 1111 1111)b
    ch15 = Clock(dut.uio_in[7], 244, units="us")
    cocotb.start_soon(ch15.start())

await ClockCycles(dut.clk,1000000)

    # The following assersion is just an example of how to check the output values.
    # Change it to match the actual expected output of your module:
    # assert dut.uo_out.value == 50

    # Keep testing the module by changing the input values, waiting for
    # one or more clock cycles, and asserting the expected output values.
