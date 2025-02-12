module ALU (
	input [15:0] operand1,           // First operand
	input [15:0] operand2,           // Second operand
	input [1:0] alu_op,             	// ALU operation control signal
	output reg [15:0] result,        // ALU result
	output reg zero,                 // Zero flag
	output reg overflow,           	// Overflow flag
	output reg negative              // Negative flag
);
	always @(*) begin
		case (alu_op)
			2'b01: begin									// ADD
				result = operand1 + operand2;  		
			end					
			2'b10: result = operand1 - operand2;  	// SUB
			default: result = 16'b0;              	// Default case
		endcase

		// Set the zero flag
		zero = (result == 16'b0);

		// Set the overflow flag (for ADD/SUB example)
		overflow = (alu_op == 2'b01 && (operand1[15] == operand2[15]) && (result[15] != operand1[15])) || 	// ADD overflow
                    (alu_op == 2'b10 && (operand1[15] != operand2[15]) && (result[15] != operand1[15])); 	// SUB overflow
		negative = result[15];  // The MSB indicates negativity in two's complement
		
    end
endmodule
