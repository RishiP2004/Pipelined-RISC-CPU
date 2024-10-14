module ID_EX_Register (
	input clk,                                                    
	input reset, 

	// Inputs from ID
	input [3:0] opcode_in,        				// Opcode 
	input [15:0] operand1_in,   					// Operand 1 
	input [15:0] operand2_in,          			// Operand 2 
	input [3:0] reg_addr_in,             		// Register address 
	input write_enable_in,              		// Write enabled signal
	input store_enable_in,               		// Store enabled signal 
	input load_enable_in,                		// Load enabled signal 
	input [3:0] mem_addr_in,              		// Memory address
	
	// Outputs to EX
	output reg [3:0] opcode_out,        		// Opcode
	output reg [15:0] operand1_out,     		// Operand 1
	output reg [15:0] operand2_out,       		// Operand 2
	output reg [3:0] reg_addr_out,       		// Register address 
	output reg write_enable_out,          		// Write enabled signal
	output reg store_enable_out,          		// Store enabled signal
	output reg load_enable_out,          		// Load enabled signal
	output reg [3:0] mem_addr_out        		// Memory address
);

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			opcode_out <= 4'b0;
			operand1_out <= 16'b0;
			operand2_out <= 16'b0;
			reg_addr_out <= 4'b0000;
			store_enable_out <= 1'b0;
			write_enable_out <= 1'b0;
			mem_addr_out <= 4'b0000;
			load_enable_out <= 1'b0;
		end else begin
			opcode_out <= opcode_in;
			operand1_out <= operand1_in;
			operand2_out <= operand2_in;
			reg_addr_out <= reg_addr_in;
			store_enable_out <= store_enable_in;
			write_enable_out <= write_enable_in;
			mem_addr_out <= mem_addr_in;
			load_enable_out <= load_enable_in;
		end
	end

endmodule
