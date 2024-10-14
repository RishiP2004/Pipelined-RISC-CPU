module EX_MEM_Register (
	input clk,                          
	input reset,                        
	
	// Inputs from EX
	input [15:0] result_in,     			// Result (ALU output or IMMEDIATE)
	input [3:0] reg_addr_in,   			// Register address for write-back 
	input [3:0] mem_addr_in,      		// Memory address
	input write_enable_in,      			// Write enable
	input store_enable_in,       			// Store enable
	input load_enable_in,         		// Load enable
	
	// Outputs to Memory
	output reg [15:0] result_out, 		// Result
	output reg [3:0] reg_addr_out, 		// Register address for Writeback stage
	output reg [3:0] mem_addr_out, 		// Memory address 
	output reg write_enable_out,    		// Write enable signal for Writeback stage
	output reg store_enable_out,    		// Store enable signal
	output reg load_enable_out     		// Load enable signal
);

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			// Reset all outputs to default values
			result_out <= 16'b0;
			load_enable_out <= 1'b0;
			store_enable_out <= 1'b0;
			mem_addr_out <= 4'b0;   
			reg_addr_out <= 4'b0;      
			write_enable_out <= 1'b0;    
		end else begin
			result_out <= result_in;   
			load_enable_out <= load_enable_in;
			store_enable_out <= store_enable_in;
			mem_addr_out <= mem_addr_in;     
			reg_addr_out <= reg_addr_in;  
			write_enable_out <= write_enable_in; 
		end
	end

endmodule
