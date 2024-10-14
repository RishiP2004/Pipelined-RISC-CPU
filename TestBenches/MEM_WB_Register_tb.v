module MEM_WB_Register_tb;

	reg clk;
	reg reset;
	reg [15:0] result_in;
	reg [3:0] reg_addr_in;
	reg write_enable_in;

	wire [15:0] result_out;
	wire [3:0] reg_addr_out;
	wire write_enable_out;

	MEM_WB_Register uut (
		.clk(clk),
		.reset(reset),
		.result_in(result_in),
		.reg_addr_in(reg_addr_in),
		.write_enable_in(write_enable_in),
		.result_out(result_out),
		.reg_addr_out(reg_addr_out),
		.write_enable_out(write_enable_out)
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
		write_enable_in = 0;

		// Apply reset
		reset = 1;
		#20;
		reset = 0;

		// Apply test values
		result_in = 16'hAB;     		// Test result
		reg_addr_in = 4'b1010;   		// Test reg address
		write_enable_in = 1;   			// Enable write

		#40;  // Wait for 2 clock cycles
		$display("At time %t:", $time);
		$display("Result: %h, Reg Addr: %b, Write Enable: %b", 
			result_out, reg_addr_out, write_enable_out);
			
		// Change test values
		result_in = 16'hFF;
		reg_addr_in = 4'b1001;
		write_enable_in = 0;   			// Disable write
		
		#40;
		$display("At time %t:", $time);
		$display("Result: %h, Reg Addr: %b, Write Enable: %b", 
			result_out, reg_addr_out, write_enable_out);
		
		#40;
		$stop;
	end

endmodule
