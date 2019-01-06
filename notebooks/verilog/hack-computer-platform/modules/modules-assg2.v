//Q1 HALF ADDER
module a2q1_half_adder(sum, carry, in1, in2);
output sum, carry;
input in1, in2;
Q5_xor xor1(sum, in1, in2);
Q2_and and1(carry, in1, in2);
endmodule

module a2q1_half_adder_tb;
reg in1, in2;
wire sum, carry;
a2q1_half_adder adder(sum, carry, in1, in2);
initial begin
in1 <= 0; in2 <= 0; #10;
in1 <= 0; in2 <= 1; #10;
in1 <= 1; in2 <= 0; #10;
in1 <= 1; in2 <= 1; #10;
end
endmodule

//Q2 FULL ADDER
module a2q2_full_adder(sum, cout, in1, in2, cin);
output sum, cout;
input in1, in2, cin;
wire c1, c2;
a2q1_half_adder halfadder1(x, c1, in1, in2);
a2q1_half_adder halfadder2(sum, c2, x, cin);
Q3_or or1(cout, c1, c2);
endmodule

module a2q2_full_adder_tb;
reg in1, in2, cin;
wire sum, cout;
a2q2_full_adder fadder(sum, cout, in1, in2, cin);
initial begin
in1 = 0; in2 = 0; cin = 0; #10;
in1 = 0; in2 = 0; cin = 1; #10;
in1 = 0; in2 = 1; cin = 0; #10;
in1 = 0; in2 = 1; cin = 1; #10;
in1 = 1; in2 = 0; cin = 0; #10;
in1 = 1; in2 = 0; cin = 1; #10;
in1 = 1; in2 = 1; cin = 0; #10;
in1 = 1; in2 = 1; cin = 1; #10;
end
endmodule

//Q3 4 BIT INCREMENTER
module a2q3_4bit_incrementer(out, in);
output [3:0] out;
input [3:0] in;
a2q2_full_adder fadd1(out[0], c1, in[0], 1'b1, 1'b0);
a2q2_full_adder fadd2(out[1], c2, in[1], 1'b0, c1);
a2q2_full_adder fadd3(out[2], c3, in[2], 1'b0, c2);
a2q2_full_adder fadd4(out[3], c4, in[3], 1'b0, c3);
endmodule

module a2q3_4bit_incrementer_tb;
wire [3:0] out;
reg [3:0] in;
a2q3_4bit_incrementer inc(out, in);
initial begin
in = 5; #10;
end
endmodule

//Q4 4 BIT ADDER
module a2q4_4bit_adder(out, cout, in1, in2, cin);
output [3:0] out;
output cout;
input [3:0] in1, in2;
input cin;
a2q2_full_adder fadd1(out[0], c1, in1[0], in2[0], cin);
a2q2_full_adder fadd2(out[1], c2, in1[1], in2[1], c1);
a2q2_full_adder fadd3(out[2], c3, in1[2], in2[2], c2);
a2q2_full_adder fadd4(out[3], cout, in1[3], in2[3], c3);
endmodule

module a2q4_4bit_adder_tb;
reg [3:0] in1, in2;
reg cin;
wire [3:0] out;
wire cout;
a2q4_4bit_adder adder(out, cout, in1, in2, cin);
initial begin
in1 <= 15;
in2 <= 1;
cin <= 0;
#10;
end
endmodule

//Q5 4 BIT NEGATOR
module a2q5_4bit_negator(out, in);
output [3:0] out;
input [3:0] in;
Q1_not notgates[3:0](out, in);
endmodule

module a2q5_4bit_negator_tb;
reg [3:0] in;
wire [3:0] out;
a2q5_4bit_negator neg(out, in);
initial begin
in = 6;
#10;
end
endmodule

//16 BIT ADDER
module a2q6_16bit_adder(out, cout, in1, in2, cin);
output [15:0] out;
output cout;
input [15:0] in1, in2;
input cin;
a2q4_4bit_adder add1(out[3:0], c1, in1[3:0], in2[3:0], cin);
a2q4_4bit_adder add2(out[7:4], c2, in1[7:4], in2[7:4], c1);
a2q4_4bit_adder add3(out[11:8], c3, in1[11:8], in2[11:8], c2);
a2q4_4bit_adder add4(out[15:12], cout, in1[15:12], in2[15:12], c3);
endmodule

module a2q6_16bit_adder_tb;
reg [15:0] in1, in2;
reg cin;
wire [15:0] out;
wire cout;
a2q6_16bit_adder add1(out, cout, in1, in2, cin);
initial begin
cin <= 1'b0;
in1 <= 65535;
in2 <= 1;
#10;
end
endmodule

//16 BIT INCREMENTER
module a2q7_16bit_incrementer(out, in);
output [15:0] out;
input [15:0] in;
a2q6_16bit_adder add1(out, c1, in, 16'b0000000000000001, 1'b0);
endmodule

module a2q7_16bit_incrementer_tb;
reg [15:0] in;
wire [15:0] out;
a2q7_16bit_incrementer inc(out, in);
initial begin
in = 6553;
#10;
end
endmodule

//16 BIT NEGATOR
module a2q8_16bit_negator(out, in);
output [15:0] out;
input [15:0] in;
Q1_not notgates[15:0](out, in);
endmodule

module a2q8_16bit_negator_tb;
reg [15:0] in;
wire [15:0] out;
a2q8_16bit_negator neg(out, in);
initial begin
in = 7575;
#10;
end
endmodule

//ALU
module a2q9_ALU(out, zr, ng, x, y, zx, nx, zy, ny, f, no);
output [15:0] out;
output zr, ng;
input [15:0] x, y;
input zx, nx, zy, ny, f, no;
wire [15:0] t11, t12, t21, t22, w11, w12, w21, w22, x1, y1, x2, y2, x1_c, y1_c;
wire [15:0] fxy_1, fxy_2, Fxy_1, Fxy_2, Fxy, Fxy_c, out_1, out_2;

wire zx_c, nx_c, zy_c, ny_c, f_c, no_c;
Q1_not not1(zx_c, zx);
Q1_not not2(nx_c, nx);
Q1_not not3(zy_c, zy);
Q1_not not4(ny_c, ny);
Q1_not not5(f_c, f);
Q1_not not6(no_c, no);

Q2_and andfort11[15:0](t11, zx, 1'b0);
Q2_and andfort12[15:0](t12, zx_c, x);
Q9_or_16bit orfort11t12(x1, t11, t12);

Q2_and andforw11[15:0](w11, zy, 1'b0);
Q2_and andforw12[15:0](w12, zy_c, y);
Q9_or_16bit orforw11w12(y1, w11, w12);

Q7_not_16bit notx1(x1_c, x1);
Q7_not_16bit noty1(y1_c, y1);

Q2_and andfort21[15:0](t21, nx, x1_c);
Q2_and andfort22[15:0](t22, nx_c, x1);
Q9_or_16bit orfort21t22(x2, t21, t22);

Q2_and andforw21[15:0](w21, ny, y1_c);
Q2_and andforw22[15:0](w22, ny_c, y1);
Q9_or_16bit orforw21w22(y2, w21, w22);

Q8_and_16bit andforfxy_1(fxy_1, x2, y2);
a2q6_16bit_adder addforfxy_2(fxy_2, carry, x2, y2, 1'b0);
Q2_and andforFxy_1[15:0](Fxy_1, f_c, fxy_1);
Q2_and andforFxy_2[15:0](Fxy_2, f, fxy_2);
Q9_or_16bit orforFxy(Fxy, Fxy_1, Fxy_2);

Q7_not_16bit notFxy(Fxy_c, Fxy);
Q2_and andforout_1[15:0](out_1, no, Fxy_c);
Q2_and andforout_2[15:0](out_2, no_c, Fxy);
Q9_or_16bit orFinalOut(out, out_1, out_2);

Q11_or_8inp orforzr1(zr1, out[0], out[1], out[2], out[3], out[4], out[5], out[6], out[7]);
Q11_or_8inp orforzr2(zr2, out[8], out[9], out[10], out[11], out[12], out[13], out[14], out[15]);
Q3_or orforzr_c(zr_c, zr1, zr2);
Q1_not Finalzr(zr, zr_c);

Q2_and andforng(ng, 1'b1, out[15]);
endmodule

module a2q9_ALU_tb;
reg [15:0] x, y;
reg zx, nx, zy, ny, f, no;
wire [15:0] out;
wire zr, ng;

a2q9_ALU ALU(out, zr, ng, x, y, zx, nx, zy, ny, f, no);
initial begin
x = 5746;
y = 457;
zx<=0; nx<=0; zy<=0; ny<=0; f<=1; no<=0; #10; //q9.a
zx<=0; nx<=1; zy<=0; ny<=0; f<=1; no<=1; #10; //q9.b
zx<=0; nx<=0; zy<=0; ny<=1; f<=1; no<=1; #10; //q9.c
zx<=1; nx<=0; zy<=1; ny<=0; f<=1; no<=0; #10; //q9.d
zx<=1; nx<=1; zy<=1; ny<=1; f<=1; no<=1; #10; //q9.e
zx<=1; nx<=0; zy<=1; ny<=1; f<=1; no<=0; #10; //q9.f
zx<=0; nx<=0; zy<=1; ny<=1; f<=0; no<=0; #10; //q9.g
zx<=1; nx<=1; zy<=0; ny<=0; f<=0; no<=0; #10; //q9.h
zx<=0; nx<=0; zy<=1; ny<=1; f<=1; no<=1; #10; //q9.i
zx<=1; nx<=1; zy<=0; ny<=0; f<=1; no<=1; #10; //q9.j
zx<=0; nx<=1; zy<=1; ny<=1; f<=0; no<=0; #10; //q9.k
zx<=1; nx<=1; zy<=0; ny<=1; f<=0; no<=0; #10; //q9.l
zx<=0; nx<=1; zy<=1; ny<=1; f<=1; no<=1; #10; //q9.m
zx<=1; nx<=1; zy<=0; ny<=1; f<=1; no<=1; #10; //q9.n
zx<=0; nx<=0; zy<=1; ny<=1; f<=1; no<=0; #10; //q9.o
zx<=1; nx<=1; zy<=0; ny<=0; f<=1; no<=0; #10; //q9.p
zx<=0; nx<=0; zy<=0; ny<=0; f<=0; no<=0; #10; //q9.q
zx<=0; nx<=1; zy<=0; ny<=1; f<=0; no<=1; #10; //q9.r

end
endmodule













