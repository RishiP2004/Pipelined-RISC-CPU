module ExecutionStage (
	input clk,
	input [3:0] opcode,                	// Op code from Instruction Decode
	input [15:0] operand1,              // First operand
	input [15:0] operand2,              // Second operand
    
	input write_enable,                 // Write enable for register file
	input store_enable,                 // Store enable for memory
	input [3:0] reg_addr,               // Register address to write to
	input [3:0] mem_addr,               // Memory address for store/load
	input load_enable,                  // Load enable for memory

	output reg [15:0] result,           // Result of the operation
	output reg [3:0] reg_addr_out,      // Register address to write back
	output reg write_enable_out,        // Write enable for register file
	output reg [3:0] mem_addr_out,      // Memory address for store/load
	output reg store_enable_out,        // Store enable for memory
	output reg load_enable_out          // Load enable for memory
);

	wire [15:0] alu_result;              	// ALU result
	 
	// TODO: Not doing anything with these for now, split into CCR
	wire alu_zero;                       	// Zero flag from ALU
	wire alu_overflow;                   	// Overflow flag from ALU
	wire alu_negative;                   	// Negative flag from ALU
	
	ALU alu (
		.operand1(operand1),      
		.operand2(operand2),     
		.alu_op(opcode[1:0]),             	// Use the lower 2 bits of opcode for ALU operation
		.result(alu_result),             
		.zero(alu_zero),                  
		.overflow(alu_overflow),          
		.negative(alu_negative)           
	);

	always @(posedge clk) begin
		case (opcode)
			4'b0001: begin // ADD
				result <= alu_result; 				// Take the lower 8 bits of ALU result
			end
			4'b0010: begin // SUB
				result <= alu_result; 				// Take the lower 8 bits of ALU result
			end
			4'b0011: begin // LOAD (IMMEDIATE)
				result <= operand1;         		// Value we are loading
			end
			4'b0100: begin // STORE (IMMEDIATE)
				result <= operand1; 					// Value we are storing
			end
			4'b0101: begin // LOAD (FROM MEMORY)
				//Nothing, loads from memory		
			end
			4'b0110: begin // STORE (TO MEMORY)
				result <= operand1;
			end
			default: begin	// Default case (NOP or invalid)
				result <= 16'b0;       	
			end
		endcase
		reg_addr_out <= reg_addr;
		mem_addr_out <= mem_addr;
		write_enable_out <= write_enable;
		store_enable_out <= store_enable;
		load_enable_out <= load_enable;
	end

endmodule
