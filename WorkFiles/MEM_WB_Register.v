module MEM_WB_Register (
	input clk,                          
	input reset,                        
													
	// Inputs from MEM
	input [15:0] result_in,     			// Result from either ALU, immediate or MEM
	input [3:0] reg_addr_in,           	// Register address for write-back 
	input write_enable_in,             	// Write enable
	
	// Outputs to Writeback stage
	output reg [15:0] result_out,     	// Result from either ALU, immediate or MEM
	output reg [3:0] reg_addr_out,     	// Register address for Writeback
	output reg write_enable_out	   	// Write enable
	
);

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			// Reset all outputs to default values
			result_out <= 16'b0;
			reg_addr_out <= 4'b0;      
			write_enable_out <= 1'b0;  
		end else begin
			result_out <= result_in;     
			reg_addr_out <= reg_addr_in;  
			write_enable_out <= write_enable_in; 
		end
	end

endmodule
