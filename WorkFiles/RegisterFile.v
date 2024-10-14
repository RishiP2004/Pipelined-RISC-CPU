module RegisterFile (
	input clk,                    	// Clock signal
	input reset,                     // Reset signal
	input [3:0] read_reg1,         	// Address of the first register to read
	input [3:0] read_reg2,          	// Address of the second register to read
	input [3:0] write_reg,          	// Address of the register to write to
	input [15:0] write_data,         // Data to write into the register
	input write_enable,              // Write enable signal
	output reg [15:0] reg1_data,     // Data output of the first register
	output reg [15:0] reg2_data      // Data output of the second register
);
	// 16 registers, each 16 bits of storage (32 bytes)
	reg [15:0] registers [15:0];

	// Reading data from register
	always @(*) begin
		reg1_data <= registers[read_reg1]; // Read data from the first register
		reg2_data <= registers[read_reg2]; // Read data from the second register
	end
	
	integer i;
	
	// Writing to register block
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			for (i = 0; i < 16; i = i + 1) begin
				registers[i] <= 8'b0; // Reset each register to 0
			end
		end else if (write_enable) begin
			registers[write_reg] <= write_data; // Write data to the specified register
		end
	end
endmodule
