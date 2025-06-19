module tbseq;

    reg clk;
    reg rst_n;
    reg ena;
    reg [7:0] ui_in;
    wire [7:0] uo_out;
    reg [7:0] uio_in = 8'b0;
    wire [7:0] uio_out;
    wire [7:0] uio_oe;

    // Instantiate DUT
    tt_um_marxkar_seqdetc dut (
        .clk(clk),
        .rst_n(rst_n),
        .ena(ena),
        .ui_in(ui_in),
        .uo_out(uo_out),
        .uio_in(uio_in),
        .uio_out(uio_out),
        .uio_oe(uio_oe)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 10ns clock period = 100 MHz
    end

    // Test sequence
    initial begin
        // Initialize
        rst_n = 0;
        ena = 0;
        ui_in = 8'b0;

        // Wait a few cycles
        #20;
        rst_n = 1;
        ena = 1;

        // Apply input sequence: 10101 (should trigger output at last bit)
        apply_bit(1);  // state change
        apply_bit(0);  // state change
        apply_bit(1);  // state change
        apply_bit(0);  // state change
        apply_bit(1);  // SEQUENCE DETECTED HERE

        // Wait and finish
        #20;

        if (uo_out[0] == 1'b1)
            $display("TEST PASSED: Sequence 10101 detected.");
        else
            $display("TEST FAILED: Sequence 10101 NOT detected.");

        $finish;
    end

    // Task to apply a bit and wait for one clock
    task apply_bit(input bit_value);
        begin
            ui_in[0] = bit_value;
            #10; // One clock cycle
        end
    endtask

endmodule
