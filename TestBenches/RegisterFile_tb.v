`timescale 1ns / 1ps

module RegisterFile_tb;
	reg clk;
	reg reset;
	reg [3:0] read_reg1;
	reg [3:0] read_reg2;
	reg [3:0] write_reg;
	reg [15:0] write_data;
	reg write_enable;
	wire [15:0] reg1_data;
	wire [15:0] reg2_data;

	RegisterFile uut (
		.clk(clk),
		.reset(reset),
		.read_reg1(read_reg1),
		.read_reg2(read_reg2),
		.write_reg(write_reg),
		.write_data(write_data),
		.write_enable(write_enable),
		.reg1_data(reg1_data),
		.reg2_data(reg2_data)
	);

	always begin
		#10 clk = ~clk; // Toggle clock every 10ns (20ns clock period)
	end

	initial begin
		clk = 0;
		reset = 1;
		write_enable = 0;
		write_data = 16'b0;
		read_reg1 = 4'b0;
		read_reg2 = 4'b0001;
		write_reg = 4'b0;

		// Release reset
		#20 reset = 0;

		// Write to register 1
		write_enable = 1;
		write_data = 16'hA5; 		// Write A5 to register 0
		write_reg = 4'b0001;
		#20; 							// Wait for one clock cycle

		// Read from register 1
		write_enable = 0;
		read_reg1 = 4'b0001; 	// Read from register 0
		#20; 							// Wait for one clock cycle
		$display("Data from reg0: %h", reg1_data); // Should print A5


		// Test case 5: Reset
		reset = 1; // Activate reset
		#20;
		reset = 0; // Deactivate reset
		#20;

		// Verify reset
		read_reg1 = 4'b0; // Read from register 0
		#10; // Wait for one clock cycle
		$display("Data from reg0 after reset: %h", reg1_data); // Should print 00
    end
endmodule
