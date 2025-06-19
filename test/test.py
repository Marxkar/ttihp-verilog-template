import cocotb
from cocotb.clock import Clock
from cocotb.triggers import Timer, RisingEdge

@cocotb.test()
async def test_seqdet_via_ui(dut):
    clock = Clock(dut.clk, 10, units="ns")  # 10ns clock period
    cocotb.start_soon(clock.start())

    # Signal aliases
    reset = dut.rst_n         # Active-low reset (set to 0 to reset)
    input_bit = dut.ui_in[0]  # Driving input bit to FSM
    output_indicator = dut.uo_out[0]  # Assuming first output bit
    state = dut.uo_out[3:1]   # Assuming bits 1-3 for FSM state

    # Reset sequence (assert high, then deassert)
    dut._log.info("Resetting")
    reset.value = 1
    await Timer(7, units="ns")
    reset.value = 0
    await RisingEdge(dut.clk)  # sync after reset
    await Timer(3, units="ns")

    # Define input sequence from original testbench
    sequence = [1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1]

    for bit in sequence:
        input_bit.value = bit
        await Timer(10, units="ns")  # match #10 delay

        # Log internal state and output
        dut._log.info(f"Input: {bit} | State: {state.value.integer} | Output: {output_indicator.value}")

