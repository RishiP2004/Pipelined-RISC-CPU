`timescale 1ns / 1ps

module InstructionFetchStage_tb;
	reg clk;
	reg reset;
	
	wire [2:0] pc;
	wire [15:0] instruction;
	
	InstructionFetchStage uut (
		.clk(clk),
		.reset(reset),
		.pc(pc),
		.instruction(instruction)
	);
	
	always begin
		#10 clk = ~clk; 	// Toggle clock every 10ns (20ns clock period)
   end
	
	initial begin
		clk = 0;
		reset = 1;
		
		#20						// Wait 20ns
		
		reset = 0;
		#200						// Wait 200ns
		
		$stop;
	end
	
	initial begin
		$monitor("At time %t, PC = %d, Instruction = %b", $time, pc, instruction);
	end
	
endmodule