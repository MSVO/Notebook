module adder_half(out, c, x, y);
	input x, y;
	output out, c;
	xor(out, x, y);
	and(c, x, y);
endmodule

module adder(out, cout, x, y, cin);
	output out, cout;
	input x, y, cin;

	adder_half add1(out1, c1, x, y);
	adder_half add2(out, c2, out1, cin);
	or(cout, c1, c2);
endmodule

module adder_16bit(out, c16, x, y, c0);
	output [15:0] out;
	output c16;
	input [15:0] x, y;
	input c0;

	wire [16:0] carries;
	and(carries[0], 0, 0);
	and(c16, carries[16], 1);
	
	adder adders[15:0](out, carries[16:1], x, y, carries[15:0]);


endmodule
module test_adder_16bit;
	reg [15:0] x, y;
	wire [15:0] out;
	adder_16bit uut(out, , x, y, 0);
	initial begin
		x = 8;
		y = 8;
		#10;
	end
endmodule
