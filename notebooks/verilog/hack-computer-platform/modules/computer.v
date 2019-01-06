module computer();
	
	reg reset;
	reg clock;
	
	initial begin
		reset = 1; #50; reset = 0; #150;
		reset = 1;
	end
	always begin
		clock = 0; #100; clock = 1; #100;
	end
	


	integer i; //Machine cycle counter


	//ALU
	reg [15:0] alu_in_port_1, alu_in_port_2;
	reg alu_control_in_1,
		alu_control_in_2,
		alu_control_in_3,
		alu_control_in_4,
		alu_control_in_5,
		alu_control_in_6;
	wire [15:0] alu_out_port;
	wire alu_out_neg, alu_out_zero;
	a2q9_ALU alu_unit(alu_out_port,
			alu_out_zero,
			alu_out_neg,
			alu_in_port_1,
			alu_in_port_2,
			alu_control_in_1,
			alu_control_in_2,
			alu_control_in_3,
			alu_control_in_4,
			alu_control_in_5,
			alu_control_in_6);

	//RAM
	reg [15:0] ram_input;
	reg [5:0] ram_address;
	reg ram_read_enable, ram_write_enable;
	wire [15:0] ram_out;
	reg ram_reset, ram_clock;
	mem_ram_sync ram(ram_clock,
				ram_reset,
				ram_read_enable,
				ram_write_enable,
				ram_address,
				ram_input,
				ram_out);
			

	//PROGRAM COUNTER
	reg [15:0] pc_in;
	reg pc_inc, pc_load, pc_reset, pc_clock;
	wire [15:0] pc_out;
	program_counter pc(pc_out, 
				pc_inc, 
				pc_load, 
				pc_reset, 
				pc_in, 
				pc_clock);

	//INSTRUCTION REGISTER and other registers
	reg [15:0] IR;
	reg [15:0] A;
	reg [15:0] D;

	//Decode registers
	reg is_c_instruction;
	reg select_alu_in_A;
	reg [5:0] alu_controls;
	reg [2:0] destination;
	reg [2:0] jump;

	//Resetting the Computer
	always @(negedge reset) begin
		//Resetting pc to base address
		pc_inc = 1'b0; pc_load = 1'b0; pc_reset = 1'b1;
		pc_in = 20; pc_clock = 0; #5; pc_clock = 1; #5;
		pc_reset = 1'b0; pc_load = 1; pc_clock = 0; #5; pc_clock = 1; #5; 
		pc_load = 0; pc_inc = 1; #5;
		
		D = 0;

		//Resetting ram
		ram_write_enable = 1;
		ram_read_enable = 0;
		ram_input = 1'd0;
		ram_address = 1'd0;
		ram_reset = 0;
		ram_clock = 0; #5; ram_clock = 1; #5;
		ram_reset = 1; ram_clock = 0; #5; ram_clock = 1; #5;


		//Loading initial values in ram for computation. i.e R1, R2
		ram_address = 1; ram_input = 8;
		ram_clock = 0; #5; ram_clock = 1; #5;

		ram_address = 2; ram_input = 8;
		ram_clock = 0; #5; ram_clock = 1; #5;				

		//Loading program, Put your program here. Last 40 lines of ram [20:63] are to be used for program. 
		ram_address = 20; ram_input = 1;
		ram_clock = 0; #5; ram_clock = 1; #5;

		ram_address = 21; ram_input = 16'b1110110000010000;
		ram_clock = 0; #5; ram_clock = 1; #5;

		ram_address = 22; ram_input = 2;
		ram_clock = 0; #5; ram_clock = 1; #5;

		ram_address = 23; ram_input = 16'b1110000010010000;
		ram_clock = 0; #5; ram_clock = 1; #5;

		ram_address = 24; ram_input = 3;
		ram_clock = 0; #5; ram_clock = 1; #5;

		ram_address = 25; ram_input = 16'b1110001100001000;
		ram_clock = 0; #5; ram_clock = 1; #5;

		//...

		ram_write_enable = 0; ram_clock = 0; #5; ram_clock = 1; #5;
	end

	//Clock cycle should be long enough to contain internal clock cycles
	always @(posedge(clock)) begin
		if(reset) begin
			for(i=0;i<3;i=i+1) begin
				if(i==0) begin
					//Fetch
					ram_read_enable = 1; ram_address = pc_out[6:0];
					ram_clock = 0; #5; ram_clock = 1; #5;
					IR = ram_out; #5;
				end
				else if(i==1) begin
					//Decode
					is_c_instruction = IR[15];
					select_alu_in_A = IR[12];
					alu_control_in_1 = IR[11];
					alu_control_in_2 = IR[10];
					alu_control_in_3 = IR[9];
					alu_control_in_4 = IR[8];
					alu_control_in_5 = IR[7];
					alu_control_in_6 = IR[6];
					destination = IR[5:3];
					jump = IR[2:0];
					#5;
				end
				else if(i==2) begin
					//Execute
					if(!is_c_instruction) begin
						A = IR;
						#5;
					end
					else begin
						if(select_alu_in_A) begin
							alu_in_port_2 = A;
							#5;
						end 
						else begin
							ram_read_enable = 1;
							ram_address = A;
							ram_clock = 0; #5; ram_clock = 1; #5;
							alu_in_port_2 = ram_out;
							#5;
						end
						alu_in_port_1 = D;
						#5;
						if(destination[0]) begin
							ram_write_enable = 1; ram_read_enable = 0; ram_address = A;
							ram_input = alu_out_port;
							ram_clock = 0; #5; ram_clock = 1; #5;
							ram_write_enable = 0; ram_read_enable = 1;
							#5;
						end
						if(destination[1]) begin
							D = alu_out_port;
							#5;
						end
						if(destination[2]) begin
							A = alu_out_port;
							#5;
						end
						#5;
					end
					//End of execute
				end
			end

			//Increment PC
			pc_clock = 0; #5; pc_clock = 1; #5;
		end
	end

endmodule
		

