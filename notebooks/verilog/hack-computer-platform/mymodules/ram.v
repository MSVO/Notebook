module ram(
	ram_output,
	ram_load,
	ram_address,
	ram_input,
	);
	
	integer i;
	input [15:0] ram_input;
	input ram_load;
	input [6:0] ram_address;
	output [15:0] ram_output;
	reg [15:0] ram_output;

	reg clock;
	always begin
		clock = 0; #5; clock = 1; #5;
	end

	reg [15:0] async_set [127:0];
	reg [15:0] sync_set [127:0];

	always @(posedge clock) begin
		for(i=0;i<128;i=i+1) begin
			sync_set[i] = async_set[i];
		end
	end

	always @(negedge clock) begin
		if(ram_load) begin
			async_set[ram_address] = ram_input;
		end
		else begin
			ram_output = sync_set[ram_address];
		end
	end

endmodule

module ram_test;

	reg [15:0] ram_input;
	reg [6:0] ram_address;
	reg ram_load;
	wire [15:0] ram_output;

	ram UUT(ram_output, ram_load, ram_address, ram_input);

	initial begin
		ram_address = 0; ram_load = 1; ram_input = 57; #10;
		ram_address = 1; ram_load = 1; ram_input = 1; #10;
		ram_address = 0; ram_load = 0; #10;
	end

endmodule 