`timescale 1ns / 1ps

module ALU_tb;
	reg [15:0] operand1;
	reg [15:0] operand2;
	reg [1:0] alu_op;
	wire [15:0] result;
	wire zero;
	wire overflow;
	wire negative;

	ALU uut (
		.operand1(operand1),
		.operand2(operand2),
		.alu_op(alu_op),
		.result(result),
		.zero(zero),
		.overflow(overflow),
		.negative(negative)
	);

	initial begin
		// Test ADD
		operand1 = 16'd5;
		operand2 = 16'd3;
		alu_op = 2'b00; 		// ADD
		#10; 						// Wait 10ns
		$display("ADD (5 + 3) Result: %d, Zero: %b, Overflow: %b, Negative: %b", result, zero, overflow, negative);

		// Test overflow in ADD
		operand1 = 16'd120;	// Max value before overflow
		operand2 = 16'd10; 	// Causes overflow
		alu_op = 2'b00; 		// ADD
		#10;						// Wait 10ns
		$display("ADD (120 + 10) Result: %d, Zero: %b, Overflow: %b, Negative: %b", result, zero, overflow, negative);

		// Test SUB
		operand1 = 16'd10;
		operand2 = 16'd4;
		alu_op = 2'b01; 		// SUB
		#10; 						// Wait 10ns
		$display("SUB (10 - 4) Result: %d, Zero: %b, Overflow: %b, Negative: %b", result, zero, overflow, negative);

		// Test negative result in SUB
		operand1 = 16'd3;
		operand2 = 16'd5; 	// 3 - 5 = -2
		alu_op = 2'b01; 		// SUB
		#10;						// Wait 10ns
		$display("SUB (3 - 5) Result: %d, Zero: %b, Overflow: %b, Negative: %b", $signed(result), zero, overflow, negative);

		// Test overflow in SUB
		operand1 = 16'd5;
		operand2 = 16'd10;	// 5 - 10 = -5 (check negative flag)
		alu_op = 2'b01; 		// SUB
		#10; 						// Wait 10ns
		$display("SUB (5 - 10) Result: %d, Zero: %b, Overflow: %b, Negative: %b", $signed(result), zero, overflow, negative);

		// End simulation
		$stop;
    end
endmodule
