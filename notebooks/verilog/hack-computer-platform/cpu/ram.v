module ram(output [15:0] ram_out,
		input [15:0] ram_in,
		input [6:0] ram_add,
		input write,
		input clock);

		reg [15:0] storage [127:0];
		
		assign ram_out = storage[ram_add];
		
		always @(posedge clock) begin
			if(write) begin
				storage[ram_add] = ram_in;
			end
		end

endmodule

module test_ram;

	reg [15:0] ram_in;
	reg [6:0] ram_add;
	reg write;
	reg clock;
	wire [15:0] ram_out;

	ram uut(ram_out, ram_in, ram_add, write, clock);

	initial begin
		clock = 0;
		forever begin
			#5; clock = ~clock;
		end
	end

	initial begin
		write = 1;
		ram_add = 1; ram_in = 45; #10;
		ram_add = 127; ram_in = 50; #10;
		write = 0;
		ram_in = 1; #10;
		ram_add = 1; #10;
		ram_add = 127; #10;
	end
endmodule 