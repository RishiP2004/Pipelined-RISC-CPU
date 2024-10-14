//TODO: Split MemoryStage and RAM?
module MemoryStage (
	input clk,
	
	input [15:0] result,						// Result of the operation to store or pass on
	input [3:0] reg_addr,        			// Register address to write back
	input write_enable,						// Write enable signal for register file
	
	input [3:0] mem_addr,              	// Address for memory operation
	input store_enable,                	// Store enable signal from Execution
	input load_enable,                 	// Load enable signal from Execution

	output reg [15:0] result_out,     	// Result of the operation
	output reg [3:0] reg_addr_out,      // Register address to write back
	output reg write_enable_out			// Write enable signal for register file
);

	// 32 bytes of memory (16 registers, 16 bits of storage each)
	reg [15:0] memory [0:15];   

	always @(posedge clk) begin
		result_out <= result;					// Pass on 
		
		if (store_enable) begin
			memory[mem_addr] <= result; 		// Write to memory
		end
		else if (load_enable) begin
			result_out <= memory[mem_addr]; 	// Load data from memory to result
		end
		reg_addr_out <= reg_addr;
		write_enable_out <= write_enable;
	end
endmodule
