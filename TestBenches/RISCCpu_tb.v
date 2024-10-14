module RISCCPU_tb;
	reg clk;
	reg reset;

	wire [15:0] result;

	RISCCPU uut (
		.clk(clk),
		.reset(reset),
		.result(result)
	);

	always begin
		#5 clk = ~clk;  // Toggle clock every 10ns (20ns clock period)
	end

	initial begin
		// Initialize Inputs
		clk = 0;
		reset = 0;

		// Apply reset
		reset = 1;
		#20; // Wait for two clock cycles
		reset = 0;

		#40; // Wait for 2 clock cycles

		#80; // Wait for more cycles to observe results

		// Display the result
		$display("At time %t: Result = %h", $time, result);
		
		
		#20; // Wait for two clock cycles

		#40; // Wait for 2 clock cycles

		#80; // Wait for more cycles to observe results

		// Display the result
		$display("At time %t: Result = %h", $time, result);

		
		
		#40; // Wait for more cycles
		$stop; // Stop simulation
	end

endmodule
