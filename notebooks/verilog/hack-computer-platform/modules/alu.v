//Replace inbuild gates with gates from other-modules.v implemented using nand chips alone.

module alu(out, zo, ng, x, y, c1, c2, c3, c4, c5, c6);
	output [15:0] out;
	output zo, ng;
	input [15:0] x, y;
	input c1, c2, c3, c4, c5, c6;

	wire [15:0] x1, y1;
	mux x1mux[15:0](x1, x, 0, c1);
	mux y1mux[15:0](y1, y, 0, c2);

	wire [15:0] nx1, ny1, x2, y2;
	not nx1not[15:0](nx1, x1);
	not ny1not[15:0](ny1, y1);
	mux x2mux[15:0](x2, x1, nx1, c3);
	mux y2mux[15:0](y2, y1, ny1, c4);

	wire [15:0] outand, outadd, out1;
	adder_16bit out1add(outadd, , x2, y2, 0);
	and outand[15:0](outand, x2, y2);
	mux out1mux[15:0](out1, outand, outadd, c5);

	wire [15:0] out, nout1;
	not nout1not[15:0](nout1, out1);
	mux outmux[15:0](out, out1, nout1, c6);

	and(ng, out[15], out[15]);
	nor(zo, out[15], out[14], out[13], 
		out[12], out[11], out[10], 
		out[9], out[8], out[7], 
		out[6], out[5], out[4], 
		out[3], out[2], out[1], 
		out[0])
endmodule