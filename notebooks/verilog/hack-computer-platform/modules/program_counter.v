module program_counter(out, inc, load, reset, in, clk);

	output [15:0] out;
	input [15:0] in;
	input inc, load, reset, clk;

	reg [15:0] out;

	always @(negedge(clk)) begin
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
