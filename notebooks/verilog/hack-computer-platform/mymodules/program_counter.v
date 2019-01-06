module pc(out, inc, load, reset, in, clk);

	output [15:0] out;
	input [15:0] in;
	input inc, load, reset, clk;

	reg [15:0] out;

	always @(posedge clk) begin
		if(reset == 1'b1) begin
			out = 0;
		end

		else if(load == 1'b1) begin
			out = in;
		end

		else if(inc == 1'b1) begin
			out = out + 1;
		end
	end

endmodule

module pc_test;
	reg [15:0] pc_in;
	reg inc, load, reset, clock;
	wire [15:0] pc_out;
	pc UUT(pc_out, inc, load, reset, pc_in, clock);
	initial begin
		load = 1; pc_in = 7; clock = 0; #5; clock = 1; #5;
	end
endmodule
