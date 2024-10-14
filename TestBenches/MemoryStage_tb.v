`timescale 1ns / 1ps

module MemoryStage_tb;
	reg clk;
	reg [3:0] mem_addr;
	reg store_enable;
	reg load_enable;
	reg [15:0] result;          	// New input for the result
	reg [3:0] reg_addr;           // New input for the register address
	reg write_enable;             // New input for the write enable signal

	wire [15:0] result_out;     	// Output for the result
	wire [3:0] reg_addr_out;      // Output for the register address
	wire write_enable_out;        // Output for the write enable signal

	MemoryStage uut (
		.clk(clk),
		.mem_addr(mem_addr),
		.store_enable(store_enable),
		.load_enable(load_enable),
		.result(result),            	// Connect the result
		.reg_addr(reg_addr),        	// Connect the register address
		.write_enable(write_enable), 	// Connect the write enable signal
		.result_out(result_out),    	// Connect the result output
		.reg_addr_out(reg_addr_out), 	// Connect the register address output
		.write_enable_out(write_enable_out) // Connect the write enable output
	);

	always begin
		#25 clk = ~clk; 	// Toggle clock every 25ns (50ns clock period)
	end

	initial begin
		clk = 0;
		mem_addr = 4'b0;
		store_enable = 0;
		load_enable = 0;
		result = 16'b0;        	// Initialize the result
		reg_addr = 4'b0;      	// Initialize the register address
		write_enable = 0;     	// Initialize the write enable signal

		// Store data into memory at address 2
		#50;
		mem_addr = 4'd2;          	// Memory address 2
		store_enable = 1;
		load_enable = 0;
		result = 16'h10;          	// Set result
		#50;                      	// Wait for clock edge

		store_enable = 0;				// Disable store
		#50;								// Wait for clock edge

		// Load data from memory address 2
		load_enable = 1;
		mem_addr = 4'd2;          	// Memory address 2
		#50;								// Wait for clock edge
		$display("Data read from address 2: %h", result_out);  // Expect A5

		load_enable = 0;          	// Disable load
		#50;									

		$stop;
	end
endmodule
