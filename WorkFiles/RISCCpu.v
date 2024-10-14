module RISCCPU (
	input clk,
	input reset,
	output reg [15:0] result
);
	// InstructionFetchStage wires
	wire [2:0] if_pc;
	wire [15:0] if_instruction;
	
	// IF_ID Wires
	wire [2:0] id_pc;
	wire [15:0] id_instruction;

	// InstructionDecodeStage wires
	wire [3:0] opcode_id;
	wire [15:0] operand1_id;
	wire [15:0] operand2_id;
	wire [3:0] read_reg1;		// Instant reading from Register
	wire [3:0] read_reg2;		// Instant reading from Register
	wire [3:0] reg_addr_id;
	wire write_enable_id;
	wire store_enable_id;
	wire load_enable_id;
	wire [3:0] mem_addr_id;
	
	// ExecutionStage wires
	wire [3:0] opcode_ex;
	wire [15:0] operand1_ex;
	wire [15:0] operand2_ex;
	wire [3:0] reg_addr_ex;
	wire write_enable_ex;
	wire store_enable_ex;
	wire load_enable_ex;
	wire [3:0] mem_addr_ex;
	wire [15:0] result_ex;
	wire [3:0] reg_addr_ex_out;
	wire write_enable_ex_out;
	wire [3:0] mem_addr_ex_out;
	wire store_enable_ex_out;
	wire load_enable_ex_out;
	
	// MemoryStage wires
	wire [15:0] result_mem;
	wire [3:0] reg_addr_mem;
	wire [3:0] mem_addr;				// Final memory address destination
	wire write_enable_mem;
	wire store_enable_mem;
	wire load_enable_mem;
	wire [15:0] result_mem_out;
	wire [3:0] reg_addr_mem_out;
	wire write_enable_mem_out;
	
	wire [15:0] result_wb;
	wire [3:0] reg_addr_wb;
	wire write_enable_wb;
	
	wire [15:0] write_data;
	wire [3:0] reg_addr;
	wire [15:0] reg1_data;	// Instant reading from Register
	wire [15:0] reg2_data;	// Instant reading from Register
	
	wire write_enable;
	
	InstructionFetchStage instructionFetchStage (
		.clk(clk),
		.reset(reset),
		.pc(if_pc),
		.instruction(if_instruction)
	);
	
	IF_ID_Register if_ID_Register (
		.clk(clk),
		.reset(reset),
		.instruction_in(if_instruction),
		.pc_in(if_pc),
		
		.instruction_out(id_instruction),
		.pc_out(id_pc)
	);
	
	InstructionDecodeStage instructionDecodeStage (
		.instruction(id_instruction),
		.opcode(opcode_id),
		.operand1(operand1_id),
		.operand2(operand2_id),
		
		.reg1_data(reg1_data),
		.reg2_data(reg2_data),
		.read_reg1(read_reg1),
		.read_reg2(read_reg2),
		.reg_addr(reg_addr_id),
		.write_enable(write_enable_id),
		
		.store_enable(store_enable_id),
		.load_enable(load_enable_id),
		.mem_addr(mem_addr_id)
	);
	
	RegisterFile registerFile (
		.reset(reset),
		.clk(clk),
		.read_reg1(read_reg1),
		.read_reg2(read_reg2),
		.write_reg(reg_addr),               		// From WB Stage
		.write_data(write_data),          			// From WB Stage
		.write_enable(write_enable),					// From WB Stage
		.reg1_data(reg1_data),
		.reg2_data(reg2_data)
	);
	
	ID_EX_Register id_EX_Register (
		.clk(clk),
		.reset(reset),
		.opcode_in(opcode_id),
		.operand1_in(operand1_id),
		.operand2_in(operand2_id),
		.reg_addr_in(reg_addr_id),
		.write_enable_in(write_enable_id),
		.store_enable_in(store_enable_id),
		.load_enable_in(load_enable_id),
		.mem_addr_in(mem_addr_id),
		
		.opcode_out(opcode_ex),
		.operand1_out(operand1_ex),
		.operand2_out(operand2_ex),
		.reg_addr_out(reg_addr_ex),
		.write_enable_out(write_enable_ex),
		.store_enable_out(store_enable_ex),
		.load_enable_out(load_enable_ex),
		.mem_addr_out(mem_addr_ex)
	);
	
	ExecutionStage executionStage (
		.clk(clk),
		.opcode(opcode_ex),
		.operand1(operand1_ex),
		.operand2(operand2_ex),
		
		.write_enable(write_enable_ex),
		.store_enable(store_enable_ex),
		.reg_addr(reg_addr_ex),
		.mem_addr(mem_addr_ex),
		.load_enable(load_enable_ex),
		
		.result(result_ex),
		.reg_addr_out(reg_addr_ex_out),
		.write_enable_out(write_enable_ex_out),
		.mem_addr_out(mem_addr_ex_out),
		.store_enable_out(store_enable_ex_out),
		.load_enable_out(load_enable_ex_out)
	);
	
	EX_MEM_Register ex_MEM_Register (
		.clk(clk),
		.reset(reset),
		.result_in(result_ex),
		.reg_addr_in(reg_addr_ex_out),
		.write_enable_in(write_enable_ex_out),
		.mem_addr_in(mem_addr_ex_out),
		.store_enable_in(store_enable_ex_out),
		.load_enable_in(load_enable_ex_out),
		
		.result_out(result_mem),
		.reg_addr_out(reg_addr_mem),
		.write_enable_out(write_enable_mem),
		.mem_addr_out(mem_addr),
		.store_enable_out(store_enable_mem),
		.load_enable_out(load_enable_mem)
	);

	MemoryStage memoryStage (
		.clk(clk),
		.result(result_mem),
		.reg_addr(reg_addr_mem),
		.write_enable(write_enable_mem),
		.mem_addr(mem_addr),
		.store_enable(store_enable_mem),
		.load_enable(load_enable_mem),
		.result_out(result_mem_out),
		.reg_addr_out(reg_addr_mem_out),
		.write_enable_out(write_enable_mem_out)
	);
	
	MEM_WB_Register mem_WB_Register (
		.clk(clk),
		.reset(reset),
		.result_in(result_mem_out),
		.reg_addr_in(reg_addr_mem_out),
		.write_enable_in(write_enable_mem_out),
		
		.result_out(result_wb),
		.reg_addr_out(reg_addr_wb),
		.write_enable_out(write_enable_wb)
	);
	
	WriteBackStage writeBackStage (
		.clk(clk),
		.result(result_wb),
		.write_enable(write_enable_wb),
		.reg_addr(reg_addr_wb),
		
		.write_data(write_data),
		.reg_addr_out(reg_addr),
		.write_enable_out(write_enable)
	);
	
	always @(posedge clk or posedge reset) begin
		 if (reset) begin
			  result <= 16'b0;  			// Reset output
		 end else begin
			  result <= write_data;    // Assign write_data to result
		 end
	end
	
endmodule