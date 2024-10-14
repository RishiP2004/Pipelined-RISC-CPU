module ID_EX_Register_tb;
	reg clk;
	reg reset;
	reg [3:0] opcode_in;
	reg [15:0] operand1_in;
	reg [15:0] operand2_in;
	reg [3:0] reg_addr_in;
	reg write_enable_in;
	reg store_enable_in;
	reg load_enable_in;
	reg [3:0] mem_addr_in;

	wire [3:0] opcode_out;
	wire [15:0] operand1_out;
	wire [15:0] operand2_out;
	wire [3:0] reg_addr_out;
	wire write_enable_out;
	wire store_enable_out;
	wire load_enable_out;
	wire [3:0] mem_addr_out;

	ID_EX_Register uut (
		.clk(clk),
		.reset(reset),
		.opcode_in(opcode_in),
		.operand1_in(operand1_in),
		.operand2_in(operand2_in),
		.reg_addr_in(reg_addr_in),
		.write_enable_in(write_enable_in),
		.store_enable_in(store_enable_in),
		.load_enable_in(load_enable_in),
		.mem_addr_in(mem_addr_in),
		.opcode_out(opcode_out),
		.operand1_out(operand1_out),
		.operand2_out(operand2_out),
		.reg_addr_out(reg_addr_out),
		.write_enable_out(write_enable_out),
		.store_enable_out(store_enable_out),
		.load_enable_out(load_enable_out),
		.mem_addr_out(mem_addr_out)
	);

	always begin
		#10 clk = ~clk;  // Toggle clock every 10ns (20ns clock period)
	end

	initial begin
		// Initialize Inputs
		clk = 0;
		reset = 0;
		opcode_in = 4'b0;
		operand1_in = 16'b0;
		operand2_in = 16'b0;
		reg_addr_in = 4'b0;
		write_enable_in = 0;
		store_enable_in = 0;
		load_enable_in = 0;
		mem_addr_in = 4'b0;

		// Apply reset
		reset = 1;
		#20;
		reset = 0;

		// Apply test values
		opcode_in = 4'b1101;     	// Test opcode
		operand1_in = 16'hAA;  		// Test operand1
		operand2_in = 16'h55;   	// Test operand2
		reg_addr_in = 4'b1010;  	// Test reg address
		write_enable_in = 1;     	// Enable write
		store_enable_in = 1;   		// Enable store
		load_enable_in = 0;      	// Disable load
		mem_addr_in = 4'b1110;  	// Test memory address

		#40;  // Wait for 2 clock cycles
		$display("At time %t:", $time);
		$display("Opcode: %b, Operand1: %h, Operand2: %h, Reg Addr: %b, Write Enable: %b, Store Enable: %b, Load Enable: %b, Mem Addr: %b", 
			opcode_out, operand1_out, operand2_out, reg_addr_out, write_enable_out, store_enable_out, load_enable_out, mem_addr_out);
			
		// Change test values
		opcode_in = 4'b1010;
		operand1_in = 16'hFF;
		operand2_in = 16'h0F;
		reg_addr_in = 4'b1001;
		write_enable_in = 0;
		store_enable_in = 0;
		load_enable_in = 1;       
		mem_addr_in = 4'b0110;
		
		#40;
		$display("At time %t:", $time);
		$display("Opcode: %b, Operand1: %h, Operand2: %h, Reg Addr: %b, Write Enable: %b, Store Enable: %b, Load Enable: %b, Mem Addr: %b", 
			opcode_out, operand1_out, operand2_out, reg_addr_out, write_enable_out, store_enable_out, load_enable_out, mem_addr_out);
		
		#40;
		$stop;
	end

endmodule
