module dff(input clk,reset,d,output q,qb);
wire [4:0]a;
assign a[0]=~reset;
assign a[1]=~(a[0]&d&a[2]);
assign a[2]=~(a[1]&clk&a[3]);
assign a[3]=~(a[0]&clk&a[4]);
assign a[4]=~(a[1]&a[3]);
assign qb=~(a[0]&a[2]&q);
assign q=~(a[3]&qb);
endmodule
