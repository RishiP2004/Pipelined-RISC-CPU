`timescale 1ns / 1ps

module IF_ID_Register_tb;
	reg clk;
	reg reset;
	reg [15:0] instruction_in;
	reg [15:0] pc_in;

	wire [15:0] instruction_out;
	wire [15:0] pc_out;

	IF_ID_Register uut (
		.clk(clk),
		.reset(reset),
		.instruction_in(instruction_in),
		.pc_in(pc_in),
		.instruction_out(instruction_out),
		.pc_out(pc_out)
	);

	always begin
		#25 clk = ~clk; 	// Toggle clock every 25ns (50ns clock period)
	end

	initial begin
		clk = 0;
		reset = 0;
		instruction_in = 16'b0;
		pc_in = 16'b0;

		// Test Reset Condition
		#50;
		reset = 1;	// Assert reset
		#50;
		reset = 0;	// Deassert reset

		#50;
		instruction_in = 16'h1234;	// Example instruction
		pc_in = 16'h0001;				// Example PC value
		#50;	// Wait for clock edge

		// Check outputs
		$display("Test 1: instruction_out = %h", instruction_out); 
		$display("Test 1: pc_out = %h", pc_out);	// Should print 0001

		#50; // Wait for clock edge
		
		instruction_in = 16'h5678;	// Change instruction
		pc_in = 16'h0011;				// Change PC
		#50;	// Wait for clock edge

		// Check outputs
		$display("Test 1: instruction_out = %h", instruction_out); 
		$display("Test 1: pc_out = %h", pc_out);	// Should print 0001
	
		#50;	// Wait for clock edge
		$stop;
	end
endmodule
