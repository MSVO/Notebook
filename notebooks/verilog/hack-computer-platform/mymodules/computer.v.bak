module computer;
	
	//RAM
	reg [15:0] ram_input;
	reg [6:0] ram_address;
	wire [15:0] ram_output;
	reg ram_load;
	ram main_memory(ram_output, ram_load, ram_address, ram_input);

	//REGISTER SET
	reg [15:0] A, D, IR;

	//ALU
	reg [15:0] alu_x, alu_y;
	wire [15:0] alu_out;
	wire zo, ng;
	alu al_unit(alu_out, zo, ng, alu_x, alu_y, IR[11], IR[10], IR[9], IR[8], IR[7], IR[6]);



	//PROGRAM COUNTER
	reg [15:0] pc_in;
	reg pc_inc, pc_load, pc_reset, pc_clock;
	wire [15:0] pc_out;
	pc instruction_pointer(pc_out, pc_inc, pc_load, pc_reset, pc_in, pc_clock);

	//RESETTING
	reg reset;
	initial begin
		reset = 0; #1000; reset = 1; #5;
	end

	//LOADING PROGRAM
	always @(negedge reset) begin
		ram_load = 1;
		ram_input = 5 ; ram_address = 1; #20;
		ram_input = 25; ram_address = 2; #20;
ram_input = 2; ram_address = 64; #20; //@R2 
ram_input = 16'b1111110000010000; ram_address = 65; #20; //D = M
ram_input = 4; ram_address = 66; #20; //@R4
ram_input = 16'b1110001100001000; ram_address = 67; #20; //M = D
ram_input = 3; ram_address = 68; #20; //@R3
ram_input = 16'b1110111101001000; ram_address = 69; #20; //M = 0
ram_input = 4; ram_address = 70; #20; //@R4 (LOOP)
ram_input = 16'b1111110000010000; ram_address = 71; #20; //D = M
ram_input = 82; ram_address = 72; #20; //@END 
ram_input = 16'b1110001100000010; ram_address = 73; #20; //D, JEQ
ram_input = 1; ram_address = 74; #20; //@R1
ram_input = 16'b1111110000010000; ram_address = 75; #20; //D = M
ram_input = 3; ram_address = 76; #20; //@R3
ram_input = 16'b1111000010001000; ram_address = 77; #20; //M = M + D
ram_input = 4; ram_address = 78; #20; //@R4
ram_input = 16'b1111110010001000; ram_address = 79; #20; //M = M - 1
ram_input = 70; ram_address = 80; #20; //@LOOP
ram_input = 16'b1110111111000111; ram_address = 81; #20; //0, JMP
ram_input = 0; ram_address = 82; #20; // (END)
		ram_load = 0; #10;
		pc_inc = 0; pc_load = 1; pc_reset = 0; pc_in = 64; pc_clock = 0; #5; pc_clock = 1; #5;
		pc_load = 0; pc_inc = 1;
		A = 0; D = 0; IR = 0; #5;
	end
	//...

	//Evaluating Jump condition
	and(j1, ng, IR[2]);
	and(j2, zo, IR[1]);
	and(j3, !zo, !ng, IR[0]);
	or(ju, j1, j2, j3);
	and(jump, IR[15], ju);

	//RUNNING PROGRAM
	integer i;
	always @(posedge reset) begin
		for(i=1;i>0;i=i+1) begin
			//FETCH
			ram_address = pc_out; #20;
			IR = ram_output; #5;
			//DECODE

			//EXECUTE
			if(!IR[15]) begin
				A = IR; #10;
			end
			else begin
				alu_x = D; #5;
				if(!IR[12]) begin
					alu_y = A; #5;
				end
				else begin
					ram_address = A; #20;
					alu_y = ram_output; #5;
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
					pc_load = 1; pc_in = A; pc_clock = 0; #5; pc_clock = 1; #5; pc_load = 0; #5;
				end
				else begin
				end
			end
			if(pc_out == 127) begin
				pc_inc = 0; #5;
			end
			if(!jump) begin
				pc_clock = 0; #5; pc_clock = 1; #5;
			end
		end
	end

endmodule

