module IF_ID_Register (
	input clk,
	input reset,
	// Inputs from IF
	input [15:0] instruction_in,			// Instruction
	input [2:0] pc_in,						// PC 
	// Outputs to ID
	output reg [15:0] instruction_out,	// Instruction 
	output reg [2:0] pc_out					// PC 
);
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			instruction_out <= 16'b0;
			pc_out <= 3'b0;
		end else begin
			instruction_out <= instruction_in;
			pc_out <= pc_in;
		end
	end
endmodule
