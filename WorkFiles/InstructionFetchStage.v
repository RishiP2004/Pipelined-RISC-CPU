module InstructionFetchStage (
	input clk,							
	input reset,
	output reg [2:0] pc,					// Program counter
	output reg [15:0] instruction		// Instruction to pass
);
	reg [2:0] pc_reg;						// 3-bit for 8 instruction max impl.
	wire [15:0] fetched_instruction;
	
	InstructionMemory instructionMemory (
		.pc(pc_reg),
		.instruction(fetched_instruction)
	);
	// Update or reset program counter block
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			pc_reg <= 3'b000;
		end else begin
			pc_reg <= pc_reg + 1;
		end
		instruction <= fetched_instruction;
		pc <= pc_reg;
	end
endmodule
	
	