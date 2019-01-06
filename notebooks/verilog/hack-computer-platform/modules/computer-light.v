module computer;

	//RAM
	reg [15:0] ram_input;
	reg [6:0] ram_address;
	wire [15:0] ram_output;
	reg ram_load;
	ram main_memory(ram_output, ram_load, ram_address, ram_input);

	//ALU
	reg [15:0] alu_x; alu_y;
	wire [15:0] alu_out;
	wire zo, ng;
	alu al_unit(alu_out, zo, ng, alu_x, alu_y, IR[11], IR[10], IR[9], IR[8], IR[7], IR[6])

	//REGISTER SET
	reg [15:0] A, D, IR;

	//PROGRAM COUNTER
	reg [15:0] pc_in;
	reg pc_inc, pc_load, pc_reset, pc_clock;
	wire [15:0] pc_out;
	pc instruction_pointer(pc_out, pc_inc, pc_load, pc_reset, pc_clock);

	//RESETTING
	initial begin
		reset = 1; #5; reset = 0; #5;
	end

	//LOADING PROGRAM
	always @(negedge reset) begin
		ram_load = 1;
		ram_input = 16'b0000000000000000;
		ram_address = 64; #20;
		ram_input = 16'b0000000000000000;
		ram_address = 65; #20;
		ram_input = 16'b0000000000000000;
		ram_address = 66; #20;
		ram_input = 16'b0000000000000000;
		ram_address = 67; #20;
		ram_input = 16'b0000000000000000;
		ram_address = 68; #20;
		ram_input = 16'b0000000000000000;
		ram_address = 69; #20;
		ram_load = 0; #20;
		pc_inc = 0; pc_load = 1; pc_reset = 0; pc_clock = 0; #5; pc_clock = 1; #5;
		pc_inc = 1; pc_load = 0; pc_clock = 0; #5; pc_clock = 1; #5;
	end
	//...

	//RUNNING PROGRAM
	always @(posedge reset) begin
		for(i=0;i<instructions;i=i+1) begin
			//FETCH
			ram_address = pc_out; #20;
			IR = ram_output;
			//DECODE
			or(j1, zo, IR[2]);
			or(j2, ng, IR[1]);
			or(j3, !zo, IR[0]);
			or(jump, j0, j1, j2);
			//EXECUTE
			if(IR[15]) begin
				A = IR; #10;
			end
			else begin
				alu_x = D; #5;
				if(IR[12]) begin
					alu_y = A; #5;
				end
				else begin
					ram_address = A; #20;
					alu_x = ram_out; #5;
				end
				if(IR[5]) begin
					A = alu_out; #5;
				end
				if(IR[4]) begin
					D = alu_out; #5;
				end
				if(IR[3]) begin
					ram_load = 1; ram_address = A; ram_input = alu_out; #20;
					ram_load = 0; #10;
				end
				if(jump) begin
					pc_load = 1; pc_in = A; pc_clock = 0; #5; pc_clock = 1; #5;
				end
				else begin
					pc_clock = 0; #5; pc_clock = 1; #5;
				end
			end
		end
	end

endmodule

