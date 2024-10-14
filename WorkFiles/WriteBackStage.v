module WriteBackStage (
	input clk,
	input [15:0] result,          	// Result of operation
	input write_enable,          		// Write enable signal
	input [3:0] reg_addr,        		// Register address
	
	output reg [15:0] write_data,    // Data to be written back to the register file
	output reg [3:0] reg_addr_out,  	// Register address to write back to
	output reg write_enable_out     	// Write enable for the register file
);

	always @(posedge clk) begin
		write_data <= result;
		reg_addr_out <= reg_addr;
		write_enable_out <= write_enable;
	end

endmodule
