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

	adder add1(out[0], c1, x[0], y[0], c0);
	adder add2(out[1], c2, x[1], y[1], c1);
	adder add3(out[2], c3, x[2], y[2], c2);
	adder add4(out[3], c4, x[3], y[3], c3);
	adder add5(out[4], c5, x[4], y[4], c4);
	adder add6(out[5], c6, x[5], y[5], c5);
	adder add7(out[6], c7, x[6], y[6], c6);
	adder add8(out[7], c8, x[7], y[7], c7);
	adder add9(out[8], c9, x[8], y[8], c8);
	adder add10(out[9], c10, x[9], y[9], c9);
	adder add11(out[10], c11, x[10], y[10], c10);
	adder add12(out[11], c12, x[11], y[11], c11);
	adder add13(out[12], c13, x[12], y[12], c12);
	adder add14(out[13], c14, x[13], y[13], c13);
	adder add15(out[14], c15, x[14], y[14], c14);
	adder add16(out[15], c16, x[15], y[15], c15);

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
