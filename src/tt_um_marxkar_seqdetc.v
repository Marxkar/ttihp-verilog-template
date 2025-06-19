module tt_um_marxkar_seqdetc(
    input clk,
    input rst_n,
    input ena,
    input  [7:0] ui_in,
    output [7:0] uo_out,
    input  [7:0] uio_in,
    output [7:0] uio_out,
    output [7:0] uio_oe
);

    // Input mapping
    wire input_bit = ui_in[0];

    // Output registers
    reg [2:0] present_state;
    reg output_indicator;

    // Internal wires
    wire [2:0] qb;
    wire [2:0] d;

    // Next state logic
    assign d[2] = (~present_state[2] & present_state[1] & present_state[0] & ~input_bit);
    assign d[1] = (~present_state[2] & ~present_state[1] & present_state[0] & ~input_bit)
                | (~present_state[2] & present_state[1] & ~present_state[0] & input_bit);
    assign d[0] = input_bit & (~present_state[2] | (present_state[2] & ~present_state[1] & ~present_state[0])) 
                | (present_state[2] & ~present_state[1] & present_state[0] & ~input_bit);

    // Flip-flops for state (reset is active-low)
    dff d0(clk, ~rst_n, d[2], present_state[2], qb[2]);
    dff d1(clk, ~rst_n, d[1], present_state[1], qb[1]);
    dff d2(clk, ~rst_n, d[0], present_state[0], qb[0]);

    // Output logic
    always @(posedge clk) begin
        if (!rst_n)
            output_indicator <= 1'b0;
        else if (ena)
            output_indicator <= present_state[2] & ~present_state[1] & ~present_state[0] & input_bit;
    end

    // Output assignments
    assign uo_out[0] = output_indicator;
    assign uo_out[1] = present_state[0];
    assign uo_out[2] = present_state[1];
    assign uo_out[3] = present_state[2];
    assign uo_out[7:4] = 4'b0000;

    // Unused bidirectional pins
    assign uio_out = 8'b0;
    assign uio_oe  = 8'b0;

endmodule

