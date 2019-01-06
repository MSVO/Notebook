module Q1_not(c, a);

output c;
input a;

nand nand_1(c, a, a);

endmodule


module Q2_and(c, a, b);

output c;
input a, b;

//x = nand(a, b)
nand nand_1(x, a, b);

//c = not(x)
nand nand_2(c, x, x);

endmodule

// OR
module Q3_or(c, a, b);
output c;
input a, b;

// aa = not(a)
nand nand_1(aa, a, a);
// bb = not(b)
nand nand_2(bb, b, b);
// c = nand(aa, bb)
nand nand_3(c, aa, bb);

endmodule

// NOR
module Q4_nor(c, a, b);
output c;
input a, b;

nand nand_1(aa, a, a);
nand nand_2(bb, b, b);
nand nand_3(x, aa, bb);
nand nand_4(c, x, x);

endmodule

// XOR
module Q5_xor(c, a, b);
output c;
input a, b;

nand nand_1(B, b, b);
nand nand_2(A, a, a);

nand nand_3(n_aB, a, B);
nand nand_4(n_Ab, A, b);

nand nand_5(c, n_aB, n_Ab);

endmodule

// XNOR
module Q6_xnor(c, a, b);
output c;
input a, b;

nand nand_1(B, b, b);
nand nand_2(A, a, a);

nand nand_3(n_aB, a, B);
nand nand_4(n_Ab, A, b);

nand nand_5(a_xor_b, n_aB, n_Ab);
nand nand_6(c, a_xor_b, a_xor_b);

endmodule 

// 16 bit NOT
module Q7_not_16bit(not_a, a);

output [15:0] not_a;
input [15:0] a;

Q1_not Q1_not_1[15:0](not_a, a);

endmodule

//16 bit AND
module Q8_and_16bit(and_ab, a, b);

output [15:0] and_ab;
input [15:0] a, b;

Q2_and Q2_and_1[15:0](and_ab, a, b);

endmodule

//16 bit OR
module Q9_or_16bit(or_ab, a, b);
output [15:0] or_ab;
input [15:0] a, b;

Q3_or Q3_or_1[15:0](or_ab, a, b);

endmodule

//16 bit XOR 
module Q10_xor_16bit(xor_ab, a, b);
output [15:0] xor_ab;
input [15:0] a, b;

Q5_xor Q5_xor_1[15:0](xor_ab, a, b);

endmodule

//Q.11 OR 8 Input
module Q11_or_8inp(out, in0, in1, in2, in3, in4, in5, in6, in7);
output out;
input in0, in1, in2, in3, in4, in5, in6, in7;
wire w1, w2, w3, w4, w5, w6;

Q3_or Q3_or_1(w1, in0, in1);
Q3_or Q3_or_2(w2, w1, in2);
Q3_or Q3_or_3(w3, w2, in3);
Q3_or Q3_or_4(w4, w3, in4);
Q3_or Q3_or_5(w5, w4, in5);
Q3_or Q3_or_6(w6, w5, in6);
Q3_or Q3_or_7(out, w6, in7);

endmodule

//Q.12 Mux 2:1
module Q12_mux(out, in0, in1, sel);
output out;
input in0, in1, sel;
wire nsel, nsel_in0, sel_in1;

Q1_not Q1_not_1(nsel, sel);

Q2_and Q2_and_1(nsel_in0, nsel, in0);
Q2_and Q2_and_2(sel_in1, sel, in1);

Q3_or Q3_or_1(out, nsel_in0, sel_in1);

endmodule

//Q.13 Demux 2:1
module Q13_demux(out0, out1, in, sel);
output out0, out1;
input in, sel;
wire nsel;

Q1_not Q1_not_1(nsel ,sel);

Q2_and Q2_and_0(out0, in, nsel);
Q2_and Q2_and_1(out1, in, sel);

endmodule

//Additional Module to and 16 bit with 1 bit 
module switch_16bit(out, inp, switch);
output [15:0] out;
input [15:0] inp;
input switch;

Q2_and Q2_and_0(out[0], inp[0], switch);
Q2_and Q2_and_1(out[1], inp[1], switch);
Q2_and Q2_and_2(out[2], inp[2], switch);
Q2_and Q2_and_3(out[3], inp[3], switch);
Q2_and Q2_and_4(out[4], inp[4], switch);
Q2_and Q2_and_5(out[5], inp[5], switch);
Q2_and Q2_and_6(out[6], inp[6], switch);
Q2_and Q2_and_7(out[7], inp[7], switch);
Q2_and Q2_and_8(out[8], inp[8], switch);
Q2_and Q2_and_9(out[9], inp[9], switch);
Q2_and Q2_and_10(out[10], inp[10], switch);
Q2_and Q2_and_11(out[11], inp[11], switch);
Q2_and Q2_and_12(out[12], inp[12], switch);
Q2_and Q2_and_13(out[13], inp[13], switch);
Q2_and Q2_and_14(out[14], inp[14], switch);
Q2_and Q2_and_15(out[15], inp[15], switch);

endmodule


//Q.14 16 bit Multiplexer
module Q14_mux_16bit(out, in0, in1, sel);
output [15:0] out;
input [15:0] in0, in1;
input sel;
wire nsel;
wire [15:0] nsel_in0, sel_in1;

Q1_not Q1_not_1(nsel, sel);

switch_16bit switch_16bit_1(nsel_in0, in0, nsel);
switch_16bit switch_16bit_2(sel_in1, in1, sel);

Q9_or_16bit Q9_or_16bit_1(out, nsel_in0, sel_in1);

endmodule

//Q.15 16 bit 4 way Mux
module Q15_4mux_16bit(out, in0, in1, in2, in3, sel1, sel0);
output [15:0] out;
input [15:0] in0, in1, in2, in3;
input sel1, sel0;

wire nsel1_nsel0, nsel1_sel0, sel1_nsel0, sel1_sel0, nsel1, nsel0;
wire [15:0] win0, win1, win2, win3, wwin1, wwin2;
Q1_not Q1_not_1(nsel1, sel1);
Q1_not Q1_not_2(nsel0, sel0);

Q2_and Q2_and_00(nsel1_nsel0, nsel1, nsel0);
Q2_and Q2_and_01(nsel1_sel0, nsel1, sel0);
Q2_and Q2_and_10(sel1_nsel0, sel1, nsel0);
Q2_and Q2_and_11(sel1_sel0, sel1, sel0);

switch_16bit switch_16bit_0(win0, in0, nsel1_nsel0);
switch_16bit switch_16bit_1(win1, in1, nsel1_sel0);
switch_16bit switch_16bit_2(win2, in2, sel1_nsel0);
switch_16bit switch_16bit_3(win3, in3, sel1_sel0);

Q9_or_16bit Q9_or_16bit_1(wwin1, win0, win1);
Q9_or_16bit Q9_or_16bit_2(wwin2, wwin1, win2);
Q9_or_16bit Q9_or_16bit_3(out, wwin2, win3);

endmodule

//Q.16 16 bit 8 way Mux
module Q16_8mux_16bit(out, in0, in1, in2, in3, in4, in5, in6, in7, sel2, sel1, sel0);
output [15:0] out;
input [15:0] in0, in1, in2, in3, in4, in5, in6, in7;
input sel2, sel1, sel0;
wire nsel0, nsel1, nsel2, s0, s1, s2, s3, s4, s5, s6, s7;
wire [15:0] w0, w1, w2, w3, w4, w5, w6, w7, w11, w22, w33, w44, w55, w66;

Q1_not Q1_not_2(nsel2, sel2);
Q1_not Q1_not_1(nsel1, sel1);
Q1_not Q1_not_0(nsel0, sel0);

and_3inp forselector000(s0, nsel2, nsel1, nsel0);
and_3inp forselector001(s1, nsel2, nsel1, sel0);
and_3inp forselector010(s2, nsel2, sel1, nsel0);
and_3inp forselector011(s3, nsel2, sel1, sel0);
and_3inp forselector100(s4, sel2, nsel1, nsel0);
and_3inp forselector101(s5, sel2, nsel1, sel0);
and_3inp forselector110(s6, sel2, sel1, nsel0);
and_3inp forselector111(s7, sel2, sel1, sel0);
 
//Product terms
switch_16bit in0product(w0, in0, s0);
switch_16bit in1product(w1, in1, s1);
switch_16bit in2product(w2, in2, s2);
switch_16bit in3product(w3, in3, s3);
switch_16bit in4product(w4, in4, s4);
switch_16bit in5product(w5, in5, s5);
switch_16bit in6product(w6, in6, s6);
switch_16bit in7product(w7, in7, s7);

//Summing products
Q9_or_16bit or1(w11, w0, w1);
Q9_or_16bit or2(w22, w11, w2);
Q9_or_16bit or3(w33, w22, w3);
Q9_or_16bit or4(w44, w33, w4);
Q9_or_16bit or5(w55, w44, w5);
Q9_or_16bit or6(w66, w55, w6);
Q9_or_16bit or7(out, w66, w7);

endmodule

//Q.17 4 WAY DEMUX 
module Q17_4demux(out0, out1, out2, out3, in, sel1, sel0);
output out0, out1, out2, out3;
input in, sel1, sel0;
wire nsel1, nsel0, s0, s1, s2, s3;

Q1_not notsel1(nsel1, sel1);
Q1_not notsel0(nsel0, sel0);

Q2_and selector0(s0, nsel1, nsel0);
Q2_and selector1(s1, nsel1, sel0);
Q2_and selector2(s2, sel1, nsel0);
Q2_and selector3(s3, sel1, sel0);

Q2_and select0(out0, in, s0);
Q2_and select1(out1, in, s1);
Q2_and select2(out2, in, s2);
Q2_and select3(out3, in, s3);

endmodule 

//Additional module 3 input and
module and_3inp(out, in1, in2, in3);
output out;
input in1, in2, in3;
wire w;

Q2_and and1(w, in1, in2);
Q2_and and2(out, w, in3);

endmodule


//Q.18 8 WAY DEMUX
module Q18_8demux(out0, out1, out2, out3, out4, out5, out6, out7, in, sel2, sel1, sel0);
output out0, out1, out2, out3, out4, out5, out6, out7;
input in, sel2, sel1, sel0;
wire nsel2, nsel1, nsel0, s0, s1, s2, s3, s4, s5, s6, s7;

Q1_not notsel2(nsel2, sel2);
Q1_not notsel1(nsel1, sel1);
Q1_not notsel0(nsel0, sel0);

and_3inp selector0(s0, nsel2, nsel1, nsel0);
and_3inp selector1(s1, nsel2, nsel1, sel0);
and_3inp selector2(s2, nsel2, sel1, nsel0);
and_3inp selector3(s3, nsel2, sel1, sel0);
and_3inp selector4(s4, sel2, nsel1, nsel0);
and_3inp selector5(s5, sel2, nsel1, sel0);
and_3inp selector6(s6, sel2, sel1, nsel0);
and_3inp selector7(s7, sel2, sel1, sel0);

Q2_and select0(out0, in, s0);
Q2_and select1(out1, in, s1);
Q2_and select2(out2, in, s2);
Q2_and select3(out3, in, s3);
Q2_and select4(out4, in, s4);
Q2_and select5(out5, in, s5);
Q2_and select6(out6, in, s6);
Q2_and select7(out7, in, s7);

endmodule



