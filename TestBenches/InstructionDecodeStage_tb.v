`timescale 1ns / 1ps

module InstructionDecodeStage_tb;
	reg [15:0] instruction;         
	reg [15:0] reg1_data;            
	reg [15:0] reg2_data;            
	wire [3:0] opcode;              
	wire [15:0] operand1;            
	wire [15:0] operand2;            
	wire [3:0] read_reg1;          
	wire [3:0] read_reg2;          
	wire write_enable;               
	wire [3:0] reg_addr;            
	wire store_enable;              
	wire load_enable;               
	wire [3:0] mem_addr;           

	InstructionDecodeStage uut (
		.instruction(instruction),
		.opcode(opcode),
		.operand1(operand1),
		.operand2(operand2),
		.reg1_data(reg1_data),
		.reg2_data(reg2_data),
		.read_reg1(read_reg1),
		.read_reg2(read_reg2),
		.write_enable(write_enable),
		.reg_addr(reg_addr),
		.store_enable(store_enable),
		.load_enable(load_enable),
		.mem_addr(mem_addr)
	);

	initial begin
		// Set up test register data
		reg1_data = 16'd5;   		// Example value (5) in register 1
		reg2_data = 16'd8;  			// Example value (10) in register 2
        
		// Test LOAD R0 IMMEDIATE VALUE 2
		instruction = 16'b0011_0000_0010_0000; // LOAD R0, IMMEDIATE VALUE 2
		#10; 							// Wait 10ns
		$display("Test LOAD R0, VALUE 2:");
		$display("Opcode: %b, RegAddr: %b, Operand1: %d, WriteEnable: %b", opcode, reg_addr, operand1, write_enable);
        
		// Test ADD instruction
		instruction = 16'b0001_0001_0010_0001; // ADD R1, R2 (reg1_data and reg2_data)
		#10;							// Wait 10ns
		$display("Test ADD R1, R2:");
		$display("Opcode: %b, RegAddr: %b, Operand1: %d, Operand2: %d, WriteEnable: %b", opcode, reg_addr, operand1, operand2, write_enable);
        
		// Test SUB instruction
		instruction = 16'b0010_0001_0010_0001; // SUB R1, R2 (reg1_data and reg2_data)
		#10;							// Wait 10ns
		$display("Test SUB R1, R2:");
		$display("Opcode: %b, RegAddr: %b, Operand1: %d, Operand2: %d, WriteEnable: %b", opcode, reg_addr, operand1, operand2, write_enable);
        
		// Test STORE instruction
		instruction = 16'b0100_0000_0001_0000; // STORE R0 to MEM Address 1
		#10;							// Wait 10ns
		$display("Test STORE R0 to MEM Address 1:");
		$display("Opcode: %b, RegAddr: %b, Operand1: %d, StoreEnable: %b, MemAddr: %b", opcode, reg_addr, operand1, store_enable, mem_addr);
        
		// Test LOAD instruction from memory
		instruction = 16'b0101_0000_0001_0000; // LOAD from MEM Address 1 to R0
		#10;							// Wait 10ns
		$monitor("Test LOAD from MEM Address 1 to R0:");
		$monitor("Opcode: %b, RegAddr: %b, LoadEnable: %b, MemAddr: %b", opcode, reg_addr, load_enable, mem_addr);

		$stop;
	end
endmodule
