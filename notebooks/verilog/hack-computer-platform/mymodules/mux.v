
module mux(out, x, y, s);
	output out;
	input x, y, s;

	wire select2, select1;
	and(select1, x, !s);
	and(select2, y, s);
	or(out, select2, select1);
endmodule

 
