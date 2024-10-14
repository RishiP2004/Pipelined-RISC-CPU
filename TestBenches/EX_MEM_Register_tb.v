module EX_MEM_Register_tb;

	reg clk;
	reg reset;
	reg [15:0] result_in;
	reg [3:0] reg_addr_in;
	reg [3:0] mem_addr_in;
	reg write_enable_in;
	reg store_enable_in;
	reg load_enable_in;

	wire [15:0] result_out;
	wire [3:0] reg_addr_out;
	wire [3:0] mem_addr_out;
	wire write_enable_out;
	wire store_enable_out;
	wire load_enable_out;

	EX_MEM_Register uut (
		.clk(clk),
		.reset(reset),
		.result_in(result_in),
		.reg_addr_in(reg_addr_in),
		.mem_addr_in(mem_addr_in),
		.write_enable_in(write_enable_in),
		.store_enable_in(store_enable_in),
		.load_enable_in(load_enable_in),
		.result_out(result_out),
		.reg_addr_out(reg_addr_out),
		.mem_addr_out(mem_addr_out),
		.write_enable_out(write_enable_out),
		.store_enable_out(store_enable_out),
		.load_enable_out(load_enable_out)
	);

	always begin
		#10 clk = ~clk;  // Toggle clock every 10ns (20ns clock period)
	end

	initial begin
		// Initialize Inputs
		clk = 0;
		reset = 0;
		result_in = 16'b0;
		reg_addr_in = 4'b0;
		mem_addr_in = 4'b0;
		write_enable_in = 0;
		store_enable_in = 0;
		load_enable_in = 0;

		// Apply reset
		reset = 1;
		#20;
		reset = 0;

		// Apply test values
		result_in = 16'hAB;       		// Test result
		reg_addr_in = 4'b1010;    		// Test reg address
		mem_addr_in = 4'b1110;   		// Test memory address
		write_enable_in = 1;     		// Enable write
		store_enable_in = 1;   			// Enable store
		load_enable_in = 0;     		// Disable load

		#40;  // Wait for 2 clock cycles
		$display("At time %t:", $time);
		$display("Result: %h, Reg Addr: %b, Mem Addr: %b, Write Enable: %b, Store Enable: %b, Load Enable: %b", 
			result_out, reg_addr_out, mem_addr_out, write_enable_out, store_enable_out, load_enable_out);
			
		// Change test values
		result_in = 16'hFF;
		reg_addr_in = 4'b1001;
		mem_addr_in = 4'b0110;
		write_enable_in = 0;    		// Disable write
		store_enable_in = 0; 			// Disable store
		load_enable_in = 1;     		// Enable load
		
		#40;
		$display("At time %t:", $time);
		$display("Result: %h, Reg Addr: %b, Mem Addr: %b, Write Enable: %b, Store Enable: %b, Load Enable: %b", 
			result_out, reg_addr_out, mem_addr_out, write_enable_out, store_enable_out, load_enable_out);
		
		#40;
		$stop;
	end

endmodule
