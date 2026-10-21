`timescale 1ns/1ps

module memory_unit_tb;

	reg clk;
	reg [7:0] prog_data;
	reg rst_n;
	reg [2:0] pc;
	reg run;
	reg prog_load;
	wire [2:0] load_addr;
	wire load_pulse;
	wire [7:0] instr;
	reg [7:0] test_program [0:7];  
	integer i; //used later in the code


	program_loader prog_ld ( //wiring up all components
		.clk(clk),
		.rst_n(rst_n),
		.prog_load(prog_load),
		.run(run),
		.load_addr(load_addr),
		.load_pulse(load_pulse)
	);

	program_memory prog_mem (
		.clk(clk),
		.load_addr(load_addr),
		.pc(pc),
		.prog_data(prog_data),
		.load_pulse(load_pulse),
		.instr(instr)
	);

	always 
	#5 clk = ~clk;

	//an internal register to keep track of all the instructions we want to see in play (as seen in the example section)
	initial begin

	    	$dumpfile("memory_test.vcd"); 
	    	$dumpvars(0, memory_unit_tb);
	
	        test_program[0] = 8'h03;
	        test_program[1] = 8'h60; 
	        test_program[2] = 8'h41; 
	        test_program[3] = 8'hA5; 
	        test_program[4] = 8'h81; 
	        test_program[5] = 8'hE0; 
	        test_program[6] = 8'hE0; 
	        test_program[7] = 8'hE0; 
	
	        clk       = 0;
	        rst_n     = 0;
	        prog_load = 0;
	        run       = 0;
	        prog_data = 8'h00;
	        pc        = 3'b000;
	
	        #15;
	        rst_n = 1;
	        #10;
	        for (i = 0; i < 8; i = i + 1) begin
	                prog_data <= test_program[i];
	                prog_load <= 1;
	                #10;
	                prog_load <= 0;
	                #10;
	        end

		#10;
        	for (i = 0; i < 8; i = i + 1) begin
            		pc <= pc + 1; //tick the program counter separately 
            	#20;        
        end
	$finish;
	end
	
endmodule