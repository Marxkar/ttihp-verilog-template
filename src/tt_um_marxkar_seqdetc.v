module tt_um_marxkar_seqdetc(input clk,reset,input_bit,ena,output reg output_indicator,output wire [2:0]present_state);
wire [2:0]qb;
wire[2:0]d;
assign d[2]=(~present_state[2]&present_state[1]&present_state[0]&~input_bit);
assign d[1]=(~present_state[2]&~present_state[1]&present_state[0]&~input_bit)
            |(~present_state[2]&present_state[1]&~present_state[0]&input_bit);
assign d[0]=input_bit&(~present_state[2]|(present_state[2]&~present_state[1]&~present_state[0])) 
            |present_state[2]&~present_state[1]&present_state[0]&~input_bit;
dff d0(clk,reset,d[2],present_state[2],qb[2]);
dff d1(clk,reset,d[1],present_state[1],qb[1]);
dff d2(clk,reset,d[0],present_state[0],qb[0]);
always @(posedge clk)
output_indicator<=present_state[2]&~present_state[1]&~present_state[0]&input_bit;
endmodule
