`timescale 1ns / 1ps

module ExecutionStage_tb;
	reg clk;
	reg [3:0] opcode;
	reg [15:0] operand1;
	reg [15:0] operand2;

	reg write_enable;
	reg store_enable;
	reg [3:0] reg_addr;
	reg [3:0] mem_addr;
	reg load_enable;

	wire [15:0] result;
	wire [3:0] reg_addr_out;
	wire write_enable_out;
	wire [3:0] mem_addr_out;
	wire store_enable_out;
	wire load_enable_out;

	ExecutionStage uut (
		.clk(clk),
		.opcode(opcode),
		.operand1(operand1),
		.operand2(operand2),
		.write_enable(write_enable),
		.store_enable(store_enable),
		.reg_addr(reg_addr),
		.mem_addr(mem_addr),
		.load_enable(load_enable),
		.result(result),
		.reg_addr_out(reg_addr_out),
		.write_enable_out(write_enable_out),
		.mem_addr_out(mem_addr_out),
		.store_enable_out(store_enable_out),
		.load_enable_out(load_enable_out)
	);

	always begin
		#10 clk = ~clk;  // Toggle clock every 10ns (20ns clock period)
	end

	initial begin
		clk = 0;
		opcode = 4'b0; 	// Default opcode
		operand1 = 16'b0; // Default operand1
		operand2 = 16'b0; // Default operand2
		write_enable = 0; // Default write_enable
		store_enable = 0; // Default store_enable
		reg_addr = 4'b0; 	// Default register address
		mem_addr = 4'b0; 	// Default memory address
		load_enable = 0; 	// Default load_enable

		// Test ADD operation
		#20;
		opcode = 4'b0001; 	// ADD
		operand1 = 16'd5;  	// Operand 1: 5
		operand2 = 16'd3;  	// Operand 2: 3
		write_enable = 1; 	// Enable write
		reg_addr = 4'b0001; 	// Set register address
		#20; // Wait for one clock cycle
		$display("ADD result: %d, reg_addr_out: %d, write_enable_out: %b", result, reg_addr_out, write_enable_out); // Expect 8

		// Test SUB operation
		#20;
		opcode = 4'b0010; 	// SUB
		operand1 = 16'd10; 	// Operand 1: 10
		operand2 = 16'd4;  	// Operand 2: 4
		write_enable = 1; 	// Enable write
		reg_addr = 4'b0010; 	// Set register address
		#20; // Wait for one clock cycle
		$display("SUB result: %d, reg_addr_out: %d, write_enable_out: %b", result, reg_addr_out, write_enable_out); // Expect 6

		// Test LOAD operation
		#20;
		opcode = 4'b0011; 	// LOAD
		operand1 = 16'd25; 	// Immediate value to load
		write_enable = 1; 	// Enable write
		reg_addr = 4'b0011; 	// Set register address
		#20; // Wait for one clock cycle
		$display("LOAD result: %d, reg_addr_out: %d, write_enable_out: %b", result, reg_addr_out, write_enable_out); // Expect 25

		// Test STORE operation
		#20;
		opcode = 4'b0100; 	// STORE
		operand1 = 16'd15; 	// Value to store
		write_enable = 1; 	// Enable write
		store_enable = 1; 	// Enable store
		reg_addr = 4'b0000; 	// Set register address
		mem_addr = 4'b0001; 	// Set memory address
		#20; // Wait for one clock cycle
		$display("STORE result: %d, mem_addr_out: %d, store_enable_out: %b", result, mem_addr_out, store_enable_out); // Expect 15

		// Test default case
		#20;
		opcode = 4'b1111; // Invalid opcode
		#20; // Wait for one clock cycle
		$display("Default result: %d, reg_addr_out: %d, write_enable_out: %b", result, reg_addr_out, write_enable_out); // Expect 0

		// End simulation
		#20;
		$stop;
	end

endmodule
