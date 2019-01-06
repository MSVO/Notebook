//Implementing Modules from Nand Gates
module notgate(out, x);
	output out;
	input x;
endmodule

module andgate(out, x, y);
	output out;
	input x, y;
endmodule

module nor_within_16bit(out, x);
	output out;
	input [15:0] x;
endmodule 
