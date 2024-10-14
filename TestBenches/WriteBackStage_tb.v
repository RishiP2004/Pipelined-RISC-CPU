module WritebackStage_tb;
	reg clk;
	reg [7:0] result_wb;
	reg write_enable_wb;
	reg [3:0] reg_addr_wb;

	wire [7:0] write_data;
	wire [3:0] reg_addr_out;
	wire write_enable_out;

	WritebackStage dut (
		.clk(clk),
		.result_wb(result_wb),
		.write_enable_wb(write_enable_wb),
		.load_enable_wb(load_enable_wb),
		.reg_addr_wb(reg_addr_wb),
		.write_data(write_data),
		.reg_addr_out(reg_addr_out),
		.write_enable_out(write_enable_out)
	);
	
	always begin
		#10 clk = ~clk; 	// Toggle clock every 25ns (50ns clock period)
	end
	
	initial begin
		clk = 0;
		// Normal register write with write_enable = 1
		result_wb = 8'b10101010;
		write_enable_wb = 1;
		reg_addr_wb = 4'b0011;
		#20;  		// Wait for clock edge
		$display("Test 1: write_data = %b, reg_addr_out = %b, write_enable_out = %b", write_data, reg_addr_out, write_enable_out);

		// No write with write_enable = 0
		result_wb = 8'b11001100;
		write_enable_wb = 0;
		reg_addr_wb = 4'b0101;
		#20;			// Wait for clock edge

		// Check the output
		$display("Test 2: write_data = %b, reg_addr_out = %b, write_enable_out = %b", write_data, reg_addr_out, write_enable_out);

		// Change register address, write_enable = 1
		result_wb = 8'b11110000;
		write_enable_wb = 1;
		reg_addr_wb = 4'b0110;
		#20;			// Wait for clock edge

		$display("Test 3: write_data = %b, reg_addr_out = %b, write_enable_out = %b", write_data, reg_addr_out, write_enable_out);

		$finish;
	end

endmodule
