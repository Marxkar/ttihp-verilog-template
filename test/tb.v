module tbseq;
reg rst_n;
reg clk=0;
reg input_bit;
wire output_indicator;
wire [2:0]present_state;
  seqdetc uut(clk,rst_n,input_bit,ena,output_indicator,present_state);
always #5 clk=~clk;
initial begin
rst_n=0;#7;
rst_n=1;input_bit=1;#3;
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
