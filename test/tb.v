module tbseq;
reg reset;
reg clk=0;
reg input_bit;
wire output_indicator;
wire [2:0]present_state;
seqdetc uut(clk,reset,input_bit,output_indicator,present_state);
always #5 clk=~clk;
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
