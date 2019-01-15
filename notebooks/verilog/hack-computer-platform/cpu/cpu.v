module cpu(output reg [6:0] ram_add,
	output reg [15:0] ram_in,
	output reg ram_write,
	input [15:0] ram_out,
	input reset);

	//reg [15:0] ram_out; reg [6:0] ram_add; reg ram_write; reg ram_clock;

	reg [15:0] pc;

	reg [15:0] IR, A, D, M;

	//RESETTING
	always @(negedge reset) begin
		pc = 64;
	end

	//ALU
	reg [15:0] alu_x, alu_y;
	wire [15:0] alu_out;
	wire zo, ng;
	reg c1, c2, c3, c4, c5, c6;
	alu alu_instance(alu_out, zo, ng, alu_x, alu_y, c1, c2, c3, c4, c5, c6);

	reg isAins, selM, d1, d2, d3, j1, j2, j3;
	wire jump;
	and(yj1, j1, ng); and(yj2, j2, zo); and(yj3, j3, !zo, !ng); or(jump, j1, j2, j3);
	always @(posedge reset) begin
		forever begin
			//FETCH
			ram_add = pc; #1;
			IR = ram_out;
			//DECODE
			isAins = IR[15]; selM = IR[12]; d1 = IR[5]; d2 = IR[4]; d3 = IR[3]; j1 = IR[2]; j2 = IR[1]; j3 = IR[0];
			
			//EXECUTE
			if(isAins) begin
				A = IR;
			end
			else begin
				alu_x = D;
				if(selM) begin
					alu_y = M;
				end
				else begin
					alu_y = A;
				end
				c1 = IR[11];
				c2 = IR[10];
				c3 = IR[9];
				c4 = IR[8];
				c5 = IR[7];
				c6 = IR[6];
				if(d1) begin
					A = alu_out;
				end
				if(d2) begin
					D = alu_out;
				end
				if(d3) begin
					ram_add = A;
					ram_in = alu_out;
					ram_write = 1;
					ram_clock = 0; #5; ram_clock = 1; #5;
					ram_write = 0;
				end
				if(jump) begin
					pc = A;
				end
				else begin
					if(pc != 127) begin
						pc = pc + 1;
					end
				end
			end

		end
	end
endmodule 
