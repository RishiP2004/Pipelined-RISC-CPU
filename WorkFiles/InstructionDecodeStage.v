// TODO: Split into Control Unit
module InstructionDecodeStage (
	input [15:0] instruction,			// Instruction from IFStae
	output reg [3:0] opcode,			// Op code to pass to Execute
	output reg [15:0] operand1,		// Value of operand1 from reg1
	output reg [15:0] operand2,		// Value of operand2 from reg2

	// Data from and to RegisterFile
	input [15:0] reg1_data,				// Data output from first register
	input [15:0] reg2_data,				// Data output from second register 
	output reg [3:0] read_reg1,		// First register address to read
	output reg [3:0] read_reg2,		// Second register address to read
	output reg [3:0] reg_addr,			// Address of the register
	output reg write_enable,			// Write to register file flag
	
	// Interacting to Memory
	output reg store_enable,			// If store to MEM enabled
	output reg load_enable,				// If loading from MEM enabled
	output reg [3:0] mem_addr			// Address the data goes to (MEM)
);

	always @(*) begin
		opcode = instruction[15:12];
		read_reg1 = instruction[11:8];
		read_reg2 = instruction[7:4];
		operand1 = 16'b0;            			// Default operand1
		operand2 = 16'b0;            			// Default operand2
		write_enable = 0;                  	// Default write_enable
		store_enable = 0;                  	// Default store_enable
		reg_addr = 4'b0000;                	// Default reg address
		mem_addr = 4'b0000;                	// Default mem address
		
		case (opcode)
			4'b0001: begin // ADD 
				operand1 = reg1_data;	     	// Get data from reg1
				operand2 = reg2_data;        	// Get data from reg2
				reg_addr = instruction[3:0];	// Register it gets stored to after
				write_enable = 1;
			end
			
			4'b0010: begin // SUB 
				operand1 = reg1_data;         // Get data from reg1
				operand2 = reg2_data;         // Get data from reg2
				reg_addr = instruction[3:0];	// Register it gets stored to after
				write_enable = 1;
			end
            
			4'b0011: begin // LOAD to first input Reg (IMMEDIATE)
				write_enable = 1;
				reg_addr = read_reg1;
				operand1 = instruction[3:0]; 	// Data to be stored into Reg1 (IMMEDIATE)
			end
         
			4'b0100: begin // STORE to mem first input Reg (IMMEDIATE)
				store_enable = 1;					
				operand1 = read_reg1;			// Immediate data
				mem_addr = instruction[3:0];	// Address to store in memory to
			end
			
			4'b0101: begin // LOAD to Reg1 from memory
				write_enable = 1;			
				load_enable = 1;
				reg_addr = read_reg1;			// Register we are loading to
				mem_addr = instruction[3:0];	// Address to read in memory from
			end 
			
			4'b0111: begin // STORE Reg1 to memory
				store_enable = 1;
				operand1 = reg1_data;  				// Get data from Reg1
				mem_addr = instruction[3:0];		// Address to store in memory to
			end 
			
			default: begin	// Default case (NOP or invalid)
				operand1 = 16'b0;       		
				operand2 = 16'b0;
				write_enable = 0;
				store_enable = 0;
			end
		endcase
	end

endmodule