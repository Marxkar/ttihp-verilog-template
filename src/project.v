module dff(input clock,reset,d,output q,qb);
wire [4:0]a;
assign a[0]=~reset;
assign a[1]=~(a[0]&d&a[2]);
assign a[2]=~(a[1]&clock&a[3]);
assign a[3]=~(a[0]&clock&a[4]);
assign a[4]=~(a[1]&a[3]);
assign qb=~(a[0]&a[2]&q);
assign q=~(a[3]&qb);
endmodule

module seqdetc(input clock,reset,input_bit,output reg output_indicator,wire [2:0]present_state);
wire [2:0]qb;
wire[2:0]d;
assign d[2]=(~present_state[2]&present_state[1]&present_state[0]&~input_bit);
assign d[1]=(~present_state[2]&~present_state[1]&present_state[0]&~input_bit)
            |(~present_state[2]&present_state[1]&~present_state[0]&input_bit);
assign d[0]=input_bit&(~present_state[2]|(present_state[2]&~present_state[1]&~present_state[0])) 
            |present_state[2]&~present_state[1]&present_state[0]&~input_bit;
dff d0(clock,reset,d[2],present_state[2],qb[2]);
dff d1(clock,reset,d[1],present_state[1],qb[1]);
dff d2(clock,reset,d[0],present_state[0],qb[0]);
always @(posedge clock)
output_indicator<=present_state[2]&~present_state[1]&~present_state[0]&input_bit;
endmodule
