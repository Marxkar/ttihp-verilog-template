module tbseq;
reg reset;
reg clock=0;
reg input_bit;
wire output_indicator;
wire [2:0]present_state;
seqdetc uut(clock,reset,input_bit,output_indicator,present_state);
always #5 clock=~clock;
initial begin
reset=1;#7;
reset=0;input_bit=1;#3;
input_bit=0;#10;
input_bit=1;#10;
input_bit=0;#10;
input_bit=1;#10;
input_bit=0;#10;
input_bit=1;#10;
input_bit=0;#10;
input_bit=1;#10;
input_bit=0;#10;
input_bit=1;#10;
end
endmodule
