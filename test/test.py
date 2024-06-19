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
    clock = Clock(dut.dut.ui_in[0], 278, units="us")
    #set values for channels 
    #channel 1 => 1Hz 
    dut.ui_in[1].value = Clock(dut.clk, 1, units="s")
    #channel 2 => 2Hz 
    dut.ui_in[2].value = Clock(dut.clk, 500, units="ms")
    #channel 3 => 4Hz 
    dut.ui_in[3].value = Clock(dut.clk, 250, units="ms")
    #channel 4 => 8Hz 
    dut.ui_in[4].value = Clock(dut.clk, 125, units="ms")
    
    dut.uio_in.value = 30

    # Wait for one clock cycle to see the output values
    await ClockCycles(dut.clk, 200000)

    # The following assersion is just an example of how to check the output values.
    # Change it to match the actual expected output of your module:
    # assert dut.uo_out.value == 50

    # Keep testing the module by changing the input values, waiting for
    # one or more clock cycles, and asserting the expected output values.
